import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradexa_project/widgets/movie_card.dart';

import 'models/movie_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24
            ),
          )
        ),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      final query = searchController.text;
                      if (query.isNotEmpty) {
                        movieProvider.fetchMovies(query);
                      }
                    },
                  ),
                ),
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    movieProvider.fetchMovies(query);
                  }
                },
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: movieProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : movieProvider.movies.isEmpty
                    ? const Center(
                  child: Text(
                    'No movies found',
                    style: TextStyle(fontSize: 18),
                  ),
                )
                    : ListView.builder(
                  itemCount: movieProvider.movies.length,
                  itemBuilder: (context, index) {
                    final movie = movieProvider.movies[index];
                    return MovieCard(movie: movie);
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


