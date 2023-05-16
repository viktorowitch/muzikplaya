import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/presentation/now_playing/widgets/add_playlist_button.dart';
import 'package:muzikplaya/presentation/now_playing/widgets/song_controllers.dart';
import 'package:muzikplaya/presentation/now_playing/widgets/song_image.dart';
import 'package:on_audio_query/on_audio_query.dart';

final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

seekplayer(int sec) async {
  Duration position = Duration(seconds: sec);
  await audioPlayer.seek(position);
}

String getTimeString(int second) {
  String minutes =
      '${(second / 60).floor() < 10 ? 0 : ''}${(second / 60).floor()}';
  String seconds = '${second % 60 < 10 ? 0 : ''}${second % 60}';
  return '$minutes:$seconds';
}

class NowPlaying extends StatelessWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return audioPlayer.builderRealtimePlayingInfos(
        builder: (context, realtimePlayingInfos) {
      return Stack(
        children: [
          QueryArtworkWidget(
              keepOldArtwork: true,
              nullArtworkWidget: Container(),
              artworkHeight: double.infinity,
              artworkWidth: double.infinity,
              id: int.parse(
                  realtimePlayingInfos.current!.audio.audio.metas.id!),
              type: ArtworkType.AUDIO),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: const Text('Сейчас играет'),
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                ),
                body: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: screenSize.height * 0.04),
                      SongImageWidget(
                        realtimePlayingInfos: realtimePlayingInfos,
                      ),
                      SizedBox(height: screenSize.height * 0.035),
                      SizedBox(
                          width: 280,
                          height: 50,
                          child: Marquee(
                            text: audioPlayer.getCurrentAudioTitle,
                            style: whitetxt22,
                            scrollAxis: Axis.horizontal,
                            blankSpace: 50,
                            velocity: 30,
                            pauseAfterRound: const Duration(seconds: 1),
                            showFadingOnlyWhenScrolling: true,
                            fadingEdgeStartFraction: 0.1,
                            fadingEdgeEndFraction: 0.1,
                            startPadding: 10,
                            accelerationDuration: const Duration(seconds: 1),
                            accelerationCurve: Curves.linear,
                            decelerationDuration:
                                const Duration(milliseconds: 500),
                            decelerationCurve: Curves.easeOut,
                          )),
                      SizedBox(height: screenSize.height * 0.035),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: homecardscolor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenSize.height * 0.025,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [const AddPlaylistButtonWidget()],
                              ),
                              SizedBox(
                                height: screenSize.height * 0.04,
                              ),
                              Slider(
                                  max: realtimePlayingInfos.duration.inSeconds
                                      .toDouble(),
                                  value: audioPlayer
                                      .currentPosition.value.inSeconds
                                      .toDouble(),
                                  onChanged: (double value) {
                                    seekplayer(value.toInt());
                                  }),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        getTimeString(realtimePlayingInfos
                                            .currentPosition.inSeconds),
                                        style: white54txt14),
                                    Text(
                                      getTimeString(realtimePlayingInfos
                                          .duration.inSeconds),
                                      style: white54txt14,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.045,
                              ),
                              SongControllerWidget(
                                  realtimePlayingInfos: realtimePlayingInfos)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ],
      );
    });
  }
}
