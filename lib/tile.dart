// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Tile {
  bool isMine;
  bool mark;
  bool flagged;
  String number;
  Color color;
  Tile({
    required this.isMine,
    required this.number,
    required this.color,
    required this.mark,
    required this.flagged
  });

  @override
  String toString() {
    // TODO: implement toString
    return "- $number";
  }
}
