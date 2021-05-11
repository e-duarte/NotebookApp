import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  String name;
  String username;
  String role;

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 50,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Text('Você agendou o horário x'),
                Text('dd/mm/yyyy'),
              ],
            ),
            Text('usuário')
          ],
        ),
      ),
    );
  }
}
