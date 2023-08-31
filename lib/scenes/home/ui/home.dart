import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_store/models/game/list_game_model.dart';
import 'package:game_store/scenes/game_detail/ui/game_detail.dart';
import 'package:game_store/scenes/home/bloc/home_bloc.dart';
import 'package:game_store/scenes/home/ui/game_box_widget.dart';
import 'package:game_store/utils/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc _homeBloc = HomeBloc();
  final ScrollController _scrollController = ScrollController();
  var games = <ListGameModel>[];
  var pageNumber = 1;

  @override
  void initState() {
    refresh();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pageNumber++;
        _homeBloc.add(GetGamesEvent(pageNumber: pageNumber));
      }
    });
  }

  Future refresh() async {
    games.clear();
    _homeBloc.add(const GetGamesEvent(pageNumber: 1, isRefresh: true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeGameClickedState) {
          if (state.clickedGame.id != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GameDetail(id: state.clickedGame.id!)),
            );
          }
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: const Text(Constants.appName),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            if (successState.games.isNotEmpty) {
              for (var element in successState.games) {
                games.add(element);
              }
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: const Text(Constants.appName),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: RefreshIndicator(
                        onRefresh: refresh,
                        child: GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 160,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 0.54),
                          itemCount: games.length,
                          itemBuilder: (context, index) => GameBoxWidget(
                            game: games[index],
                            homeBloc: _homeBloc,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          case HomeLoadedErrorState:
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
