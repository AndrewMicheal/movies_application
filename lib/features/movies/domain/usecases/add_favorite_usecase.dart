import 'package:injectable/injectable.dart';
import '../entities/favorite_movie.dart';
import '../repositories/favorites_repository.dart';

@lazySingleton
class AddFavoriteUseCase {
  final FavoritesRepository repository;
  AddFavoriteUseCase(this.repository);

  Future<void> call(FavoriteMovie movie) => repository.addFavorite(movie);
}
