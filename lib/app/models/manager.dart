import 'package:flutter/foundation.dart';

class Manager extends ChangeNotifier {
  String name;
  String username;
  String password;
  String role;

  Manager({this.name, this.password, this.username, this.role});

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      name: json['name'],
      username: json['username'],
      password: json['password'],
      role: json['role'],
    );
  }

  void setManager(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    password = json['password'];
    role = json['role'];

    notifyListeners();
  }
}
