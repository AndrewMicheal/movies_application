import 'package:equatable/equatable.dart';

class MovieSearchEntity extends Equatable {
  final int id;
  final String title;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;
  final String posterUrl;

  const MovieSearchEntity({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.posterUrl,
  });

  @override
  List<Object?> get props => [id, title, year, rating, runtime, genres, summary, posterUrl];
}