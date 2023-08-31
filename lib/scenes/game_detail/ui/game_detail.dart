import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_store/scenes/game_detail/bloc/game_detail_bloc.dart';
import 'package:game_store/scenes/game_detail/ui/game_detail_page_widget.dart';
import 'package:game_store/utils/constants.dart';

class GameDetail extends StatefulWidget {
  final int id;

  const GameDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  final GameDetailBloc _gameDetailBloc = GameDetailBloc();

  @override
  void initState() {
    _gameDetailBloc.add(GetGameDetailEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameDetailBloc, GameDetailState>(
      bloc: _gameDetailBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case GameDetailLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case GameDetailLoadedSuccessState:
            final successState = state as GameDetailLoadedSuccessState;
            var genres = "";
            if (successState.game.genres != null) {
              for (var genre in successState.game.genres!) {
                if (genres != "") {
                  genres += ", ${genre.name!}";
                } else {
                  genres += genre.name!;
                }
              }
            }
            return GameDetailPageWidget(
                successState: successState, genres: genres);
          case GameDetailLoadedErrorState:
            return const Scaffold(
              body: Center(
                child: Text(Constants.errorMessage),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
