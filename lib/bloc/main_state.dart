// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_bloc.dart';

class MainState {

  bool looser, winner;
  List<Tile> _listTiles;

  MainState(
    this.winner,
    this.looser,
    this._listTiles,
  );

  // bool get loading => _loading;  
  
  List<Tile> get listTiles => _listTiles; 

}
