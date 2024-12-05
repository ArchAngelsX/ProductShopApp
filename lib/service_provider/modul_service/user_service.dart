// ignore_for_file: unused_import, avoid_print

import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/products/user_model.dart';

class UserService {
  Future<List<Users>> getUsers() async {
    try {
      print('Connecting to API...'); // Log before API call
      final response = await http.get(Uri.parse('https://fakestoreapi.in/api/users'));
      print('API call completed.'); // Log after API call
      print('Response status: ${response.statusCode}'); // Log response status
      print('Response body: ${response.body}'); // Log response body
      print('Full JSON response: ${response.body}'); // Log full JSON response for debugging

      if (response.statusCode == 200) {
      var usersJson = json.decode(response.body);
      if (usersJson is Map<String, dynamic>) {
        // Assuming the users are under a key named 'users'
        usersJson = usersJson['users'] as List<dynamic>;
      }
        print('Response JSON: $usersJson'); // Log the entire JSON response
        final List<Users> users = []; // Corrected to Users
        for (var item in usersJson) {
          try {
            final user = Users.fromJson(item); // Corrected to Users
            users.add(user);
          } catch (e) {
            print('Error parsing user: $e');
          }
        }
        print('Fetched users: $users'); // Log fetched users
        return users; 
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching users: $e');
      throw Exception('Error: $e');
    }
  }
}

