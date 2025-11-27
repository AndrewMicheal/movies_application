
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../movies/presentation/cubit/history_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/app_colors.dart';
import '../../domain/entities/history_movie.dart';
import '../cubit/history_state.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nearBlack,
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: AppColors.nearBlack,
        foregroundColor: AppColors.yellow,
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading || state is HistoryInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded) {
            final list = state.movies;
            if (list.isEmpty) {
              return Center(child: Text('No history yet', style: TextStyle(color: Colors.grey)));
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final HistoryMovie m = list[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to movie details with its id
                      Navigator.pushNamed(context, '/movieDetails', arguments: m.id);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: (m.posterUrl.isNotEmpty)
                                ? CachedNetworkImage(
                              imageUrl: m.posterUrl,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => Container(color: Colors.grey),
                            )
                                : Container(color: Colors.grey),
                          ),
                          if (m.rating != null)
                            Positioned(
                              top: 6,
                              left: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.star, size: 12, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text(
                                      (m.rating!).toStringAsFixed(1),
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
              ),
            );
          } else if (state is HistoryError) {
            return Center(child: Text('Error: ${state.message}', style: TextStyle(color: Colors.red)));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
