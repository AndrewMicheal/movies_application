import 'package:dio/dio.dart';

import '../model/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> fetchMovies();
  Future<List<String>> fetchGenres();
  Future<List<MovieModel>> fetchMoviesByGenre(String genre);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;
  MovieRemoteDataSourceImpl(this.dio);

  @override
  Future<List<MovieModel>> fetchMovies() async {
    final response = await dio.get('https://yts.lt/api/v2/list_movies.json');
    final data = response.data['data']['movies'] as List;
    return data.map((e) => MovieModel.fromJson(e)).toList();
  }

  @override
  Future<List<String>> fetchGenres() async {
    try {
      final response = await dio.get(
        'https://yts.lt/api/v2/list_movies.json',
        queryParameters: {'limit': 50},
      );

      final data = response.data['data'];
      if (data == null) return [];

      final movies = data['movies'] as List?;
      if (movies == null || movies.isEmpty) return [];

      Set<String> genresSet = {};
      for (var movie in movies) {
        List<String> movieGenres = List<String>.from(movie['genres'] ?? []);
        genresSet.addAll(movieGenres);
      }

      return genresSet.toList()..sort();
    } catch (e) {
      throw Exception('Failed to fetch genres: $e');
    }
  }

  @override
  Future<List<MovieModel>> fetchMoviesByGenre(String genre) async {
    try {
      final response = await dio.get(
        'https://yts.lt/api/v2/list_movies.json',
        queryParameters: {
          'genre': genre,
          'sort_by': 'rating',
        },
      );

      final data = response.data['data'];
      if (data == null) return [];

      final movies = data['movies'] as List?;
      if (movies == null) return [];

      return movies.map((e) => MovieModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to fetch movies by genre: $e');
    }
  }
}