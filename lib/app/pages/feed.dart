import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/manager.dart';
import 'package:provider/provider.dart';

class Feed extends StatelessWidget {
  final title;

  Feed({this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<Manager>(
      builder: (context, manager, child) {
        return Center(
          child: Text('Hello ${manager.name}'),
        );
      },
    );
  }
}
