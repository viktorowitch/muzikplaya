import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/presentation/playlist/widgets/add_playlist.dart';
import 'package:muzikplaya/splash.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Songs extends StatelessWidget {
  final Audio songData;
  final int index;

  Songs({Key? key, required this.songData, required this.index})
      : super(key: key);

  static const String addplaylist = 'Добавить в плейлист';
  final List<String> finlist = [addplaylist];
  late BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    height: 50,
                    width: 50,
                    child: QueryArtworkWidget(
                        nullArtworkWidget: const Icon(
                          Icons.music_note,
                          color: white,
                          size: 30,
                        ),
                        id: int.parse(songData.metas.id.toString()),
                        type: ArtworkType.AUDIO)),
                const SizedBox(
                  width: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            songData.metas.title.toString(),
                            style: whitetxt15,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            songData.metas.artist.toString() == '<unknown>'
                                ? "Неизвестный артист"
                                : songData.metas.artist.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: white30txt12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

bool checkAdded(String songname, List songslist) {
  bool check = false;
  for (var element in songslist) {
    if (songname == element.songname) {
      check = true;
      break;
    }
  }
  if (check) {
    return true;
  } else {
    return false;
  }
}
