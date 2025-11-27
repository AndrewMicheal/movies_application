
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/history_movie.dart';

abstract class HistoryLocalDataSource {
  Future<List<HistoryMovie>> loadHistory();
  Future<void> saveHistory(List<HistoryMovie> movies);
}

class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  final SharedPreferences prefs;
  static const _key = 'watch_history';

  HistoryLocalDataSourceImpl(this.prefs);

  @override
  Future<List<HistoryMovie>> loadHistory() async {
    final jsonStr = prefs.getString(_key);
    if (jsonStr == null || jsonStr.isEmpty) return [];
    try {
      final List<dynamic> list = json.decode(jsonStr);
      return list.map((e) => HistoryMovie.fromJson(Map<String, dynamic>.from(e))).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveHistory(List<HistoryMovie> movies) async {
    final list = movies.map((e) => e.toJson()).toList();
    await prefs.setString(_key, json.encode(list));
  }
}
