class FavoriteMovie {
  final String movieId;
  final String name;
  final double? rating;
  final String imageURL;
  final String? year;

  FavoriteMovie({
    required this.movieId,
    required this.name,
    this.rating,
    required this.imageURL,
    this.year,
  });
}
