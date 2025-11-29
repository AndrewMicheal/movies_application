
import '../../domain/entities/favorite_movie.dart';

class FavoriteMovieModel {
  final String movieId;
  final String name;
  final double? rating;
  final String imageURL;
  final String? year;

  FavoriteMovieModel({
    required this.movieId,
    required this.name,
    this.rating,
    required this.imageURL,
    this.year,
  });

  factory FavoriteMovieModel.fromJson(Map<String, dynamic> json) => FavoriteMovieModel(
    movieId: json['movieId'] as String,
    name: json['name'] as String,
    rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
    imageURL: json['imageURL'] as String? ?? '',
    year: json['year'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'movieId': movieId,
    'name': name,
    'rating': rating,
    'imageURL': imageURL,
    'year': year,
  };

  factory FavoriteMovieModel.fromEntity(FavoriteMovie e) => FavoriteMovieModel(
    movieId: e.movieId,
    name: e.name,
    rating: e.rating,
    imageURL: e.imageURL,
    year: e.year,
  );

  FavoriteMovie toEntity() => FavoriteMovie(
    movieId: movieId,
    name: name,
    rating: rating,
    imageURL: imageURL,
    year: year,
  );
}
