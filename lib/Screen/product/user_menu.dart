import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/products/user_model.dart';
import '../../service_provider/service_provider.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({super.key});

  @override
  _UserMenuState createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('User  Menu'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[200], // Background color
        child: serviceProvider.currentUser  != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, ${serviceProvider.currentUser ?.username}!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      serviceProvider.logout();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text('Logout'),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _login(serviceProvider);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              textStyle: TextStyle(fontSize: 18),
                            ),
                            child: Text('Login'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _login(ServiceProvider serviceProvider) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    print('Attempting to login with username: $username and password: $password');
    print('Connecting to API...'); // Log before API call
    await serviceProvider.fetchUsers(); // Ensure users are fetched before login
    print('API call completed.'); // Log after API call
    print('Fetched users: ${serviceProvider.userModel.users}'); // Log fetched users

    try {
      serviceProvider.login(username, password); // Call login method
    } catch (e) {
      print('Error during login: $e'); // Log any errors during login
    }

    if (serviceProvider.currentUser  == null) {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    } else {
      setState(() {
        _errorMessage = '';
      });
    }
  }
}