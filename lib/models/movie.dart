// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:not_netflix/services/api.dart';

class Movie {
  final int id;
  final String name;
  final String description;
  final String? posterPath;

  Movie({
    required this.id,
    required this.name,
    required this.description,
    this.posterPath,
  });

  Movie copyWith(
      {int? id, String? name, String? description, String? posterPath}) {
    return Movie(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        posterPath: posterPath ?? this.posterPath);
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      name: map['title'] as String,
      description: map['overview'] as String,
      // ignore: unnecessary_null_in_if_null_operators
      posterPath: map['poster_path'] ?? null,
    );
  }

  String posterUrl() {
    API api = API();
    return api.baseImageUrl + posterPath!;
  }
}
