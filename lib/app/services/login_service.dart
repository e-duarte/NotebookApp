import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  final url = '192.168.57.1:3333';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final msg = jsonEncode({
      'username': username,
      'password': password,
    });

    var response = await http.post(Uri.http(url, 'login'),
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
