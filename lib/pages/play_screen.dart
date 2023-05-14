import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:minas/bloc/main_bloc.dart';
import 'package:minas/constants.dart';
import 'package:minas/tile.dart';

class PlayPage extends StatelessWidget {
  final int columns;
  final int rows;
  final int minas;
  bool m = false;

  PlayPage(this.rows, this.columns, this.minas, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final height = screenSize.height - kBottomNavigationBarHeight;
    final width = screenSize.width;

    // BlocProvider.of<MainBloc>(context).add(Loading(loading: true));

    return Scaffold(
        bottomNavigationBar: Container(
          color: ThemeData.dark().bottomAppBarColor,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(child: Row(
                children: [
                  Icon(Icons.flag_rounded),
                  Text("Minas: $minas"),
                ],
              )),
              Icon(Icons.timer_rounded),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: SizedBox(
              height: screenSize.height * 0.6,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                ),
                // childAspectRatio: (screenSize.width / columns) / (height / (rows)),
                shrinkWrap: true,
                itemCount: columns * rows,
                itemBuilder: (context, index) {
                  // print("index: $index");
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 275),
                    columnCount: columns,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                          child: BlocBuilder<MainBloc, MainState>(
                        builder: (context, state2) {
                          if((state2.looser || state2.winner) && !m){
                            m=true;
                            String title, textButton;

                            state2.winner? title="Felicidades" : title="Juego terminado";
                            state2.winner? textButton="Jugar de nuevo" : textButton="Intentarlo de nuevo";
                            // HapticFeedback.vibrate();
                            Future.delayed(Duration(milliseconds: 500), (){
                              showModalBottomSheet(
                                backgroundColor: ThemeData.dark().bottomAppBarColor,
                                context: context,
                                builder: ((context) {
                                  return SizedBox(
                                    height: screenSize.height * 0.2,
                                    width: screenSize.width,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20,),
                                        Text(title, style: TextStyle(color: Colors.white, fontSize: 30),),
                                        SizedBox(height: 20,),
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Util.buildPlay(context, rows, columns, minas, true);
                                          },
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          child: Text(textButton),
                                          color: Colors.green,
                                          textColor: Colors.white,
                                        ),
                                      ]
                                    ),
                                  );
                                })
                              );
                            });
                          }
                          return Container(
                            margin: EdgeInsets.all(3),
                            child: GestureDetector(
                              onTap: (() {
                                HapticFeedback.selectionClick();
                                log("tap $index");
                                if(!state2.listTiles[index].mark) BlocProvider.of<MainBloc>(context)
                                    .add(Reveal(postile: index));
                              }),
                              onLongPress: () {
                                HapticFeedback.selectionClick();
                                if(!state2.listTiles[index].mark) BlocProvider.of<MainBloc>(context)
                                    .add(Flagged(postile: index));
                              },
                              child: Card(
                                elevation:
                                    state2.listTiles[index].mark ? 0 : 12,
                                margin: EdgeInsets.zero,
                                color: state2.listTiles[index].mark
                                    ? state2.listTiles[index].color
                                    : Colors.grey,
                                // color: Colors.grey.shade100,
                                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                    child: state2.listTiles[index].mark
                                    ? Text(state2.listTiles[index].number,
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        )
                                    : state2.listTiles[index].flagged? flag : Text("")
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }
}
