import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.poster,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4.0),
                  Text(movie.genre.replaceAll(', ', ' | '), style: const TextStyle(color: Colors.grey),),
                  const SizedBox(height: 6.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: double.tryParse(movie.imdbRating) != null &&
                              double.parse(movie.imdbRating) >= 7
                          ? const Color(0xFF5EC570)
                          : const Color(0xFF1C7EEB),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      '${movie.imdbRating} IMDB',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
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
