import 'package:dio/dio.dart';
import 'package:not_netflix/models/movie.dart';
import 'package:not_netflix/services/api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();
  String lanquage = 'fr-FR';

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    //  on construit ici l'url pour la requête
    String url = api.baseUrl + path;

    //  on construit les paramètres de la requête
    //  ces paramètres seront présents dans chaques requêtes
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': lanquage,
    };

    //  si params n'est pas null, on ajoute son contenu à query
    if (params != null) {
      query.addAll(params);
    }

    //  appel api
    final response = await dio.get(url, queryParameters: query);

    //  on check si la requête s'est bien passée
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response =
        await getData("/movie/popular", params: {'page': pageNumber});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response =
        await getData("/movie/now_playing", params: {'page': pageNumber});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpcomingMovies({required int pageNumber}) async {
    Response response =
        await getData("/movie/upcoming", params: {'page': pageNumber});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAnimation({required int pageNumber}) async {
    Response response = await getData("/discover/movie",
        params: {'page': pageNumber, 'with_genres': '16'});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getSFMovies({required int pageNumber}) async {
    Response response = await getData("/discover/movie",
        params: {'page': pageNumber, 'with_genres': '878'});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      var genres = data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();
      Movie newMovie = movie.copyWith(
          genres: genreList,
          releaseDate: data['release_date'],
          vote: data['vote_average']);
      return newMovie;
    } else {
      throw (response);
    }
  }

  Future<Movie> getMovieVideos({required movie}) async {
    Response response = await getData('/movie/${movie.id}/videos');
    Movie newMovie = handleGetMovieVideosResponse(response, movie);
    if (newMovie.videos!.isEmpty) {
      lanquage = 'en-US';
      response = await getData('/movie/${movie.id}/videos');
      newMovie = handleGetMovieVideosResponse(response, movie);
    }
    return newMovie;
  }

  Movie handleGetMovieVideosResponse(Response response, Movie movie) {
    if (response.statusCode == 200) {
      Map data = response.data;
      List<String> videokeys = data['results'].map<String>((videoJson) {
        return videoJson['key'] as String;
      }).toList();
      return movie.copyWith(videos: videokeys);
    } else {
      throw (response);
    }
  }
}
