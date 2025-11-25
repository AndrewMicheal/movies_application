import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/movie_search_usecase/movie_search_usecase.dart';
import 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  final SearchMoviesUseCase searchMoviesUseCase;

  MovieSearchCubit({required this.searchMoviesUseCase}) : super(MovieSearchInitial());

  Future<void> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      emit(MovieSearchInitial());
      return;
    }

    emit(MovieSearchLoading());

    final result = await searchMoviesUseCase(query);

    result.fold(
          (failure) => emit(MovieSearchError(message: failure.message)),
          (movies) => emit(MovieSearchLoaded(movies: movies, searchQuery: query)),
    );
  }
}