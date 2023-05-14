import 'dart:developer';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:minas/constants.dart';
import 'package:minas/tile.dart';
import 'package:provider/provider.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState>{

  late int rows, columns, mines;

  MainBloc() : super(MainState(false, false, [])){

      on<Init>((event, emit){
        rows = event.rows;
        columns = event.columns;
        mines = event.mines;
        // print("row: $rows");
        // print("col: $columns");
        // print("mines: $mines");
        // state.listTiles.addAll(event.list);
        state.listTiles.clear();
        print("1");
        for(int i=0 ; i<rows*columns ; i++){
          print("2- $i");
          state.listTiles.add(Tile(isMine: false, number: "", color: Colors.grey, mark: false, flagged: false));
        }
        print("3");
        addMines();
        print("4");

        for(int i=0 ; i<rows*columns ; i++){
          print("$i ${state.listTiles[i].toString()}");
        }

        emit(MainState(false, false, state.listTiles));
      });

      on<Flagged>((event, emit){
        if(state.looser || state.winner) return;

        if(state.listTiles[event.postile].flagged) state.listTiles[event.postile].flagged = false;
        else state.listTiles[event.postile].flagged = true;
        
        HapticFeedback.vibrate();

        emit(MainState(state.winner, state.looser, state.listTiles));
      });

      on<Reveal>((event, emit) {
        //log("on reveal");

        if(!state.looser && !state.winner){
          int row = (event.postile / rows).toInt();
          int col = (event.postile - (row * rows)).toInt();
          bool win = false; 
          bool loose = false; 

          // print("pos: $row - $col");

          if (state.listTiles[event.postile].isMine) {
            // Game over
            loose = true;
            state.listTiles[event.postile].mark = true;
            for(final t in state.listTiles){
              if(t.isMine) t.mark = true;
            }
            
          } 
          else checkTile(event.postile, row, col);


          // to win
          int countToWin = 0;
          for(final t in state.listTiles){
            if(t.mark) countToWin++;
          }
          if(countToWin == ((columns * rows) - mines) && !loose) win = true;
          //to win

          emit(MainState(win, loose, state.listTiles));
        }
      });
  }

  void checkTile(int index, int row, int col){
    
    state.listTiles[index].mark = true;

    if(state.listTiles[index].number == "") {
      // Reveal the cell and adjacent cells
      state.listTiles[index].color = number_0;

      for (int r = row - 1; r <= row + 1; r++) {
      for (int c = col - 1; c <= col + 1; c++) {
        // print("pos for: $r - $c");
        if(r >= 0 && r < rows && c >= 0 && c < columns && !state.listTiles[(r * rows) + c].mark) {
          // state.listTiles[(r * rows) + c].mark = true;
          checkTile((r * rows) + c, r, c);
        }
      }
    }
          
    }

    
  }

  void addMines() {
    // Add the mines to random cells on the board
    var random = Random();
    int count = 0;
    while (count < mines) {
      int row = random.nextInt(rows);
      int col = random.nextInt(columns);
      int index = (row * rows) + col;

      print("3. $index");

      // print("Pos Mines: $row - $col");

      if(!state.listTiles[index].isMine) {
        state.listTiles[index].isMine = true;
        state.listTiles[index].color = number_5;
        state.listTiles[index].number = "X";
        count++;
      }
    }
    print("3. 1");

    // Add the numbers to the remaining cells
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        int index = (row * rows) + col;
        // print("index remaing: $index");
        if (!state.listTiles[index].isMine) {
          print("3. 2- $index");
          int count = countMines(row, col);
          if (count > 0) {
            state.listTiles[index].number = count.toString();
            state.listTiles[index].color = getColor(count);
            //print("countMines: $count");
          }
        }
      }
    }
    print("3. fin");
  }

  Color getColor(int n){
    Color c = number_0;
    switch(n){
      case 1: c = number_1; break;
      case 2: c = number_2; break;
      case 3: c = number_3; break;
      case 4: c = number_4; break;
      case 5: c = number_5; break;
      case 6: c = number_6; break;
      case 7: c = number_7; break;
      case 8: c = number_8; break;
      // case 9: c = number_9; break;
    }
    return c;
  }

  int countMines(int row, int col) {
    int count = 0;
    print("-------------------pos: $rows - $columns");
    print("-------------------pos: $row - $col");
    for (int r = row - 1; r <= row + 1; r++) {
      for (int c = col - 1; c <= col + 1; c++) {
        // print("---------pos for: $r - $c");
        int index = (r * rows) + c;
        print("---------pos: $r - $c - $index");
        if (r >= 0 && r < rows && c >= 0 && c < columns && index<rows*columns && state.listTiles[index].isMine) {
          count++;
        }
      }
    }
    print("3. 3");
    
    // print("countMines: $count");
    return count;
  }

}