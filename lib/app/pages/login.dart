import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/manager.dart';
import 'package:notebook_app/app/services/login_service.dart';
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
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
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
                      hintText: 'Nome de usuário',
                    ),
                    onSaved: (username) => _username = username,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Senha',
                    ),
                    obscureText: true,
                    onSaved: (password) => _password = password,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Conectar'),
                      onPressed: () {
                        _keyForm.currentState.save();
                        print(_password);

                        // Map<String, dynamic> json = {
                        //   'id': '987',
                        //   'username': _username,
                        //   'password': _password,
                        //   'name': 'Ewerton Duarte',
                        //   'role': 'Instrutor',
                        // };

                        final future =
                            LoginService().login(_username, _password);
                        future.then((json) {
                          if (json != null) {
                            print(json);
                            manager.fromJson(json);
                            print(manager.id);

                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            throw Exception('Falha ao carregar dados...');
                          }
                        });
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
