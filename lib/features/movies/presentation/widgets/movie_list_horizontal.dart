import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/movie.dart';

class MovieListHorizontal extends StatelessWidget {
  final List<Movie> movies;
  const MovieListHorizontal({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: movie.image,
                    height: 160,
                    width: 110,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 14),
                    Text(movie.rating.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
