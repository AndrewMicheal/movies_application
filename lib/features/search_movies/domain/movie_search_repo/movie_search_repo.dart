import 'package:dartz/dartz.dart';
import 'package:movies/features/search_movies/domain/movie_search_entities/movie_search_entities.dart';

import '../../../../core/failure.dart';

abstract class MovieSearchRepository {
  Future<Either<Failure, List<MovieSearchEntity>>> searchMovies(String query);
}

