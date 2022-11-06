import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:not_netflix/models/movie.dart';

class MovieInfos extends StatelessWidget {
  final Movie movie;
  const MovieInfos({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          movie.name,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Genres : ${movie.reformatGenre()}",
          style: GoogleFonts.poppins(
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                movie.releaseDate!.substring(0, 4),
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Recommandé à ${(movie.vote! * 10).toInt()} %',
              style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }
}
