import 'package:flutter/material.dart';
import 'package:movies/features/search_movies/domain/movie_search_entities/movie_search_entities.dart';

import 'movie_search_card.dart';

class MovieSearchGrid extends StatelessWidget {
  final List<MovieSearchEntity> movies;
  final String query;

  const MovieSearchGrid({Key? key, required this.movies, required this.query})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Found ${movies.length} movies for "$query"',
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieSearchCard(movie: movies[index]);
            },
          ),
        ),
      ],
    );
  }
}