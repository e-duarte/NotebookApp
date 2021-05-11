import 'package:flutter/material.dart';
import 'dart:math';

class UserIcon extends StatelessWidget {
  final username;
  final size;
  final fontSize;

  final colors = [
    Colors.grey,
    Colors.amber,
    Colors.blue,
    Colors.blueGrey,
    Colors.deepOrange
  ];

  UserIcon({this.username, this.size, this.fontSize});

  @override
  Widget build(BuildContext context) {
    var rng = new Random();
    print(username[0]);
    return Container(
      width: MediaQuery.of(context).size.height * size,
      height: MediaQuery.of(context).size.height * size,
      decoration: BoxDecoration(
        color: colors[rng.nextInt(colors.length)],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          username[0],
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
