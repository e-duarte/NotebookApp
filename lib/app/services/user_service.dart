import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:notebook_app/app/models/users.dart';

class UserService {
  final url = '192.168.57.1:3333';
  Future<List<User>> all() async {
    var response = await http.get(Uri.http(url, 'users'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<User> users = List<User>.from(l.map((model) =>
          model['type'] == 'student'
              ? Student.fromJson(model)
              : Teacher.fromJson(model)));
      return users;
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Falha ao carregar dados...');
    }
  }

  Future<User> get(String id) async {
    var response = await http.get(Uri.http(url, 'users'),
        headers: {'Content-Type': 'application/json', 'id': id});

    if (response.statusCode == 200) {
      Map<String, dynamic> user = json.decode(response.body);

      return user['type'] == 'student'
          ? Student.fromJson(user)
          : Teacher.fromJson(user);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Falha ao carregar dados...');
    }
  }
}

class StudentService {
  final url = '192.168.57.1:3333';

  Future<Map<String, dynamic>> store(Student student) async {
    final msg = jsonEncode({
      'name': student.name,
      'school': student.school,
      'room': student.room,
      'type': 'student',
    });

    var response = await http.post(Uri.http(url, 'users'),
        body: msg, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Falha ao carregar dados...');
    }
  }
}

class TeacherService {
  final url = '192.168.57.1:3333';

  Future<Map<String, dynamic>> store(Teacher teacher) async {
    final msg = jsonEncode({
      'name': teacher.name,
      'school': teacher.school,
      'region': teacher.region,
      'type': 'teacher',
    });

    var response = await http.post(Uri.http(url, 'users'),
        body: msg, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Falha ao carregar dados...');
    }
  }
}
