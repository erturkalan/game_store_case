part of 'game_detail_bloc.dart';

@immutable
abstract class GameDetailState {}

class GameDetailInitial extends GameDetailState {}

class GameDetailLoadingState extends GameDetailState {}

class GameDetailLoadedSuccessState extends GameDetailState {
  final GameDetailModel game;
  GameDetailLoadedSuccessState({required this.game});
}

class GameDetailLoadedErrorState extends GameDetailState {}
