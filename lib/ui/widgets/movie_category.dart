// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:not_netflix/models/movie.dart';
import 'package:not_netflix/ui/widgets/movie_card.dart';

class MovieCategory extends StatelessWidget {
  final String label;
  final List<Movie> movieList;
  final double imageHeight;
  final double imageWidth;
  final Function callback;

  const MovieCategory(
      {Key? key,
      required this.label,
      required this.movieList,
      required this.imageHeight,
      required this.imageWidth,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(label,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: imageHeight,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              final currentPosition = notification.metrics.pixels;
              final maxPosition = notification.metrics.maxScrollExtent;
              if (currentPosition >= maxPosition / 2) {
                callback();
              }
              return true;
            },
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieList.length,
                itemBuilder: (context, index) {
                  // ignore: dead_code
                  return Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: imageWidth,
                      child: movieList.isEmpty
                          ? const Center()
                          : MovieCard(movie: movieList[index]));
                }),
          ),
        ),
      ],
    );
  }
}
