import 'package:game_store/models/game/list_game_model.dart';

class GameListResponse {
  List<ListGameModel>? results;

  GameListResponse({this.results});

  GameListResponse.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ListGameModel>[];
      json['results'].forEach((v) {
        results?.add(ListGameModel.fromJson(v));
      });
    }
  }
}
