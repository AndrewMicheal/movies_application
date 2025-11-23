import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.title,
    required super.image,
    required super.rating,
    required super.genre,
    required super.id
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['medium_cover_image'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      genre: (json['genres'] != null && json['genres'].isNotEmpty)
          ? json['genres'][0]
          : 'Unknown',
    );
  }
}
