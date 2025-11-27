import '../entities/history_movie.dart';

abstract class HistoryRepository {
  Future<List<HistoryMovie>> load();
  Future<void> add(HistoryMovie movie);
  Future<void> clearAll();
}
