import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:not_netflix/models/movie.dart';
import 'package:not_netflix/services/api_services.dart';
import 'package:not_netflix/utils/constantes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie>? movies;

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  void getMovies() {
    APIService().getPopularMovies(pageNumber: 1).then((movieList) {
      setState(() {
        movies = movieList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: ListView(
        children: [
          Container(
            height: 500,
            child: movies == null
                ? const Center()
                : Image.network(
                    movies![3].posterUrl(),
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text('Tendances actuelles',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  // ignore: dead_code
                  return Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 110,
                      child: movies == null
                          ? const Center()
                          : Image.network(
                              movies![index].posterUrl(),
                              fit: BoxFit.cover,
                            ));
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          Text('Actuellement au cinéma',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 320,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 220,
                    color: Colors.blue,
                    child: Center(child: Text(index.toString())),
                  );
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          Text('Ils arrivent bientôt',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 110,
                    color: Colors.green,
                    child: Center(child: Text(index.toString())),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
