import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muzikplaya/application/home/home_bloc.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/domain/play_song.dart';
import 'package:muzikplaya/presentation/home/widgets/songs_list.dart';
import 'package:muzikplaya/splash.dart';

class SongSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    var result = query.isEmpty
        ? finalsonglist
        : finalsonglist
            .where((c) => c.metas.title!.toLowerCase().startsWith(query))
            .toList();
    return Container(
      color: bodyclr,
      child: result.isEmpty
          ? const Center(
              child: Text(
                'Нет результатов',
                style: TextStyle(color: white),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        playSong().playinglist(result, index);
                        BlocProvider.of<HomeBloc>(context)
                            .add(const HomeEvent.songPlayed());
                      },
                      child: Songs(songData: result[index], index: index),
                    );
                  }),
            ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = finalsonglist
        .where(
            (c) => c.metas.title!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    return Container(
      padding: const EdgeInsets.all(15),
      color: bodyclr,
      child: result.isEmpty
          ? const Center(
              child: Text(
                'Нет результатов',
                style: TextStyle(color: white),
              ),
            )
          : ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    playSong().playinglist(finalsonglist, index);
                    BlocProvider.of<HomeBloc>(context)
                        .add(const HomeEvent.songPlayed());
                  },
                  child: Songs(songData: result[index], index: index),
                );
              }),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(color: bggradient1),
        inputDecorationTheme:
            InputDecorationTheme(hintStyle: TextStyle(color: Colors.grey[400])),
        textTheme: const TextTheme(titleLarge: TextStyle(color: white)));
  }
}
