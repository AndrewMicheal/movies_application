import 'package:injectable/injectable.dart';
import '../../data/data_sources/favorite_remote_data_source.dart';
import '../../data/model/favorite_movie_model.dart';
import '../../domain/entities/favorite_movie.dart';
import '../../domain/repositories/favorites_repository.dart';

@LazySingleton(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remote;
  FavoritesRepositoryImpl(this.remote);

  @override
  Future<void> addFavorite(FavoriteMovie movie) async {
    final model = FavoriteMovieModel.fromEntity(movie);
    await remote.addFavorite(model);
  }

  @override
  Future<List<FavoriteMovie>> getAllFavorites() async {
    final list = await remote.getAllFavorites();
    return list.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> removeFavorite(String movieId) async {
    await remote.removeFavorite(movieId);
  }

}
