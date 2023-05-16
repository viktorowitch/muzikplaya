import 'package:flutter/material.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/presentation/now_playing/now_playing.dart';
import 'package:muzikplaya/presentation/playlist/widgets/add_playlist.dart';
import 'package:muzikplaya/splash.dart';

class AddPlaylistButtonWidget extends StatelessWidget {
  const AddPlaylistButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          int index;
          for (var element in dbsongs) {
            if (audioPlayer.getCurrentAudioTitle == element.songname) {
              index = dbsongs.indexOf(element);
              addToPlaylist(context, dbsongs[index]);
              break;
            }
          }
        },
        icon: const Icon(
          Icons.playlist_play_rounded,
          color: white,
          size: 40,
        ));
  }
}
