part of 'game_detail_bloc.dart';

@immutable
abstract class GameDetailEvent {
  const GameDetailEvent();
}

class GetGameDetailEvent extends GameDetailEvent {
  final int id;
  const GetGameDetailEvent({required this.id});
}
