import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:not_netflix/models/movie.dart';
import 'package:not_netflix/ui/screens/movie_details_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MovieDtailsPage(movie: movie);
        }));
      },
      child: CachedNetworkImage(
        imageUrl: movie.posterUrl(),
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
