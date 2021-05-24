import 'package:flutter/material.dart';
import 'package:notebook_app/app/widgets/user_icon.dart';

class CardItem extends StatefulWidget {
  final String manager;
  final String managerSession;
  final String managerName;
  final String user;
  final String duration;

  CardItem({
    this.managerName,
    this.manager,
    this.managerSession,
    this.user,
    this.duration,
  });

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
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.02),
                  width: 30,
                  height: 30,
                  child: UserIcon(
                    username: widget.managerName,
                    size: 0.1,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                    '${widget.manager == widget.managerSession ? 'Você' : widget.manager} agendou um horário'),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.17),
                  child: Text(widget.duration),
                ),
              ],
            ),
            Text('${widget.user}')
          ],
        ),
      ),
    );
  }
}
