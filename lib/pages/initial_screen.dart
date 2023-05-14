import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:minas/bloc/main_bloc.dart';
import 'package:minas/constants.dart';
import 'package:minas/pages/play_screen.dart';
import 'package:minas/tile.dart';
import 'package:numberpicker/numberpicker.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final height = screenSize.height - 50;
    final width = screenSize.width;
    
    return Scaffold(
      bottomNavigationBar: Container(
        height: 35,
        alignment: AlignmentDirectional.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text("@Cemisoft", style: TextStyle(color: Colors.grey),),
        )),
        
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (screenSize.width / 2) / (height / (2)),
          children: [
            AnimationConfiguration.staggeredGrid(
                position: 0,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Container(
                    margin: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: (() {
                        Util.buildPlay(context, 5, 5, 6, false);
                      }),
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.zero,
                        color: Colors.green,
                        // color: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("5x5", textAlign: TextAlign.start, style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold, color: Colors.white),),
                            Text("6 minas", textAlign: TextAlign.start, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                      ),
                  ),
                ),
              ),
              AnimationConfiguration.staggeredGrid(
                position: 1,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Container(
                    margin: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: (() {
                        Util.buildPlay(context, 6, 6, 8, false);
                      }),
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.zero,
                        color: Colors.orange,
                        // color: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("6x6", textAlign: TextAlign.start, style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold, color: Colors.white),),
                            Text("8 minas", textAlign: TextAlign.start, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                      ),
                  ),
                ),
              ),
              AnimationConfiguration.staggeredGrid(
                position: 2,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Container(
                    margin: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: (() {
                        Util.buildPlay(context, 8, 8, 10, false);
                      }),
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.zero,
                        color: Colors.red,
                        // color: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("8x8", textAlign: TextAlign.start, style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),),
                            Text("10 minas", textAlign: TextAlign.start, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                      ),
                  ),
                ),
              ),
              AnimationConfiguration.staggeredGrid(
                position: 3,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Container(
                    margin: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: (() async {
                        final data = await showModalBottomSheet<List<int>>(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                backgroundColor: ThemeData.dark().bottomAppBarColor,
                                context: context,
                                builder: ((context) {
                                  return SheetPersonalizar();
                                })
                              );/*.then((value){
                                if(value!=null && value.length>0) Util.buildPlay(context, value[0], value[1], value[2], false);
                                return value;
                              });*/
                          if(data!=null && data.length>0) Util.buildPlay(context, data[0], data[1], data[2], false);
                      }),
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.zero,
                        color: Colors.brown,
                        // color: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("?", textAlign: TextAlign.start, style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold, color: Colors.white),),
                            Text("Personalizado", textAlign: TextAlign.start, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                      ),
                  ),
                ),
              ),
          ],
        ),
      )
    );
  }
  
}

class SheetPersonalizar extends StatefulWidget {
    const SheetPersonalizar({super.key});
  
    @override
    State<SheetPersonalizar> createState() => _SheetPersonalizarState();
  }
  
  class _SheetPersonalizarState extends State<SheetPersonalizar> {

    int cantFilas = 4;
    int cantColumnas = 4;
    int cantMinas = 1;

    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          SizedBox(height: 20,),
          Text("Personalizar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
          SizedBox(height: 10,),
          Text("Cantidad de columnas"),
          NumberPicker(
            axis: Axis.horizontal,
            minValue: 4, 
            maxValue: 10,
            value: cantColumnas,
            onChanged: ((value) {
              setState(() {
                cantColumnas = value;
                if(cantFilas>cantColumnas) cantFilas = cantColumnas;
                if(cantMinas > (cantColumnas*cantFilas)/2) cantMinas = ((cantColumnas*cantFilas)/2).toInt();
              });
            })
          ),
          SizedBox(height: 10,),
          Text("Cantidad de filas"),
          NumberPicker(
            axis: Axis.horizontal,
            minValue: 4, 
            maxValue: cantColumnas,
            value: cantFilas,
            onChanged: ((value) {
              setState(() {
                cantFilas = value;
                if(cantMinas > (cantColumnas*cantFilas)/2) cantMinas = ((cantColumnas*cantFilas)/2).toInt();
              });
            })
          ),
          SizedBox(height: 10,),
          Text("Cantidad de minas"),
          NumberPicker(
            axis: Axis.horizontal,
            minValue: 1, 
            maxValue: ((cantFilas * cantColumnas) / 2).toInt(),
            value: cantMinas,
            onChanged: ((value) {
              setState(() {
                cantMinas = value;
              });
            })
          ),
          SizedBox(height: 20,),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context, [cantFilas, cantColumnas, cantMinas]);
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Text(" Crear plantilla "),
            color: Colors.green,
            textColor: Colors.white,
          ),
        ],
      );
    }
  }