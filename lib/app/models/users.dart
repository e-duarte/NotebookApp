import 'package:flutter/widgets.dart';

class User {
  User({
    this.id,
    this.name,
    this.school,
  });

  String id;
  String name;
  String school;
}

class Teacher extends User {
  Teacher({
    String id,
    String name,
    String school,
    this.region,
  }) : super(id: id, name: name, school: school);

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['_id'],
      name: json['name'],
      school: json['school'],
      region: json['region'],
    );
  }

  String region;
}

class Student extends User {
  Student({
    String id,
    String name,
    String school,
    this.room,
  }) : super(id: id, name: name, school: school);

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      name: json['name'],
      school: json['school'],
      room: json['room'],
    );
  }

  String room;
}

class Users extends ChangeNotifier {
  List<User> _users = [];

  void addItem(User user) {
    _users.add(user);
    notifyListeners();
  }

  void addItems(List<User> users) {
    _users.addAll(users);
    notifyListeners();
  }

  List<User> getUsers() {
    return _users;
  }
}
