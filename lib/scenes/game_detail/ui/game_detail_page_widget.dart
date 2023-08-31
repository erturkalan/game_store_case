import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_store/scenes/game_detail/bloc/game_detail_bloc.dart';

class GameDetailPageWidget extends StatelessWidget {
  const GameDetailPageWidget({
    super.key,
    required this.successState,
    required this.genres,
  });

  final GameDetailLoadedSuccessState successState;
  final String genres;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              successState.game.image != null
                  ? Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          imageUrl: successState.game.image!,
                          placeholder: (context, url) =>
                              const Icon(Icons.photo),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 8,
              ),
              Text(
                successState.game.name != null ? successState.game.name! : "",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                      successState.game.rating != null
                          ? successState.game.rating!.toString()
                          : "N/A",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    genres,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                  successState.game.description != null
                      ? successState.game.description!
                      : "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
