import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzikplaya/application/playlist/playlist_bloc.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/domain/model/data_model.dart';
import 'package:muzikplaya/presentation/playlist/playlist.dart';
import 'package:muzikplaya/presentation/playlist/widgets/add_playlist.dart';
import 'package:muzikplaya/splash.dart';

createPlaylist(
    {required BuildContext context,
    required bool addply,
    audioModel? element}) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(255, 0, 87, 92),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 40,
            left: 20,
            right: 20,
            bottom: 30,
          ),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Создать плейлист',
                  style: TextStyle(
                    color: white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: playlistctrl,
                  style: const TextStyle(color: white),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Имя плейлиста',
                      hintStyle: TextStyle(color: Colors.grey[350])),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          playlistctrl.clear();
                        },
                        child: const Text('Отмена'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.grey)),
                      ),
                    ),
                    SizedBox(
                        width: 100,
                        height: 45,
                        child: addply
                            ? ElevatedButton(
                                onPressed: () async {
                                  final _plylistname = playlistctrl.text.trim();
                                  if (_plylistname.isEmpty) {
                                    return;
                                  } else {
                                    List<audioModel> _demoList = [];
                                    List<String> plylst = dbBox
                                        .get(plylstlisting)!
                                        .cast<String>();
                                    plylst.add(_plylistname);
                                    await dbBox.put(plylstlisting, plylst);
                                    await dbBox.put(_plylistname, _demoList);
                                    await addPlylstDb(
                                        context, element!, _plylistname);
                                  }

                                  Navigator.of(context).pop();
                                  playlistctrl.clear();
                                },
                                child: const Text('Создать'))
                            : ElevatedButton(
                                onPressed: () async {
                                  final _plylistname = playlistctrl.text.trim();
                                  if (_plylistname.isEmpty) {
                                    return;
                                  } else {
                                    BlocProvider.of<PlaylistBloc>(context).add(
                                        CreatePlylistNames(
                                            plylistName: _plylistname));
                                    List<audioModel> _plylstsngs = [];
                                    await dbBox.put(_plylistname, _plylstsngs);
                                  }
                                  Navigator.of(context).pop();
                                  playlistctrl.clear();
                                },
                                child: const Text('Создать'))),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
