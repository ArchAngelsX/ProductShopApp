import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sushi_app/models/products/product_model.dart';
import 'package:sushi_app/models/products/user_model.dart'; // Import UserModel
import 'package:sushi_app/service_provider/modul_service/product_service.dart';
import 'package:sushi_app/service_provider/modul_service/user_service.dart'; // Import UserService

class ServiceProvider extends ChangeNotifier {
  ServiceProvider() {
    init(); // Call init method to fetch users
  }

  ProductService productService = ProductService();
  UserService userService = UserService(); // Add UserService instance
  UserModel userModel = UserModel(); // Add userModel property

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Products> _products = [];
  List<Products> get products => _products;

  Users? _currentUser; // Track the currently logged-in user
  Users? get currentUser => _currentUser;

  Future<void> init() async {
    print('Fetching users on initialization...'); // Log before fetching users
    try {
      await fetchUsers(); // Fetch users on initialization
      print('Users fetched successfully.'); // Log after fetching users
    } catch (e) {
      print('Error during fetching users: $e'); // Log any errors
    }
  }

  Future<void> fetchUsers() async {
    try {
      userModel.users = await userService.getUsers(); // Fetch and store users
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> getProductProvider() async {
    _isLoading = true;

    try {
      final result = await productService.getProduct();
      _products = result;
      _errorMessage = null;
    } on TimeoutException {
      _errorMessage = 'Connection timeout. Please check your internet connection.';
      _products = [];
    } on Exception catch (e) {
      _errorMessage = e.toString();
      _products = [];
    } catch (e) {
      _errorMessage = 'An unexpected error occurred.';
      _products = [];
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners after loading is complete
    }
  }

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  // Login method
  void login(String username, String password) {
    print('Attempting to login with username: $username and password: $password');
    print('Fetched users: ${userModel.users}'); // Log fetched users

    final user = userModel.users?.firstWhere(
      (user) => user.username == username && user.password == password,
      orElse: () => throw Exception('User not found'), // Throw an exception if not found
    );

    if (user != null) {
      _currentUser = user;
      notifyListeners(); // Notify listeners about the login state change
    }
  }

  // Logout method
  void logout() {
    _currentUser = null;
    notifyListeners(); // Notify listeners about the logout state change
  }
}
