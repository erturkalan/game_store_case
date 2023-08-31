import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:game_store/models/game/game_detail_model.dart';
import 'package:game_store/network/game_service.dart';
import 'package:game_store/network/network_service.dart';
import 'package:meta/meta.dart';

part 'game_detail_event.dart';
part 'game_detail_state.dart';

class GameDetailBloc extends Bloc<GameDetailEvent, GameDetailState> {
  GameDetailBloc() : super(GameDetailInitial()) {
    on<GetGameDetailEvent>(getGameDetailEvent);
  }

  FutureOr<void> getGameDetailEvent(
      GetGameDetailEvent event, Emitter<GameDetailState> emit) async {
    emit(GameDetailLoadingState());
    final gameService =
        GameService(networkService: NetworkService.sharedInstance);
    EasyLoading.show();
    var response = await gameService.getGameDetail(event.id);
    EasyLoading.dismiss();
    if (response != null) {
      emit(GameDetailLoadedSuccessState(game: response));
    } else {
      emit(GameDetailLoadedErrorState());
    }
  }
}
