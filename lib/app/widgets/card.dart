import 'package:flutter/material.dart';
import 'package:notebook_app/app/widgets/user_icon.dart';

class CardItem extends StatefulWidget {
  String name;
  String username;
  String role;
  String usernameSesion;
  String user;

  CardItem(
      {this.name, this.username, this.role, this.usernameSesion, this.user});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        height: MediaQuery.of(context).size.height * 0.12,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  child: UserIcon(
                    username: widget.name,
                    size: 0.1,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                    '${widget.username == widget.usernameSesion ? 'Você' : widget.username} agendou um horário'),
                Text('dd/mm/yyyy'),
              ],
            ),
            Text('${widget.user}')
          ],
        ),
      ),
    );
  }
}
