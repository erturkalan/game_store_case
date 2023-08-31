import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_store/models/game/list_game_model.dart';
import 'package:game_store/scenes/home/bloc/home_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GameBoxWidget extends StatelessWidget {
  final ListGameModel game;
  final HomeBloc homeBloc;
  const GameBoxWidget({Key? key, required this.game, required this.homeBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var genres = "";
    if (game.genres != null) {
      for (var genre in game.genres!) {
        if (genres != "") {
          genres += ", \n${genre.name!}";
        } else {
          genres += genre.name!;
        }
      }
    }
    var rating = 0.0;
    if (game.rating != null) {
      rating = double.parse((game.rating! / 5).toString());
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
      child: InkWell(
        onTap: () => homeBloc.add(GameClickedEvent(clickedGame: game)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 5), // changes position of shadow
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                game.image != null
                    ? Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.fitHeight,
                            imageUrl: game.image!,
                            placeholder: (context, url) =>
                                const Icon(Icons.photo),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 2,
                ),
                SizedBox(
                  height: 96,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxWidth: 80, maxHeight: 44),
                              child: Text(
                                game.name != null ? game.name! : "",
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 1, 4, 2),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxWidth: 80, maxHeight: 54),
                              child: Text(
                                genres,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: CircularPercentIndicator(
                          radius: 14,
                          lineWidth: 6,
                          percent: rating,
                          progressColor: Colors.yellow,
                          startAngle: 180.0,
                          center: const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
