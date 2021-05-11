import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/manager.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _keyForm = GlobalKey<FormState>();

  String _username;

  String _password;

  @override
  Widget build(BuildContext context) {
    return Consumer<Manager>(builder: (context, manager, child) {
      return Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(50),
            // color: Colors.amber,
            child: Form(
              key: _keyForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.cyan,
                    size: 50,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Username',
                    ),
                    onSaved: (username) => _username = username,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: (password) => _password = password,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('ENTER'),
                      onPressed: () {
                        _keyForm.currentState.save();

                        Map<String, dynamic> json = {
                          'username': _username,
                          'password': _password,
                          'name': 'Ewerton Duarte',
                          'role': 'Instrutor',
                        };

                        manager.setManager(json);
                        print(manager.name);

                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
