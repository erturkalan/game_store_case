import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:game_store/models/game/list_game_model.dart';
import 'package:game_store/network/game_service.dart';
import 'package:game_store/network/network_service.dart';
import 'package:meta/meta.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetGamesEvent>(getGamesEvent);
    on<GameClickedEvent>(gameClickedEvent);
  }

  FutureOr<void> getGamesEvent(
      GetGamesEvent event, Emitter<HomeState> emit) async {
    if (event.isRefresh) {
      emit(HomeLoadingState());
    }
    final gameService =
        GameService(networkService: NetworkService.sharedInstance);
    if (!event.isRefresh) {
      EasyLoading.show();
    }
    var response = await gameService.getGames(event.pageNumber);
    EasyLoading.dismiss();
    if (response != null && response.isNotEmpty) {
      emit(HomeLoadedSuccessState(games: response));
    } else {
      emit(HomeLoadedErrorState());
    }
  }

  FutureOr<void> gameClickedEvent(
      GameClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeGameClickedState(clickedGame: event.clickedGame));
  }
}
