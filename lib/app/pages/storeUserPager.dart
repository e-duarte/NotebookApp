import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/users.dart';
import 'package:notebook_app/app/services/user_service.dart';
import 'package:provider/provider.dart';

class StoreUserPage extends StatefulWidget {
  @override
  _StoreUserPageState createState() => _StoreUserPageState();
}

class _StoreUserPageState extends State<StoreUserPage> {
  final _keyForm = GlobalKey<FormState>();

  bool _isStudent;
  String _name;
  String _school;
  String _room;
  String _region;

  @override
  void initState() {
    super.initState();
    _isStudent = true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Users>(builder: (context, users, child) {
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
            'Adicionar Usuário',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.check_rounded, color: Colors.white),
                onPressed: () {
                  _keyForm.currentState.save();
                  if (_isStudent) {
                    final student = Student(
                      name: _name,
                      school: _school,
                      room: _room,
                    );
                    final studentFuture = StudentService().store(student);
                    studentFuture.then((json) {
                      final responsedStudent = Student.fromJson(json);
                      users.addItem(responsedStudent);
                      Navigator.pop(context);
                    });
                  } else {
                    final teacher = Teacher(
                      name: _name,
                      school: _school,
                      region: _region,
                    );
                    final teacherFuture = TeacherService().store(teacher);
                    teacherFuture.then((json) {
                      final responsedTeacher = Teacher.fromJson(json);
                      users.addItem(responsedTeacher);
                      Navigator.pop(context);
                    });
                  }
                }),
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
                  SwitchListTile(
                    title: Text('Aluno'),
                    activeColor: Colors.cyan,
                    value: _isStudent,
                    onChanged: (studant) {
                      setState(
                        () {
                          _isStudent = studant;
                        },
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nome do usuario',
                    ),
                    onSaved: (name) => _name = name,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Escola',
                    ),
                    onSaved: (school) => _school = school,
                  ),
                  _isStudent
                      ? Container()
                      : TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Região',
                          ),
                          onSaved: (region) => _region = region,
                        ),
                  _isStudent
                      ? TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Turma',
                          ),
                          onSaved: (room) => _room = room,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
