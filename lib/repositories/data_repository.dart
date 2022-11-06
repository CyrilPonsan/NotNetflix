import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:not_netflix/models/movie.dart';
import 'package:not_netflix/services/api_services.dart';

class DataRepository with ChangeNotifier {
  final APIService apiService = APIService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1;
  final List<Movie> _nowplaying = [];
  int _nowPlayingIndex = 1;
  final List<Movie> _upcomingMovies = [];
  int _upcomingMoviesPageIndex = 1;
  final List<Movie> _animationMovies = [];
  int _animationsMoviesPageIndex = 1;
  final List<Movie> _sfMovies = [];
  int _sfMoviesPageIndex = 1;

  //  getters

  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlaying => _nowplaying;
  List<Movie> get upcomingMovies => _upcomingMovies;
  List<Movie> get animationMovies => _animationMovies;
  List<Movie> get sfMovies => _sfMovies;

  Future<void> getPopularMovies() async {
    try {
      List<Movie> movies =
          await apiService.getPopularMovies(pageNumber: _popularMoviePageIndex);
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getNowPlaying() async {
    try {
      List<Movie> movies =
          await apiService.getNowPlaying(pageNumber: _nowPlayingIndex);
      _nowplaying.addAll(movies);
      _nowPlayingIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getUpcomingMovies() async {
    try {
      List<Movie> movies = await apiService.getUpcomingMovies(
          pageNumber: _upcomingMoviesPageIndex);
      _upcomingMovies.addAll(movies);
      _upcomingMoviesPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getAnimationMovies() async {
    try {
      List<Movie> movies =
          await apiService.getAnimation(pageNumber: _animationsMoviesPageIndex);
      _animationMovies.addAll(movies);
      _animationsMoviesPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getSFMovies() async {
    try {
      List<Movie> movies =
          await apiService.getSFMovies(pageNumber: _sfMoviesPageIndex);
      _sfMovies.addAll(movies);
      _sfMoviesPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> initData() async {
    await getPopularMovies();
    await getNowPlaying();
    await getUpcomingMovies();
    await getAnimationMovies();
    await getSFMovies();
  }
}
