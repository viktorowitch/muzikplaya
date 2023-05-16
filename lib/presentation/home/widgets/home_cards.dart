import 'package:flutter/material.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/presentation/recent/recent.dart';
import 'package:muzikplaya/presentation/playlist/playlist.dart';

class TopHomeCards extends StatelessWidget {
  const TopHomeCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const Recent();
            }));
          },
          child: Container(
            width: screenwidth * 0.22,
            height: screenheight * 0.14,
            decoration: contborder,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.watch_later_rounded,
                  color: white,
                  size: 30,
                ),
                SizedBox(
                  height: screenheight * 0.015,
                ),
                const Text(
                  'Недавние',
                  style: TextStyle(color: white, fontSize: 16),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const musicPlaylist();
            }));
          },
          child: Container(
            width: screenwidth * 0.22,
            height: screenheight * 0.14,
            decoration: contborder,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.my_library_music,
                  color: white,
                  size: 30,
                ),
                SizedBox(
                  height: screenheight * 0.015,
                ),
                const Text(
                  'Плейлисты',
                  style: TextStyle(color: white, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
