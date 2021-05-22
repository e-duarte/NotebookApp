import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/users.dart';
import 'package:notebook_app/app/services/user_service.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
        mini: true,
        onPressed: () {
          Navigator.pushNamed(context, '/storeuserpage');
        },
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: FutureBuilder(
          future: UserService().all(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao carregar..."),
                  );
                } else if (snapshot.hasData) {
                  List<User> users = List<User>.from(snapshot.data);

                  if (Provider.of<Users>(context, listen: true)
                          .getUsers()
                          .length !=
                      0) {
                    users.removeWhere((element) =>
                        element.name ==
                        Provider.of<Users>(context, listen: true)
                            .getUsers()
                            .last
                            .name);
                    users.addAll(
                        Provider.of<Users>(context, listen: true).getUsers());
                  }

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Card(
                        child: ListTile(
                          title: Text(user.name),
                          subtitle: Text(
                              '${user is Student ? "Aluno" : "Professor"} da ${user.school}'),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
            }
          },
        ),
      ),
    );
  }
}
