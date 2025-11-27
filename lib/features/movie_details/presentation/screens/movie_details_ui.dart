import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_styles.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/features/movie_details/presentation/cubit/movie_details_cubit.dart';
import 'package:movies/features/movie_details/presentation/cubit/movie_details_state.dart';
import 'package:movies/l10n/app_localizations.dart';

import 'package:movies/features/movies/domain/entities/history_movie.dart';
import 'package:movies/features/movies/presentation/cubit/history_cubit.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key,});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieDetailsCubit movieDetailsCubit;
  bool _isLoaded = false;

  bool _historyAdded = false;

  @override
  void initState() {
    super.initState();
    movieDetailsCubit = getIt<MovieDetailsCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      final movieId = ModalRoute.of(context)!.settings.arguments as int;
      print("Movie Details ID: $movieId");
      movieDetailsCubit.getMovieDetails(movieId);
      _isLoaded = true;
    }
  }

  @override
  void dispose() {
    movieDetailsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: movieDetailsCubit,
      child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoadingState) {
            return const Scaffold(
              backgroundColor: AppColors.nearBlack,
              body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.nearBlack,
                ),
              ),
            );
          }

          if (state is MovieDetailsErrorState) {
            return Scaffold(
              backgroundColor: AppColors.nearBlack,
              body: Center(
                child: Text(
                  "Error: ${state.errorMessage}",
                  style: AppStyles.regular16RobotoWhite,
                ),
              ),
            );
          }

          if (state is MovieDetailsSuccessState) {
            final movie = state.movieDetailsEntity;
            if (!_historyAdded) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                try {
                  final historyCubit = context.read<HistoryCubit>();

                  final historyMovie = HistoryMovie(
                    id: movie.id ?? 0,
                    title: movie.title ?? '',
                    posterUrl: movie.coverImage ?? '',
                    rating: movie.rating != null ? (movie.rating as num).toDouble() : null,
                    year: movie.year,
                  );

                  await historyCubit.add(historyMovie);
                } catch (e) {
                  debugPrint("Could not add to history: $e");
                }
              });

              _historyAdded = true;
            }


            return Scaffold(
              backgroundColor: AppColors.nearBlack,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: movie.coverImage ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 600.h,
                              errorWidget: (context, url, error) => Container(
                                width: double.infinity,
                                height: 600.h,
                                color: Colors.grey.shade900,
                                child: const Icon(Icons.broken_image, color: Colors.white54, size: 48),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 600.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          Positioned(
                            bottom: 16.h,
                            left: 16.w,
                            right: 16.w,
                            child: Text(
                              movie.title ?? "",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4,
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                size: 40,
                                color: AppColors.darkYellow,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(height: 4.h),
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          (movie.year?.toString() ?? ""),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Watch Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            AppLocalizations.of(context)!.watch,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: AppColors.darkGray,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 10.h,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: AppColors.darkYellow,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text("15", style: AppStyles.bold24RobtoWhite),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: AppColors.darkGray,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 10.h,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: AppColors.darkYellow,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    "${movie.runtime ?? ''}",
                                    style: AppStyles.bold24RobtoWhite,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: AppColors.darkGray,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 10.h,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: AppColors.darkYellow),
                                  SizedBox(width: 6.w),
                                  Text(
                                    "${movie.rating ?? ''}",
                                    style: AppStyles.bold24RobtoWhite,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.h,
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.screen_shots,
                              style: AppStyles.bold24RobtoWhite,
                            ),
                            SizedBox(height: 5.h),

                            Column(
                              children: (movie.screenshots ?? [])
                                  .map(
                                    (movieItem) => Padding(
                                  padding: EdgeInsets.only(bottom: 15.h),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: CachedNetworkImage(
                                      imageUrl: movieItem,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Container(height: 120.h, color: Colors.grey.shade900),
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),
                            ),

                            SizedBox(height: 7.h),
                            Text(AppLocalizations.of(context)!.summary, style: AppStyles.bold24RobotoWhite),
                            SizedBox(height: 10.h),
                            Text(
                              (movie.description != null && movie.description!.isNotEmpty)
                                  ? movie.description!
                                  : AppLocalizations.of(context)!.no_summary_available_for_this_movie,
                              style: AppStyles.regular16RobotoWhite,
                            ),
                            if (movie.cast != null && movie.cast!.isNotEmpty) ...[
                              SizedBox(height: 10.h),
                              Text(AppLocalizations.of(context)!.casts, style: AppStyles.bold24RobotoWhite),
                              Column(
                                children: movie.cast!
                                    .map(
                                      (movieItem) => Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 10.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.r),
                                        color: AppColors.darkGray,
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          movieItem.image != null && movieItem.image!.isNotEmpty
                                              ? CachedNetworkImage(
                                            imageUrl: movieItem.image!,
                                            width: 60.w,
                                            height: 60.h,
                                            fit: BoxFit.cover,
                                          )
                                              : SizedBox(width: 60.w, height: 60.h),

                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${AppLocalizations.of(context)!.name} : ${movieItem.name}",
                                                  style: AppStyles.regular16RobotoWhite,
                                                ),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  "${AppLocalizations.of(context)!.character}: ${movieItem.characterName}",
                                                  style: AppStyles.regular16RobotoWhite,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                    .toList(),
                              ),
                            ],

                            SizedBox(height: 10.h),
                            Text("Genres", style: AppStyles.bold24RobotoWhite),
                            Row(
                              children: (movie.genres ?? [])
                                  .map(
                                    (movieItem) => Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 10.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      color: AppColors.darkGray,
                                    ),
                                    child: Text(
                                      movieItem,
                                      style: AppStyles.regular16RobotoWhite,
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
