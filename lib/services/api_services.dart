import 'package:dio/dio.dart';
import 'package:not_netflix/models/movie.dart';
import 'package:not_netflix/services/api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    //  on construit ici l'url pour la requête
    String url = api.baseUrl + path;

    //  on construit les paramètres de la requête
    //  ces paramètres seront présents dans chaques requêtes
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'fr-Fr',
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
}
