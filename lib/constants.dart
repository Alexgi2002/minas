import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minas/pages/play_screen.dart';

import 'bloc/main_bloc.dart';

const number_0 = Colors.white;
const number_1 = Colors.blue;
const number_2 = Colors.green;
const number_3 = Color.fromARGB(255, 243, 179, 84);
const number_4 = Colors.orange;
const number_5 = Colors.red;
const number_6 = Colors.deepPurple;
const number_7 = Colors.purple;
const number_8 = Colors.pink;
// const number_9 = Colors.teal;

const Icon mine = Icon(Icons.swipe_down_alt_sharp, color: Colors.white,);
const Icon flag = Icon(Icons.flag_rounded, color: Colors.white, size: 30,);

class Util{
  static void buildPlay(BuildContext context, int rows, int columns, int minas, bool replace){
    BlocProvider.of<MainBloc>(context).add(Init(rows: rows, columns: columns, mines: minas));
    replace
    ? Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: ((context) {
        return PlayPage(rows, columns, minas);
      }))
    )
    : Navigator.push(
      context,
      MaterialPageRoute(builder: ((context) {
        return PlayPage(rows, columns, minas);
      }))
    );
  }
}