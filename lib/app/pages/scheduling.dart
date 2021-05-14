import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Scheduling extends StatefulWidget {
  @override
  _SchedulingState createState() => _SchedulingState();
}

class _SchedulingState extends State<Scheduling> {
  final _keyForm = GlobalKey<FormState>();
  String _eventName;
  bool _isAllDay;
  bool _student;
  DateTime _from;
  DateTime _to;
  Color _background;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _from = DateTime.now();
    _isAllDay = false;
    _student = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.close),
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
              icon: Icon(Icons.check_rounded),
              onPressed: () {
                _keyForm.currentState.save();
                print(_eventName);
              })
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          // color: Colors.amber,
          child: Form(
            key: _keyForm,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          color:
                              _student ? Colors.redAccent : Colors.greenAccent,
                          shape: BoxShape.circle),
                    )
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
                  title: Text('Aluno'),
                  activeColor: Colors.cyan,
                  value: _student,
                  onChanged: (student) {
                    setState(() {
                      _student = student;
                      _background =
                          _student ? Colors.redAccent : Colors.greenAccent;
                    });
                  },
                ),
                Row(
                  children: [
                    Text('De'),
                    TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          theme: DatePickerTheme(backgroundColor: Colors.white),
                          showTitleActions: true,
                          minTime: DateTime(2021, 01, 01),
                          maxTime: DateTime(2021, 12, 31),
                          onChanged: (date) {
                            setState(() {
                              _from = date;
                            });
                          },
                          onConfirm: (date) {
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
                    Divider()
                  ],
                ),
                Row(
                  children: [
                    Text('Às'),
                    TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          theme: DatePickerTheme(backgroundColor: Colors.white),
                          showTitleActions: true,
                          minTime: DateTime(2021, 01, 01),
                          maxTime: DateTime(2021, 12, 31),
                          onChanged: (date) {
                            setState(() {
                              _from = date;
                            });
                          },
                          onConfirm: (date) {
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
                Divider(),
                SwitchListTile(
                  title: Text('Repetir'),
                  activeColor: Colors.cyan,
                  value: _student,
                  onChanged: (student) {
                    setState(() {
                      _student = student;
                      _background =
                          _student ? Colors.redAccent : Colors.greenAccent;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Qual é o motivo do agendamento',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
