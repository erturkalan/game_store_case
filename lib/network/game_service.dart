import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:game_store/models/game/game_detail_model.dart';
import 'package:game_store/models/game/game_list_response.dart';
import 'package:game_store/models/game/list_game_model.dart';
import 'package:game_store/network/network_service.dart';
import 'package:game_store/utils/constants.dart';

class GameService {
  final NetworkService networkService;
  GameService({required this.networkService});

  Future<List<ListGameModel>?> getGames(int pageNumber) async {
    var parameters = <String, dynamic>{};
    parameters['key'] = Constants.apiKey;
    parameters['page'] = pageNumber.toString();
    try {
      var response = await networkService.get(Constants.baseUrl, '/api/games',
          parameters: parameters);

      var gameList = GameListResponse.fromJson(jsonDecode(response));
      return gameList.results;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<GameDetailModel?> getGameDetail(int id) async {
    var parameters = <String, dynamic>{};
    parameters['key'] = Constants.apiKey;
    try {
      var response = await networkService
          .get(Constants.baseUrl, '/api/games/$id', parameters: parameters);

      var gameDetail = GameDetailModel.fromJson(jsonDecode(response));
      return gameDetail;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
