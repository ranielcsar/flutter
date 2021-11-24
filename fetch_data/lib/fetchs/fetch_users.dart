import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<dynamic>> fetchUsers() async {
  final response =
      await http.get(Uri.parse('https://randomuser.me/api/?results=10'));
  final result = jsonDecode(response.body)['results'];

  if (response.statusCode == 200) {
    return result;
  } else {
    throw Exception('Falha ao carregar usuário.');
  }
}
