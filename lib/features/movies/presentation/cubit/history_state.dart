
import '../../domain/entities/history_movie.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}
class HistoryLoading extends HistoryState {}
class HistoryLoaded extends HistoryState {
  final List<HistoryMovie> movies;
  HistoryLoaded(this.movies);
}
class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
}
