import 'package:flutter/material.dart';
import 'package:notebook_app/app/pages/agenda.dart';
import 'package:notebook_app/app/pages/chart_page.dart';
import 'package:notebook_app/app/pages/feed.dart';
import 'package:notebook_app/app/pages/usersPage.dart';
import 'package:notebook_app/app/widgets/user_icon.dart';
import 'package:provider/provider.dart';
import 'package:notebook_app/app/models/manager.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  int _index = 0;

  final List<Widget> screens = [
    Feed(),
    Agenda(),
    UsersPage(),
    ChartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        title: Text(
          'NotebookApp',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          Consumer<Manager>(builder: (context, manager, child) {
            return IconButton(
              icon: UserIcon(
                username: manager.name,
                size: 0.5,
                fontSize: 16.0,
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                '/manager',
                arguments: {
                  'manager': manager.username,
                  'managerRole': manager.role,
                  'managerName': manager.name,
                },
              ),
            );
          }),
        ],
      ),
      body: screens[_index],
      bottomNavigationBar: BottomNavigatorHome(
        callback: changeIndex,
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      _index = index;
    });
  }
}

class BottomNavigatorHome extends StatefulWidget {
  final callback;

  BottomNavigatorHome({this.callback});

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

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _index,
      onTap: (int index) {
        setState(() {
          _index = index;
          widget.callback(index);
        });
      },
      items: List.generate(labels.length, (index) {
        return BottomNavigationBarItem(
          icon: Icon(icons[index]),
          label: labels[index],
        );
      }),
    );
  }
}
