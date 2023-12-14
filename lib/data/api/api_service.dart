import 'dart:convert';

import 'package:my_stories_app/data/model/login_response.dart';
import 'package:my_stories_app/data/model/register_response.dart';
import 'package:http/http.dart' as http;
import 'package:my_stories_app/data/model/stories_response.dart';

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

  Future<LoginRespose> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    final errorMessage = json.decode(response.body)['message'];
    if (response.statusCode == 200) {
      return LoginRespose.fromJson(json.decode(response.body));
    } else {
      throw ('Failed to login. $errorMessage');
    }
  }

  Future<StoriesResponse> fetchStories(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/stories'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return StoriesResponse.fromJson(json.decode(response.body));
    } else {
      throw ('Failed to fetch stories. Status code: ${response.statusCode}');
    }
  }

  Future<StoriesDetailResponse> fetchStoryDetails(
      String id, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/stories/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return StoriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ('Failed to fetch stories. Status code: ${response.statusCode}');
    }
  }
}
