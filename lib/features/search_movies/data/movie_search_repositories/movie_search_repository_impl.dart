import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/movie_search_failures/movie_search_failures.dart' hide Failure;
import '../../domain/movie_search_entities/movie_search_entities.dart';
import '../../domain/movie_search_repo/movie_search_repo.dart';
import '../movie_search_datasource/movie_search_remote_datasource.dart';

class MovieSearchRepositoryImpl implements MovieSearchRepository {
  final MovieSearchRemoteDataSource remoteDataSource;

  MovieSearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MovieSearchEntity>>> searchMovies(String query) async {
    try {
      final movies = await remoteDataSource.searchMovies(query);
      return Right(movies);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message) as Failure);
    } catch (e) {
      return Left(const ServerFailure('Failed to fetch movies') as Failure);
    }
  }
}