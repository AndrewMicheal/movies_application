import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/features/search_movies/presentation/movie_search_cubit/movie_search_state.dart';

import '../../../movie_details/presentation/screens/movie_details_ui.dart';
import '../../../movies/presentation/cubit/movie_cubit.dart';
import '../movie_search_cubit/movie_search_cubit.dart';
import '../movie_search_widgets/movie_search_grid.dart';


class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({Key? key}) : super(key: key);

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkGray,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF2a2a2a),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (_searchController.text == value) {
                      context.read<MovieSearchCubit>().searchMovies(value);
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search movies by title...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF3a3a3a),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.amber),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<MovieSearchCubit, MovieSearchState>(
                builder: (context, state) {
                  if (state is MovieSearchInitial) {
                    return const EmptyState(
                      icon: Icons.search,
                      message: 'Start typing to search for movies',
                    );
                  } else if (state is MovieSearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.amber),
                    );
                  } else if (state is MovieSearchError) {
                    return EmptyState(
                      icon: Icons.error_outline,
                      message: state.message,
                      isError: true,
                    );
                  } else if (state is MovieSearchLoaded) {
                    if (state.movies.isEmpty) {
                      return EmptyState(
                        icon: Icons.movie_filter,
                        message: 'No movies found for "${state.searchQuery}"', isError: false,
                      );
                    }
                    return MovieSearchGrid(movies: state.movies, query: state.searchQuery);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final bool isError;

  const EmptyState({
    Key? key,
    required this.icon,
    required this.message,
    this.isError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: isError ? Colors.red : Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: isError ? Colors.red : Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
