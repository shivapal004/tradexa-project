import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];
  static bool _isLoading = false;

  List<Movie> get movies => _movies;

  bool get isLoading => _isLoading;

  Future<void> fetchMovies(String movieName) async {
    _isLoading = true;
    notifyListeners();

    const apiKey = '8fee8735';

    // First API call to search for the movie by name
    final searchUrl =
        Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&s=$movieName');
    final searchResponse = await http.get(searchUrl);

    if (searchResponse.statusCode == 200) {
      final searchData = json.decode(searchResponse.body);
      if (searchData['Response'] == 'True') {
        // List to hold detailed movie information
        List<Movie> fetchedMovies = [];

        // Loop through the search results and fetch detailed info for each movie
        for (var movieData in searchData['Search']) {
          final imdbID = movieData['imdbID'];

          // Fetching detailed data for each movie using the IMDb ID
          final detailsUrl =
              Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&i=$imdbID');
          final detailsResponse = await http.get(detailsUrl);

          if (detailsResponse.statusCode == 200) {
            final detailsData = json.decode(detailsResponse.body);
            if (detailsData['Response'] == 'True') {
              // Add the detailed movie to the list
              fetchedMovies.add(Movie.fromJson(detailsData));
            }
          }
        }

        _movies = fetchedMovies; // Update the movies list
      } else {
        _movies = [];
      }
    } else {
      _movies = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
