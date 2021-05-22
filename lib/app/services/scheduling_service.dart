import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:notebook_app/app/models/scheduling.dart';

class SchedulingService {
  final url = '192.168.57.1:3333';

  Future<List<Scheduling>> all() async {
    var response = await http.get(Uri.http(url, 'schedulings'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Scheduling> schedulings =
          List<Scheduling>.from(l.map((model) => Scheduling.fromJson(model)));
      return schedulings;
    } else if (response.statusCode == 404) {
      throw Exception('No data...');
    } else {
      throw Exception('Falha ao carregar dados...');
    }
  }

  Future<Map<String, dynamic>> store(Scheduling scheduling) async {
    final msg = jsonEncode(scheduling.toJson());

    var response = await http.post(Uri.http(url, 'schedulings'),
        body: msg, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('No data...');
    } else {
      throw Exception('Falha ao carregar dados...');
    }
  }
}
