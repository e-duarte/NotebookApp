import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/manager.dart';
import 'package:notebook_app/app/models/users.dart';

class Scheduling {
  Scheduling({
    this.manager,
    this.user,
    this.eventName,
    this.from,
    this.to,
    this.background,
    this.isAllDay,
    this.isRepeate,
    this.description,
    this.createdAt,
  });

  factory Scheduling.fromJson(Map<String, dynamic> json) {
    return Scheduling(
      manager: Manager.fromJson(json['manager']),
      user: json['user']['type'] == 'student'
          ? Student.fromJson(json['user'])
          : Teacher.fromJson(json['user']),
      eventName: json['eventName'],
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      background: Color(json['background']),
      isAllDay: json['isAllDay'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'manager': this.manager.id,
      'user': this.user.id,
      'eventName': this.eventName,
      'from': this.from.toString(),
      'to': this.to.toString(),
      'background': this.background.value,
      'isAllDay': this.isAllDay,
      'isRepeate': this.isRepeate,
      'description': this.description
    };
  }

  Manager manager;
  User user;
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  bool isRepeate;
  String description;
  DateTime createdAt;
}

class Schedulings extends ChangeNotifier {
  List<Scheduling> _schedulings = [];

  void addItem(Scheduling scheduling) {
    _schedulings.add(scheduling);
    notifyListeners();
  }

  List<Scheduling> getSchedulings() => _schedulings;
}
