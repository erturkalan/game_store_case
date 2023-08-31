part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}

class GetGamesEvent extends HomeEvent {
  final int pageNumber;
  final bool isRefresh;
  const GetGamesEvent({required this.pageNumber, this.isRefresh = false});
}

class GameClickedEvent extends HomeEvent {
  final ListGameModel clickedGame;
  const GameClickedEvent({required this.clickedGame});
}
