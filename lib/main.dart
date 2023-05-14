import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minas/pages/initial_screen.dart';

import 'bloc/main_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: MaterialApp(
        title: 'Minas',
        theme: ThemeData.dark(
            
        ).copyWith(
          colorScheme: ColorScheme.dark(secondary: Colors.green)
        ),
        home: InitialPage(),
      ),
    );
  }
}
