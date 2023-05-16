import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:muzikplaya/domain/model/data_model.dart';
import 'package:muzikplaya/presentation/home/home_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

final OnAudioQuery audioQuery = OnAudioQuery();
final Box<List> dbBox = StorageBox.getInstance();
List<SongModel> allsongs = [];
List<SongModel> sortedsongs = [];
List<audioModel> modelListSongs = [];
List<audioModel> dbsongs = [];
List<Audio> finalsonglist = [];
late bool prefbool;

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  Future gotoHome(BuildContext context) async {
    await requestPermission();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }

  requestPermission() async {
    bool status = await audioQuery.permissionsStatus();
    if (!status) {
      bool result = await audioQuery.permissionsRequest();
      if (result == true) {
        await getsongs();
      } else {
        exit(0);
      }
    } else if (status) {
      await getsongs();
    }
  }

  Future getsongs() async {
    allsongs = await audioQuery.querySongs();
    for (var element in allsongs) {
      if (element.fileExtension == "mp3" && element.duration! >= 30000) {
        sortedsongs.add(element);
      }
    }

    modelListSongs = sortedsongs
        .map((music) => audioModel(
            id: music.id,
            songname: music.title,
            artist: music.artist.toString(),
            songuri: music.uri!))
        .toList();

    await dbBox.put('mymusic', modelListSongs);
    dbsongs = dbBox.get('mymusic') as List<audioModel>;

    for (var element in dbsongs) {
      finalsonglist.add(Audio.file(element.songuri,
          metas: Metas(
              title: element.songname,
              artist: element.artist,
              id: element.id.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gotoHome(context);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/splash.jpg'),
      ),
    );
  }
}
