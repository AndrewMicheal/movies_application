class HistoryMovie {
  final int id;
  final String title;
  final String posterUrl;
  final double? rating;
  final int? year;

  HistoryMovie({
    required this.id,
    required this.title,
    required this.posterUrl,
    this.rating,
    this.year,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'posterUrl': posterUrl,
    'rating': rating,
    'year': year,
  };

  factory HistoryMovie.fromJson(Map<String, dynamic> json) => HistoryMovie(
    id: json['id'] as int,
    title: json['title'] as String? ?? '',
    posterUrl: json['posterUrl'] as String? ?? '',
    rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
    year: json['year'] as int?,
  );
}
