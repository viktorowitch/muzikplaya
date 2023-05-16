import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzikplaya/application/playlist/playlist_bloc.dart';
import 'package:muzikplaya/application/playlist_info/playlist_info_bloc.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/domain/model/data_model.dart';
import 'package:muzikplaya/presentation/home/widgets/songs_list.dart';
import 'package:muzikplaya/presentation/playlist/widgets/create_playlist.dart';
import 'package:muzikplaya/splash.dart';

addToPlaylist(BuildContext context, audioModel element) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: bggradient1,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(50))),
          width: double.infinity,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 15,
              right: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Выбрать плейлист',
                    style: TextStyle(
                        color: white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<PlaylistBloc, PlaylistState>(
                  builder: (context, state) {
                    return Expanded(
                        child: state.playlistNames.isEmpty
                            ? const Center(
                                child: Text(
                                  'Плейлисты отсутствуют',
                                  style: TextStyle(color: white),
                                ),
                              )
                            : ListView.builder(
                                itemCount: state.playlistNames.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      List<audioModel> _plylstsongs = dbBox
                                          .get(state.playlistNames[index])!
                                          .cast<audioModel>();
                                      Navigator.of(context).pop();
                                    },
                                    child: ListTile(
                                      title: Text(
                                        state.playlistNames[index],
                                        style: const TextStyle(color: white),
                                      ),
                                      trailing: checkAdded(
                                              element.songname,
                                              dbBox
                                                  .get(state
                                                      .playlistNames[index])!
                                                  .cast<audioModel>())
                                          ? const Text(
                                              'Данная песня уже добавлена',
                                              style: white30txt12,
                                            )
                                          : const Text(''),
                                    ),
                                  );
                                }));
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      createPlaylist(
                          context: context, addply: true, element: element);
                    },
                    child: const Text('Новый плейлист'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple))
              ],
            ),
          ),
        );
      });
}

Future addPlylstDb(
    BuildContext context, audioModel element, String _plylstName) async {
  BlocProvider.of<PlaylistInfoBloc>(context)
      .add(AddSongToPlaylist(boxKey: _plylstName, songDatas: element));
}
