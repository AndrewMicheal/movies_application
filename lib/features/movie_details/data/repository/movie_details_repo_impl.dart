import 'package:dart_either/src/dart_either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/failure.dart';
import 'package:movies/features/movie_details/data/data_source/movie_details_data_source.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details.dart';
import 'package:movies/features/movie_details/domain/repository/movie_details_repo.dart';

@Injectable(as: MovieDetailsRepo)
class MovieDetailsRepoImpl implements MovieDetailsRepo {
  MovieDetailsDataSource movieDetailsDataSource;
  MovieDetailsRepoImpl(this.movieDetailsDataSource);

  @override
  Future<Either<Failure, MovieDetailsEntity>> movieDetails(int movieId) async {
    try {
      final response = await movieDetailsDataSource.movieDetails(movieId);
      return Right(response.toMovieDetails());
    } catch (e) {
      return Left(Failure(message: 'failed: $e'));
    }
  }
}
