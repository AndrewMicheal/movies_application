import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/movie_details/domain/repository/movie_details_repo.dart';
import 'package:movies/features/movie_details/presentation/cubit/movie_details_state.dart';

@injectable
class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailsRepo movieDetailsRepo;

  MovieDetailsCubit(this.movieDetailsRepo) : super(MovieDetailsLoadingState());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoadingState());

    final result = await movieDetailsRepo.movieDetails(movieId);

    result.fold(
      ifLeft: (failure) {
        emit(MovieDetailsErrorState(errorMessage: failure.message));
      },
      ifRight: (movieDetailsEntity) {
        emit(
          MovieDetailsSuccessState(
            movieDetailsEntity,
            "Movie details loaded successfully",
          ),
        );
      },
    );
  }
}
