
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/data_sources/movies_remote_data_sources.dart';
import '../../data/model/movie_model.dart';

class MovieGenreBrowserScreen extends StatefulWidget {
  const MovieGenreBrowserScreen({super.key});

  @override
  State<MovieGenreBrowserScreen> createState() => _MovieGenreBrowserScreenState();
}

class _MovieGenreBrowserScreenState extends State<MovieGenreBrowserScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> genres = [];
  bool isLoadingGenres = true;

  @override
  void initState() {
    super.initState();
    _loadGenres();
  }

  Future<void> _loadGenres() async {
    try {
      final dataSource = MovieRemoteDataSourceImpl(Dio());
      final fetchedGenres = await dataSource.fetchGenres();

      setState(() {
        genres = fetchedGenres;
        isLoadingGenres = false;
        _tabController = TabController(length: genres.length, vsync: this);
      });
    } catch (e) {
      setState(() {
        isLoadingGenres = false;
      });
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load genres: $e')),
      );
    }
  }

  @override
  void dispose() {
    if (!isLoadingGenres) {
      _tabController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Browse Movies', style: TextStyle(color: Colors.white)),
        bottom: isLoadingGenres
            ? null
            : PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            height: 50,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.red,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              tabs: genres.map((genre) => Tab(text: genre)).toList(),
            ),
          ),
        ),
      ),
      body: isLoadingGenres
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
          : TabBarView(
        controller: _tabController,
        children: genres.map((genre) => MovieGridView(genre: genre)).toList(),
      ),
    );
  }
}

class MovieGridView extends StatefulWidget {
  final String genre;

  const MovieGridView({Key? key, required this.genre}) : super(key: key);

  @override
  State<MovieGridView> createState() => _MovieGridViewState();
}

class _MovieGridViewState extends State<MovieGridView>
    with AutomaticKeepAliveClientMixin {
  List<MovieModel> movies = [];
  bool isLoading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      final dataSource = MovieRemoteDataSourceImpl(Dio());
      final fetchedMovies = await dataSource.fetchMoviesByGenre(widget.genre);

      setState(() {
        movies = fetchedMovies;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.red));
    }

    if (movies.isEmpty) {
      return const Center(
        child: Text(
          'No movies found',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie: movie);
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[900],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  movie.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.movie, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? 'Unknown',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        movie.rating?.toString() ?? 'N/A',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}