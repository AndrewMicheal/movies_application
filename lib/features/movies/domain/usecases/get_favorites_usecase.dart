import 'package:injectable/injectable.dart';

import '../entities/favorite_movie.dart';
import '../repositories/favorites_repository.dart';

@lazySingleton
class GetFavoritesUseCase {
  final FavoritesRepository repository;
  GetFavoritesUseCase(this.repository);

  Future<List<FavoriteMovie>> call() => repository.getAllFavorites();
}
