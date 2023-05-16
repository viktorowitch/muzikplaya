import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:muzikplaya/application/home/home_bloc.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/presentation/home/widgets/current_playing.dart';
import 'package:muzikplaya/presentation/home/widgets/search.dart';
import 'package:muzikplaya/presentation/home/widgets/songs_list.dart';
import 'package:muzikplaya/domain/play_song.dart';
import 'package:muzikplaya/presentation/home/widgets/home_cards.dart';
import 'package:muzikplaya/splash.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [bggradient1, bggradient2])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              actions: [
                IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: SongSearch());
                    },
                    icon: const Icon(Icons.search_rounded))
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: screenheight * 0.03,
                ),
                const TopHomeCards(),
                SizedBox(
                  height: screenheight * 0.06,
                ),
                Expanded(
                    child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: mymusicdecor,
                      width: screenwidth,
                      height: screenheight,
                      padding:
                          const EdgeInsets.only(top: 45, left: 25, right: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Моя музыка',
                            style: TextStyle(color: white, fontSize: 20),
                          ),
                          SizedBox(
                            height: screenheight * 0.04,
                          ),
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    controller: ScrollController(
                                        keepScrollOffset: false),
                                    itemCount: finalsonglist.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          BlocProvider.of<HomeBloc>(context)
                                              .add(
                                                  const HomeEvent.songPlayed());
                                          playSong().playinglist(
                                              finalsonglist, index);
                                        },
                                        child: Songs(
                                            songData: finalsonglist[index],
                                            index: index),
                                      );
                                    }),
                                BlocBuilder<HomeBloc, HomeState>(
                                  builder: (context, state) {
                                    return state.isVisible
                                        ? const SizedBox(
                                            height: 70,
                                          )
                                        : const SizedBox(
                                            height: 10,
                                          );
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return Visibility(
                            visible: state.isVisible,
                            child: currentplayinghome());
                      },
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
