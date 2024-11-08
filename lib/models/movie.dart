class Movie {
  final String title;
  final String poster;
  final String genre;
  final String imdbRating;

  Movie({
    required this.title,
    required this.poster,
    required this.genre,
    required this.imdbRating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? 'No Title',
      poster: json['Poster'] ?? '',
      genre: json['Genre'] ?? 'Unknown',
      imdbRating: json['imdbRating'] ?? 'N/A',
    );
  }
}
