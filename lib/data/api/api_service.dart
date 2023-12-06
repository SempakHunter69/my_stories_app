import 'dart:convert';

import 'package:my_stories_app/data/model/register_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<RegisterResponse> registerUser(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    final errorMessage = json.decode(response.body)['message'];

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(json.decode(response.body));
    } else {
      throw ('Failed to register user. $errorMessage');
    }
  }
}
