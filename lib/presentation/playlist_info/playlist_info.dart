import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzikplaya/application/home/home_bloc.dart';
import 'package:muzikplaya/application/playlist/playlist_bloc.dart';
import 'package:muzikplaya/application/playlist_info/playlist_info_bloc.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/domain/play_song.dart';
import 'package:muzikplaya/presentation/playlist_info/widgets/add_song_button.dart';
import 'package:muzikplaya/presentation/playlist_info/widgets/delete_playlist.dart';
import 'package:muzikplaya/presentation/playlist_info/widgets/play_button_widget.dart';
import 'package:muzikplaya/presentation/playlist_info/widgets/songs_list.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistInfo extends StatelessWidget {
  final String boxkey;
  final int idx;
  PlaylistInfo({Key? key, required this.boxkey, required this.idx})
      : super(key: key);
  final TextEditingController _editctrl = TextEditingController();
  late BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PlaylistInfoBloc>(context)
          .add(GetPlaylistSongs(boxKey: boxkey));
    });

    List<String> plylstpoptop = ['Удалить плейлист', 'Редактировать плейлист'];
    _editctrl.text = boxkey;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [bggradient1, homecardscolor])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              itemBuilder: (context) {
                return [
                  ...plylstpoptop.map((String value) {
                    return PopupMenuItem(value: value, child: Text(value));
                  }).toList()
                ];
              },
              onSelected: popselection,
            )
          ],
        ),
        body: Column(
          children: [
            Column(
              children: [
                BlocBuilder<PlaylistInfoBloc, PlaylistInfoState>(
                  builder: (context, state) {
                    return SizedBox(
                        height: 100,
                        width: 100,
                        child: state.playlistSongs.isNotEmpty
                            ? QueryArtworkWidget(
                                nullArtworkWidget: const Icon(Icons.music_note,
                                    color: white, size: 50),
                                id: state.playlistSongs[0].id,
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
                              ));
                  },
                ),
                const SizedBox(height: 10),
                BlocBuilder<PlaylistBloc, PlaylistState>(
                  builder: (context, state) {
                    return Text(
                      state.playlistNames[idx],
                      style: whitetxt18,
                    );
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const PlayButtonWidget(),
                    AddSongButtonWidget(boxkey: boxkey)
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: BlocBuilder<PlaylistInfoBloc, PlaylistInfoState>(
              builder: (context, state) {
                return state.finalPlaylistSongs.isEmpty
                    ? const Center(
                        child: Text(
                          'В плейлисте отсутствуют песни',
                          style: TextStyle(color: white),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.finalPlaylistSongs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              playSong()
                                  .playinglist(state.finalPlaylistSongs, index);

                              BlocProvider.of<HomeBloc>(context)
                                  .add(const HomeEvent.songPlayed());
                            },
                            child: plylistsngs(
                              index: index,
                              plylistSongData: state.playlistSongs[index],
                              boxkey: boxkey,
                            ),
                          );
                        });
              },
            ))
          ],
        ),
      ),
    );
  }

  popselection(String value) async {
    if (value == 'Удалить плейлист') {
      deleteplaylist(context: ctx, isMultiDelete: false, boxkey: boxkey);
    } else if (value == 'Редактировать плейлист') {
      editPlaylist();
    }
  }

  void editPlaylist() {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            title: const Text('Редактировать плейлист'),
            content: TextFormField(
              controller: _editctrl,
              decoration: const InputDecoration(hintText: 'Имя плейлиста'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Отмена')),
              BlocBuilder<PlaylistInfoBloc, PlaylistInfoState>(
                builder: (context, state) {
                  return TextButton(
                      onPressed: () async {
                        BlocProvider.of<PlaylistBloc>(context).add(
                            EditPlaylistName(
                                oldPlaylistName: boxkey,
                                newPlaylistName: _editctrl.text,
                                plylstAllSongs: state.playlistSongs));

                        Navigator.of(context).pop();
                      },
                      child: const Text('Принять'));
                },
              )
            ],
          );
        });
  }
}
