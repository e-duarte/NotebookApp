import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final title;

  Home({this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
