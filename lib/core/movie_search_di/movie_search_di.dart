import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../features/search_movies/data/movie_search_datasource/movie_search_remote_datasource.dart';
import '../../features/search_movies/data/movie_search_repositories/movie_search_repository_impl.dart';
import '../../features/search_movies/domain/movie_search_repo/movie_search_repo.dart';
import '../../features/search_movies/domain/movie_search_usecase/movie_search_usecase.dart';
import '../../features/search_movies/presentation/movie_search_cubit/movie_search_cubit.dart';


final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External
  sl.registerLazySingleton<Dio>(() => Dio());

  // Data Sources
  sl.registerLazySingleton<MovieSearchRemoteDataSource>(
        () => MovieSearchRemoteDataSourceImpl(dio: sl()),
  );

  // Repository
  sl.registerLazySingleton<MovieSearchRepository>(
        () => MovieSearchRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton<SearchMoviesUseCase>(
        () => SearchMoviesUseCase(sl()),
  );

  // Cubit
  sl.registerFactory<MovieSearchCubit>(
        () => MovieSearchCubit(searchMoviesUseCase: sl()),
  );
}