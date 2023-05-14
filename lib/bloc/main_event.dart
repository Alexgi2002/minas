// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_bloc.dart';

@immutable
abstract class MainEvent{}


class Init extends MainEvent {
  int rows, columns, mines;
  // List<Tile> list;

  Init({
    required this.rows,
    required this.columns,
    required this.mines,
    // required this.list,
  });
   
}

class Reveal extends MainEvent {
  int postile;

  Reveal({
    required this.postile,
  });
   
}

class Flagged extends MainEvent {
  int postile;

  Flagged({
    required this.postile,
  });
   
}