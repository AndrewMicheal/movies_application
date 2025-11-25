import 'package:dio/dio.dart';
import 'package:movies/features/search_movies/data/movie_search_model/movie_search_model.dart';

abstract class MovieSearchRemoteDataSource {
  Future<List<MovieSearchModel>> searchMovies(String query);
}

class MovieSearchRemoteDataSourceImpl implements MovieSearchRemoteDataSource {
  final Dio dio;
  MovieSearchRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MovieSearchModel>> searchMovies(String query) async {
    try {
      final response = await dio.get(
        'https://yts.lt/api/v2/list_movies.json',
        queryParameters: {
          'query_term': query,
          'limit': 20,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'ok' && data['data']['movies'] != null) {
          final List<dynamic> moviesJson = data['data']['movies'];
          return moviesJson.map((json) => MovieSearchModel.fromJson(json)).toList();
        }
      }
      return [];
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}