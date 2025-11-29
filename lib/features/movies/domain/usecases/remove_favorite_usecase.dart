import 'package:injectable/injectable.dart';

import '../repositories/favorites_repository.dart';

@lazySingleton
class RemoveFavoriteUseCase {
  final FavoritesRepository repository;
  RemoveFavoriteUseCase(this.repository);

  Future<void> call(String movieId) => repository.removeFavorite(movieId);
}
