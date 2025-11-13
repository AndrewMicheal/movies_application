import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../features/movies/data/data_sources/movies_remote_data_sources.dart';
import '../features/movies/domain/repositories/movie_repository.dart';
import '../features/movies/domain/repositories/movie_repository_impl.dart';
import '../features/movies/domain/usecases/get_movies.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<MovieRepository>(
          () => MovieRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetMovies(sl()));
}
