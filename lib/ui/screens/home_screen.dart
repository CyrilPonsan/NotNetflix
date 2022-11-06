import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:not_netflix/repositories/data_repository.dart';
import 'package:not_netflix/ui/widgets/movie_card.dart';
import 'package:not_netflix/ui/widgets/movie_category.dart';
import 'package:not_netflix/utils/constantes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: ListView(
        children: [
          SizedBox(
              height: 500,
              child: MovieCard(
                movie: dataProvider.popularMovieList.first,
              )),
          MovieCategory(
            label: 'Tendances Actuelles',
            movieList: dataProvider.popularMovieList,
            imageHeight: 160,
            imageWidth: 110,
            callback: dataProvider.getPopularMovies,
          ),
          MovieCategory(
            label: "Actuellement au cinéma",
            movieList: dataProvider.nowPlaying,
            imageHeight: 320,
            imageWidth: 220,
            callback: dataProvider.getNowPlaying,
          ),
          MovieCategory(
            label: 'Ils arrivent bientôt',
            movieList: dataProvider.upcomingMovies,
            imageHeight: 160,
            imageWidth: 110,
            callback: dataProvider.getUpcomingMovies,
          ),
          MovieCategory(
              label: 'Animations',
              movieList: dataProvider.animationMovies,
              imageHeight: 120,
              imageWidth: 110,
              callback: dataProvider.getAnimationMovies),
          MovieCategory(
              label: 'Science-Fiction',
              movieList: dataProvider.sfMovies,
              imageHeight: 120,
              imageWidth: 110,
              callback: dataProvider.getSFMovies),
        ],
      ),
    );
  }
}
