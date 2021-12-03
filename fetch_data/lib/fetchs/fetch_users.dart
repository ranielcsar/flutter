import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<dynamic>> fetchUsers(int? page) async {
  final response = await http.get(
      Uri.parse('https://randomuser.me/api/?page=$page&results=10&nat="br"'));
  final result = jsonDecode(response.body)['results'];

  if (response.statusCode == 200) {
    return result;
  } else {
    throw Exception('Falha ao carregar usuário.');
  }
}
