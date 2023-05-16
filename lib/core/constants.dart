import 'package:flutter/material.dart';

final Color bggradient1 = Colors.green;
final Color bodyclr = Colors.grey;
final Color bggradient2 = Colors.greenAccent;
final Color nowplayingbottom = Colors.green;
const Color white = Colors.white;
final Color homecardscolor = Colors.grey;

const TextStyle whitetxt22 = TextStyle(color: white, fontSize: 22);
const TextStyle whitetxt18 = TextStyle(color: white, fontSize: 18);
const TextStyle whitetxt15 = TextStyle(color: white, fontSize: 15);
const TextStyle white30txt12 = TextStyle(color: Colors.white30, fontSize: 12);
const TextStyle white54txt14 = TextStyle(color: Colors.white54, fontSize: 14);

final Decoration contborder = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: homecardscolor,
);

final Decoration mymusicdecor = BoxDecoration(
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40), topRight: Radius.circular(40)),
    color: homecardscolor);

const String prefKey = 'sharedpref';
const String plylstlisting = 'plylist';
