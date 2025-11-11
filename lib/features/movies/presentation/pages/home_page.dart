import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/movie.dart';
import '../cubit/movie_cubit.dart';
import '../widgets/movie_carousel.dart';
import '../widgets/movie_list_horizontal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, List>(
      builder: (context, movies) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Available Now',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  MovieCarousel(movies: List<Movie>.from(movies)),
                  const SizedBox(height: 20),
                  Center(
                    child: Text('Watch Now',
                        style: GoogleFonts.pacifico(
                            color: Colors.white, fontSize: 36)),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Action',
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 24)),
                        const Text('See More →',
                            style: TextStyle(color: Colors.yellow , fontSize: 24)),
                      ],
                    ),
                  ),
                  MovieListHorizontal(movies: List<Movie>.from(movies)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
