import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/favorite_movie.dart';
import '../../domain/usecases/add_favorite_usecase.dart';
import '../../domain/usecases/get_favorites_usecase.dart';
import '../../domain/usecases/remove_favorite_usecase.dart';
import 'favorites_state.dart';

@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  final AddFavoriteUseCase addUseCase;
  final GetFavoritesUseCase getUseCase;
  final RemoveFavoriteUseCase removeUseCase;

  List<FavoriteMovie> _favorites = [];

  FavoritesCubit(this.addUseCase, this.getUseCase, this.removeUseCase)
      : super(FavoritesInitial());

  List<FavoriteMovie> get favorites => List.unmodifiable(_favorites);

  Future<void> load() async {
    emit(FavoritesLoading());
    try {
      final result = await getUseCase();
      _favorites = result;
      emit(FavoritesLoaded(List.from(_favorites)));
    } catch (e, st) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> add(FavoriteMovie favEntity) async {
    emit(FavoritesLoading());
    try {
      await addUseCase(favEntity);
      final updated = await getUseCase();
      _favorites = updated;
      emit(FavoritesActionSuccess(List.from(_favorites), 'Added to watch list'));
    } catch (e, st) {
      emit(FavoritesError('Failed to add favorite: $e'));
    }
  }

  Future<void> remove(String movieId) async {
    emit(FavoritesLoading());
    try {
      await removeUseCase(movieId);

      final updated = await getUseCase();
      _favorites = updated;

      emit(FavoritesActionSuccess(List.from(_favorites), 'Removed from watch list'));
    } catch (e, st) {
      emit(FavoritesError('Failed to remove favorite: $e'));
    }
  }

  bool isFavorite(String movieId) {
    return _favorites.any((m) => m.movieId == movieId);
  }
}
