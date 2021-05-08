import 'package:flutter/material.dart';
import 'package:notebook_app/app/pages/home.dart';

class BottomNavigatorHome extends StatefulWidget {
  @override
  _BottomNavigatorHomeState createState() => _BottomNavigatorHomeState();
}

class _BottomNavigatorHomeState extends State<BottomNavigatorHome> {
  int _index = 0;
  final labels = ['Home', 'Agenda', 'Usuários', 'Relatório'];

  final icons = [
    Icons.home_rounded,
    Icons.calendar_today,
    Icons.person_add,
    Icons.trending_up,
  ];

  final List<Widget> screens = [
    Home(
      title: 'Home Page',
    ),
    Home(
      title: 'Agenda Page',
    ),
    Home(
      title: 'Usuários Page',
    ),
    Home(
      title: 'Relatório Page',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        title: Text(
          'Notebook App',
          style: TextStyle(color: Colors.black45),
        ),
        actions: [IconButton(icon: Icon(Icons.person))],
      ),
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (int index) {
          setState(() {
            _index = index;
          });
        },
        items: List.generate(labels.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(icons[index]),
            label: labels[index],
          );
        }),
      ),
    );
  }
}
