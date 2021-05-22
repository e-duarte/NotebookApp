import 'package:flutter/foundation.dart';

class Manager extends ChangeNotifier {
  String id;
  String name;
  String username;
  String password;
  String role;

  Manager({this.id, this.name, this.password, this.username, this.role});

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      id: json['_id'],
      name: json['name'],
      password: json['password'],
      username: json['username'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      id: id,
      name: name,
      password: password,
      username: username,
      role: role,
    };
  }

  void fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    role = json['role'];

    notifyListeners();
  }
}
