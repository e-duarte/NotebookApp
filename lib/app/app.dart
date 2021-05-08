import 'package:flutter/material.dart';
import 'package:notebook_app/app/navigator_main.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NotebookApp',
      theme: ThemeData(
        primaryColor: Colors.greenAccent,
      ),
      home: BottomNavigatorHome(),
    );
  }
}
