import 'package:movies/features/search_movies/domain/movie_search_entities/movie_search_entities.dart';

class MovieSearchModel extends MovieSearchEntity {
  const MovieSearchModel({
    required super.id,
    required super.title,
    required super.year,
    required super.rating,
    required super.runtime,
    required super.genres,
    required super.summary,
    required super.posterUrl,
  });

  factory MovieSearchModel.fromJson(Map<String, dynamic> json) {
    return MovieSearchModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      genres: List<String>.from(json['genres'] ?? []),
      summary: json['summary'] ?? '',
      posterUrl: json['medium_cover_image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'rating': rating,
      'runtime': runtime,
      'genres': genres,
      'summary': summary,
      'medium_cover_image': posterUrl,
    };
  }
}