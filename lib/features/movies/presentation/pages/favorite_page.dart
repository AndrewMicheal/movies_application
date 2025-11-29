import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/core/app_routes.dart';

import '../../../../core/app_colors.dart';
import '../../domain/entities/favorite_movie.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nearBlack,
      appBar: AppBar(
        title: const Text('Watch list'),
        backgroundColor: AppColors.nearBlack,
        foregroundColor: AppColors.yellow,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          final favorites = context.read<FavoritesCubit>().favorites;

          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoritesError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (favorites.isEmpty) {
            return const Center(
                child: Text('Your watch list is empty', style: TextStyle(color: Colors.white)));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final FavoriteMovie m = favorites[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.movieDetails, arguments: int.tryParse(m.movieId) ?? m.movieId);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: m.imageURL,
                          fit: BoxFit.cover,
                          errorWidget: (c, u, e) => Container(color: Colors.grey.shade900),
                        ),
                      ),
                      if (m.rating != null)
                        Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star, size: 12, color: Colors.yellow),
                                const SizedBox(width: 4),
                                Text(
                                  m.rating!.toString(),
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
