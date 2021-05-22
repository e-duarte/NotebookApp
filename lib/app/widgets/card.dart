import 'package:flutter/material.dart';
import 'package:notebook_app/app/widgets/user_icon.dart';

class CardItem extends StatefulWidget {
  final String manager;
  final String managerSession;
  final String managerName;
  final String user;

  CardItem({
    this.managerName,
    this.manager,
    this.managerSession,
    this.user,
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
                // Text('dd/mm/yyyy'),
              ],
            ),
            Text('${widget.user}')
          ],
        ),
      ),
    );
  }
}
