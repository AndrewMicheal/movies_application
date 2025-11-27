import 'package:equatable/equatable.dart';

import '../../domain/movie_search_entities/movie_search_entities.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object?> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final List<MovieSearchEntity> movies;
  final String searchQuery;

  const MovieSearchLoaded({required this.movies, required this.searchQuery});

  @override
  List<Object?> get props => [movies, searchQuery];
}

class MovieSearchError extends MovieSearchState {
  final String message;

  const MovieSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}