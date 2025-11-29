import '../entities/favorite_movie.dart';

abstract class FavoritesRepository {
  Future<void> addFavorite(FavoriteMovie movie);
  Future<List<FavoriteMovie>> getAllFavorites();
  Future<void> removeFavorite(String movieId);
}
