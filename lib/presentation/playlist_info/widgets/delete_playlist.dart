import 'package:flutter/material.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzikplaya/application/playlist/playlist_bloc.dart';
import 'package:muzikplaya/presentation/playlist/playlist.dart';
import 'package:muzikplaya/splash.dart';

void deleteplaylist(
    {required BuildContext context,
    required bool isMultiDelete,
    String? boxkey,
    List<String>? selectedPlylsts}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Удалить плейлист?'),
          content: isMultiDelete
              ? const Text('Удаляем выбранные плейлисты?')
              : const Text('Удаляем плейлист?'),
          actions: [
            isMultiDelete
                ? TextButton(
                    onPressed: () async {
                      List<String> plylst =
                          dbBox.get(plylstlisting)!.cast<String>();
                      for (final data in selectedPlylsts!) {
                        plylst.remove(data);
                        await dbBox.delete(data);
                      }

                      await dbBox.put(plylstlisting, plylst);
                      BlocProvider.of<PlaylistBloc>(context)
                          .add(const UnselectAll());
                      Navigator.of(context).pop();
                    },
                    child: const Text('Да'))
                : TextButton(
                    onPressed: () async {
                      List<String> plylst =
                          dbBox.get(plylstlisting)!.cast<String>();
                      plylst.remove(boxkey);
                      await dbBox.put(plylstlisting, plylst);
                      await dbBox.delete(boxkey);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const musicPlaylist()),
                          (route) => false);
                    },
                    child: const Text('Да')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Нет')),
          ],
        );
      });
}
