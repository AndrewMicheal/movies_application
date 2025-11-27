class MovieDetailsEntity {
  final int? id;
  final String? title;
  final String? titleLong;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String>? genres;

  final String? description;
  final String? trailerCode;

  final String? backgroundImage;
  final String? coverImage;

  final List<String>? screenshots;

  final List<MovieCastEntity>? cast;

  MovieDetailsEntity({
     this.id,
     this.title,
     this.titleLong,
     this.year,
     this.rating,
     this.runtime,
     this.genres,
     this.description,
     this.trailerCode,
     this.backgroundImage,
     this.coverImage,
     this.screenshots,
     this.cast,
  });
}

class MovieCastEntity {
  final String name;
  final String characterName;
  final String? image;

  MovieCastEntity({
    required this.name,
    required this.characterName,
    this.image,
  });
}