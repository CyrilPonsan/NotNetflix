import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:not_netflix/repositories/data_repository.dart';
import 'package:not_netflix/ui/widgets/action_button.dart';
import 'package:not_netflix/ui/widgets/movie_infos.dart';
import 'package:not_netflix/ui/widgets/my_video_player.dart';
import 'package:not_netflix/utils/constantes.dart';
import 'package:provider/provider.dart';
import '../../models/movie.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newMovie;

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    //  récupérer les détails du film
    Movie movie = await dataProvider.getMovieDetails(movie: widget.movie);
    setState(() {
      newMovie = movie;
      print(newMovie!.videos!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
        ),
        body: newMovie == null
            ? Center(
                child: SpinKitFadingCircle(
                  color: kPrimaryColor,
                  size: 20,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8),
                child: ListView(children: [
                  SizedBox(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: newMovie!.videos!.isEmpty
                        ? const Center()
                        : MyVideoPlayer(movieId: newMovie!.videos!.first),
                  ),
                  MovieInfos(movie: newMovie!),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                      icon: Icons.play_arrow,
                      label: 'Lecture',
                      bgColor: Colors.white,
                      color: kBackgroundColor),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                      icon: Icons.download,
                      label: 'Télécharger la vidéo',
                      bgColor: Colors.grey.withOpacity(.3),
                      color: Colors.white)
                ]),
              ));
  }
}
