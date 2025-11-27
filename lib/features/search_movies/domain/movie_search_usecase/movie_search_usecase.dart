import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../movie_search_entities/movie_search_entities.dart';
import '../movie_search_repo/movie_search_repo.dart';

class SearchMoviesUseCase {
  final MovieSearchRepository repository;

  SearchMoviesUseCase(this.repository);

  Future<Either<Failure, List<MovieSearchEntity>>> call(String query) async {
    if (query.trim().isEmpty) {
      return const Right([]);
    }
    return await repository.searchMovies(query);
  }
}