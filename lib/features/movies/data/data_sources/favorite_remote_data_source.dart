import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/token_storage/token_storage.dart';
import '../model/favorite_movie_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<void> addFavorite(FavoriteMovieModel movie);
  Future<List<FavoriteMovieModel>> getAllFavorites();
  Future<void> removeFavorite(String movieId);
}

@LazySingleton(as: FavoritesRemoteDataSource)
class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final Dio dio;
  FavoritesRemoteDataSourceImpl(this.dio);

  Future<String?> _getToken() async => await TokenStorage.getToken();

  Options _authOptions(String? token) {
    final headers = <String, dynamic>{
      'Content-Type': 'application/json',
    };
    if (token != null && token.isNotEmpty) headers['Authorization'] = 'Bearer $token';
    return Options(headers: headers);
  }

  @override
  Future<void> addFavorite(FavoriteMovieModel movie) async {
    final token = await _getToken();
    await dio.post('favorites/add', data: movie.toJson(), options: _authOptions(token));
  }

  @override
  Future<List<FavoriteMovieModel>> getAllFavorites() async {
    final token = await _getToken();
    final resp = await dio.get('favorites/all', options: _authOptions(token));
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      final data = resp.data;
      final list = (data['data'] as List<dynamic>?) ?? [];
      return list.map((e) => FavoriteMovieModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Failed to load favorites: ${resp.statusCode}');
  }

  @override
  Future<void> removeFavorite(String movieId) async {
    final token = await _getToken();
    await dio.delete('favorites/remove/$movieId', options: _authOptions(token));
  }
}
