import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzikplaya/application/playlist_info/playlist_info_bloc.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/domain/model/data_model.dart';
import 'package:muzikplaya/presentation/home/widgets/songs_list.dart';
import 'package:on_audio_query/on_audio_query.dart';

class plylistsngs extends StatelessWidget {
  final int index;
  final audioModel plylistSongData;
  final String boxkey;

  plylistsngs({
    Key? key,
    required this.index,
    required this.plylistSongData,
    required this.boxkey,
  }) : super(key: key);

  static const removsong = 'Удалить из плейлиста';
  final List<String> plylstpoplist = [removsong];
  late BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    final int num = index + 1;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '$num',
                style: white54txt14,
              ),
              const SizedBox(
                width: 15,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: QueryArtworkWidget(
                      nullArtworkWidget:
                          const Icon(Icons.music_note, color: white, size: 30),
                      id: plylistSongData.id,
                      type: ArtworkType.AUDIO)),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      plylistSongData.songname,
                      style: whitetxt15,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                      width: 200,
                      child: Text(
                        plylistSongData.artist == '<unknown>'
                            ? "Неизвестный артист"
                            : plylistSongData.artist,
                        style: white54txt14,
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  deleteNoti(BuildContext ctx) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        backgroundColor: bggradient1,
        duration: const Duration(seconds: 4),
        content: const Text('Песня удалена')));
  }
}
