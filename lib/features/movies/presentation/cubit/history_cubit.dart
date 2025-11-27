
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/history_movie.dart';
import '../../domain/repositories/history_repository_impl.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepositoryImpl repo;
  HistoryCubit(this.repo) : super(HistoryInitial());

  Future<void> load() async {
    try {
      emit(HistoryLoading());
      final list = await repo.loadHistory();
      emit(HistoryLoaded(list));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> add(HistoryMovie movie) async {
    try {
      await repo.addToHistory(movie);
      final list = await repo.loadHistory();
      emit(HistoryLoaded(list));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> clear() async {
    await repo.clearHistory();
    emit(HistoryLoaded([]));
  }
}
