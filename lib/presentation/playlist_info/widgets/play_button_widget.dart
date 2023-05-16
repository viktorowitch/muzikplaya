import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzikplaya/application/home/home_bloc.dart';
import 'package:muzikplaya/application/playlist_info/playlist_info_bloc.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/domain/play_song.dart';

class PlayButtonWidget extends StatelessWidget {
  const PlayButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistInfoBloc, PlaylistInfoState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<HomeBloc>(context)
                .add(const HomeEvent.songPlayed());
            playSong().playinglist(state.finalPlaylistSongs, 0);
          },
          child: Container(
            height: 35,
            width: 75,
            decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.circular(20)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  color: white,
                  size: 20,
                ),
                Text(
                  'Играть',
                  style: whitetxt15,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
