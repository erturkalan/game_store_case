part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ListGameModel> games;
  HomeLoadedSuccessState({required this.games});
}

class HomeLoadedErrorState extends HomeState {}

class HomeGameClickedState extends HomeActionState {
  final ListGameModel clickedGame;

  HomeGameClickedState({required this.clickedGame});
}
