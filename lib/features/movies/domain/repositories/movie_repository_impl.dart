import '../../data/data_sources/movies_remote_data_sources.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getMovies() async {
    return await remoteDataSource.fetchMovies();
  }
}
