import 'package:flutter/material.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/domain/model/data_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistAlbums extends StatelessWidget {
  final String name;
  final int index;
  final bool isSelected;
  final List<audioModel> audioData;

  const PlaylistAlbums({
    Key? key,
    required this.name,
    required this.index,
    required this.isSelected,
    required this.audioData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.transparent,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          SizedBox(
            height: 130,
            width: 130,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: audioData.isNotEmpty
                    ? QueryArtworkWidget(
                        nullArtworkWidget: const Icon(Icons.music_note,
                            color: white, size: 50),
                        id: audioData[0].id,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                      )
                    : const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.music_note,
                          color: white,
                          size: 50,
                        ),
                      )),
          ),
          const SizedBox(
            height: 9,
          ),
          Text(
            name,
            style: whitetxt18,
          ),
          Text(
            'Всего ${audioData.length} треков',
            style: whitetxt15,
          )
        ],
      ),
    );
  }
}
