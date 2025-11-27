
import '../../data/data_sources/history_local_data_source.dart';
import '../entities/history_movie.dart';

abstract class HistoryRepository {
  Future<List<HistoryMovie>> loadHistory();
  Future<void> addToHistory(HistoryMovie movie);
  Future<void> clearHistory();
}

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDataSource local;

  HistoryRepositoryImpl(this.local);

  @override
  Future<List<HistoryMovie>> loadHistory() => local.loadHistory();

  @override
  Future<void> addToHistory(HistoryMovie movie) async {
    final list = await local.loadHistory();

    list.removeWhere((m) => m.id == movie.id);
    list.insert(0, movie);


    final capped = list.length > 100 ? list.sublist(0, 100) : list;
    await local.saveHistory(capped);
  }

  @override
  Future<void> clearHistory() => local.saveHistory([]);
}
