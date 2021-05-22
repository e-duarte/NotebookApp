import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:notebook_app/app/models/manager.dart';
import 'package:notebook_app/app/models/scheduling.dart';
import 'package:notebook_app/app/models/users.dart';
import 'package:notebook_app/app/services/scheduling_service.dart';
import 'package:notebook_app/app/services/user_service.dart';
import 'package:provider/provider.dart';

class SchedulingPage extends StatefulWidget {
  final String managerId;
  SchedulingPage({this.managerId});

  @override
  _SchedulingStatePage createState() => _SchedulingStatePage();
}

class _SchedulingStatePage extends State<SchedulingPage> {
  final _keyForm = GlobalKey<FormState>();
  Color _background;
  String _eventName;
  DateTime _from;
  DateTime _to;
  String _description;
  bool _isAllDay;
  bool _isRepeate;
  bool _isStudent;
  User _dropdownUser;

  @override
  void initState() {
    super.initState();
    _from = DateTime.now();
    _to = DateTime.now();
    _isAllDay = false;
    _isStudent = true;
    _isRepeate = false;
    _background = Colors.redAccent;

    // _dropdownIdStudent = 'escolha o usuario';
    // _dropdownIdTeacher = 'escolha o usuario';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Schedulings>(builder: (context, schedulings, child) {
      return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context));
            },
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.07,
          title: Text(
            'Agendamento',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.check_rounded, color: Colors.white),
                onPressed: () {
                  _keyForm.currentState.save();

                  final schedulingFuture = SchedulingService().store(Scheduling(
                    user: _dropdownUser,
                    manager: Provider.of<Manager>(context, listen: false),
                    background: _background,
                    eventName: _eventName,
                    from: _from,
                    to: _to,
                    description: _description,
                    isAllDay: _isAllDay,
                    isRepeate: _isRepeate,
                  ));

                  schedulingFuture.then((json) {
                    final scheduling = Scheduling.fromJson(json);
                    print(scheduling);
                    schedulings.addItem(scheduling);
                    Navigator.pop(context);
                  });
                })
          ],
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            // color: Colors.amber,
            child: Form(
              key: _keyForm,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: _isStudent
                                ? Colors.redAccent
                                : Colors.greenAccent,
                            shape: BoxShape.circle),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Título do Agendamento',
                    ),
                    onSaved: (eventName) => _eventName = eventName,
                  ),
                  SwitchListTile(
                    title: Text('O dia todo'),
                    activeColor: Colors.cyan,
                    value: _isAllDay,
                    onChanged: (isAllDay) {
                      setState(() {
                        _isAllDay = isAllDay;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Repetir'),
                    activeColor: Colors.cyan,
                    value: _isRepeate,
                    onChanged: (repeate) {
                      setState(() {
                        _isRepeate = repeate;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Text('De'),
                      TextButton(
                        onPressed: () {
                          DatePicker.showDateTimePicker(
                            context,
                            theme:
                                DatePickerTheme(backgroundColor: Colors.white),
                            showTitleActions: true,
                            minTime: DateTime(2021, 01, 01),
                            maxTime: DateTime(2021, 12, 31),
                            onChanged: (date) {
                              setState(() {
                                _from = date;
                              });
                            },
                            onConfirm: (date) {
                              print(date);
                              setState(() {
                                _from = date;
                              });
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.pt,
                          );
                        },
                        child: Text(
                          '$_from',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Às'),
                      TextButton(
                        onPressed: () {
                          DatePicker.showDateTimePicker(
                            context,
                            theme:
                                DatePickerTheme(backgroundColor: Colors.white),
                            showTitleActions: true,
                            minTime: DateTime(2021, 01, 01),
                            maxTime: DateTime(2021, 12, 31),
                            onChanged: (date) {
                              setState(() {
                                _to = date;
                              });
                            },
                            onConfirm: (date) {
                              print(date);
                              setState(() {
                                _to = date;
                              });
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.pt,
                          );
                        },
                        child: Text(
                          '$_to',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Qual é o motivo do agendamento?',
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onSaved: (description) => _description = description,
                  ),
                  SwitchListTile(
                    title: Text(_isStudent ? 'Aluno' : 'Professor'),
                    activeColor: Colors.cyan,
                    value: _isStudent,
                    onChanged: (studant) {
                      setState(
                        () {
                          _isStudent = studant;
                          _background = _isStudent
                              ? Colors.redAccent
                              : Colors.greenAccent;
                          print(_background);
                        },
                      );
                    },
                  ),
                  FutureBuilder(
                      future: UserService().all(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: Text("Carregando..."));
                          default:
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("Erro ao carregar..."),
                              );
                            } else if (snapshot.hasData) {
                              List<User> students = snapshot.data
                                  .where((user) => user is Student)
                                  .toList();
                              List<User> teachers = snapshot.data
                                  .where((user) => user is Teacher)
                                  .toList();

                              print(students[0].name);
                              print(teachers[0].name);

                              _dropdownUser =
                                  _isStudent ? students.first : teachers.first;
                              return DropdownButton<User>(
                                value: _dropdownUser,
                                onChanged: (user) {
                                  setState(() {
                                    _dropdownUser = user;
                                  });
                                },
                                items: _isStudent
                                    ? students.map((User user) {
                                        return DropdownMenuItem<User>(
                                          child: Text(user.name),
                                          value: user,
                                        );
                                      }).toList()
                                    : teachers.map((User user) {
                                        return DropdownMenuItem<User>(
                                          child: Text(user.name),
                                          value: user,
                                        );
                                      }).toList(),
                              );
                            }
                        }
                        return Container();
                      }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
