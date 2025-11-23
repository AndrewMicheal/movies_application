import 'package:equatable/equatable.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details.dart';

abstract class MovieDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}


class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsErrorState extends MovieDetailsState {
  final String errorMessage;

  MovieDetailsErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}


class MovieDetailsSuccessState extends MovieDetailsState {
  final MovieDetailsEntity movieDetailsEntity;
  final String message;
  MovieDetailsSuccessState(this.movieDetailsEntity, this.message,);

  @override
  List<Object?> get props => [movieDetailsEntity, message];
}