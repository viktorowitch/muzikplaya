import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzikplaya/application/playlist/playlist_bloc.dart';
import 'package:muzikplaya/application/playlist_info/playlist_info_bloc.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/domain/model/data_model.dart';
import 'package:muzikplaya/presentation/playlist/widgets/create_playlist.dart';
import 'package:muzikplaya/presentation/playlist/widgets/playlist_album.dart';
import 'package:muzikplaya/presentation/playlist_info/playlist_info.dart';
import 'package:muzikplaya/presentation/playlist_info/widgets/delete_playlist.dart';
import 'package:muzikplaya/splash.dart';

TextEditingController playlistctrl = TextEditingController();

class musicPlaylist extends StatelessWidget {
  const musicPlaylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        return WillPopScope(
            onWillPop: () async {
              if (state.selectedList.isNotEmpty) {
                BlocProvider.of<PlaylistBloc>(context).add(const UnselectAll());
                return false;
              } else {
                return true;
              }
            },
            child: Scaffold(
                appBar: AppBar(
                  title: Text(state.selectedList.isNotEmpty
                      ? '${state.selectedList.length} Выбрано'
                      : 'плейлистов'),
                  centerTitle: true,
                  toolbarHeight: 65,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: state.selectedList.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            BlocProvider.of<PlaylistBloc>(context)
                                .add(const UnselectAll());
                          },
                          icon: const Icon(Icons.close))
                      : IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  actions: [
                    state.selectedList.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              deleteplaylist(
                                  context: context,
                                  isMultiDelete: true,
                                  selectedPlylsts: state.selectedList);
                            },
                            icon: const Icon(Icons.delete))
                        : IconButton(
                            onPressed: () {
                              createPlaylist(context: context, addply: false);
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 28,
                            )),
                    const SizedBox(
                      width: 7,
                    )
                  ],
                ),
                backgroundColor: bodyclr,
                body: state.playlistNames.isEmpty
                    ? const Center(
                        child: Text(
                          'Плейлисты отсутствуют',
                          style: whitetxt22,
                        ),
                      )
                    : GridView.builder(
                        padding:
                            const EdgeInsets.only(top: 30, left: 10, right: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 40),
                        itemCount: state.playlistNames.length,
                        itemBuilder: (context, index) {
                          final playlist = state.playlistNames[index];
                          bool isPlylstSelected =
                              state.selectedList.contains(playlist);
                          return InkWell(
                            onTap: () {
                              if (state.selectedList.isNotEmpty) {
                                BlocProvider.of<PlaylistBloc>(context).add(
                                    MultiSelection(selectedPlaylist: playlist));
                              } else {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return PlaylistInfo(
                                    boxkey: playlist,
                                    idx: index,
                                  );
                                }));
                              }
                            },
                            onLongPress: () {
                              BlocProvider.of<PlaylistBloc>(context).add(
                                  MultiSelection(selectedPlaylist: playlist));
                            },
                            child: BlocBuilder<PlaylistInfoBloc,
                                PlaylistInfoState>(
                              builder: (context, state) {
                                final List<audioModel> _allPlySongs =
                                    dbBox.get(playlist)!.cast<audioModel>();
                                return PlaylistAlbums(
                                  name: playlist,
                                  index: index,
                                  isSelected: isPlylstSelected,
                                  audioData: _allPlySongs,
                                );
                              },
                            ),
                          );
                        })));
      },
    );
  }
}
