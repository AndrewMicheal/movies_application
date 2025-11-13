import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movies.dart';

class MovieCubit extends Cubit<List<Movie>> {
  final GetMovies getMovies;
  MovieCubit(this.getMovies) : super([]);

  Future<void> loadMovies() async {
    final result = await getMovies();
    emit(result);
  }
}
