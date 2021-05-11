import 'package:flutter/material.dart';
import 'package:notebook_app/app/widgets/card.dart';
import 'package:notebook_app/app/widgets/user_icon.dart';

class ManagerPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        title: Text(
          arguments['name'].split(' ')[0] +
              ' ' +
              arguments['name'].split(' ').last,
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Card(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                  height: 150,
                  child: Center(
                    child: Column(
                      children: [
                        UserIcon(
                          username: arguments['name'],
                          size: 0.12,
                          fontSize: 45.0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(arguments['name']),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(arguments['username']),
                            Container(
                              width: 20,
                              child: Center(
                                child: Text('|'),
                              ),
                            ),
                            Text(arguments['role']),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return CardItem(
              username: arguments['username'],
              name: arguments['name'],
              usernameSesion: arguments['username'],
              user: 'Xablau',
            );
          },
        ),
      ),
    );
  }
}
