import '../../domain/entities/favorite_movie.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteMovie> favorites;
  FavoritesLoaded(this.favorites);
}

class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}

class FavoritesActionSuccess extends FavoritesLoaded {
  final String message;
  FavoritesActionSuccess(List<FavoriteMovie> favorites, this.message) : super(favorites);
}
