import 'package:movies/features/movie_details/data/model/MovieDetailsResponse.dart';

abstract class MovieDetailsDataSource {
  Future<MovieDetailsDto> movieDetails(int id);
}