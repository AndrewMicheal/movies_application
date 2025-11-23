import 'package:dart_either/dart_either.dart';
import 'package:movies/core/failure.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details.dart';

abstract class MovieDetailsRepo {

  Future<Either<Failure , MovieDetailsEntity>> movieDetails(int movieId);
}