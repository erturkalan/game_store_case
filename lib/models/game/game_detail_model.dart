import 'package:game_store/models/game/genre_model.dart';

class GameDetailModel {
  int? id;
  String? name;
  double? rating;
  List<GenreModel>? genres;
  String? image;
  String? description;

  GameDetailModel(
      {this.id,
      this.name,
      this.rating,
      this.genres,
      this.image,
      this.description});

  GameDetailModel.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating =
        json['rating'] != null ? double.parse(json['rating'].toString()) : null;
    if (json['genres'] != null) {
      genres = <GenreModel>[];
      json['genres'].forEach((v) {
        genres?.add(GenreModel.fromJson(v));
      });
    }
    image = json['background_image'];
    description = json['description_raw'];
  }
}
