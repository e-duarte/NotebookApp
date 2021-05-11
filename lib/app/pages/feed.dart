import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/manager.dart';
import 'package:notebook_app/app/widgets/card.dart';
import 'package:provider/provider.dart';

class Feed extends StatelessWidget {
  final title;

  Feed({this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<Manager>(
      builder: (context, manager, child) {
        return Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.02),
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Bem-vindo',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          manager.username,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                );
              }
              // Here is acess the REST API
              return CardItem(
                username: manager.username,
                name: manager.name,
                usernameSesion: manager.username,
                user: 'Xablau',
              );
            },
          ),
        );
      },
    );
  }
}
