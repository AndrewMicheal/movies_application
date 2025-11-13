import 'package:dio/dio.dart';

import '../model/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> fetchMovies();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;
  MovieRemoteDataSourceImpl(this.dio);

  @override
  Future<List<MovieModel>> fetchMovies() async {
    final response = await dio.get('https://yts.mx/api/v2/list_movies.json');
    final data = response.data['data']['movies'] as List;
    return data.map((e) => MovieModel.fromJson(e)).toList();
  }
}
