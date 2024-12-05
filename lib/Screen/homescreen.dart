// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sushi_app/Screen/Sushi_app/welcome_screen.dart';
import 'package:sushi_app/Screen/aboutscreen.dart';
import 'package:sushi_app/Screen/product/product_screen.dart';
import 'loading_screen.dart'; // Import the loading screen

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Course 1'),
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        children: [
          _buildListTile(
            title: 'Anonymous Route',
            onTap: () {
              _navigateTo(context, AboutScreen(title: 'About Screen'));
            },
          ),
          SizedBox(height: 10,),
          _buildListTile(
            title: 'Named Routes',
            onTap: () {
              _navigateToNamed(context, '/about');
            },
          ),SizedBox(height: 10,),
          _buildListTile(
            title: 'Emoji Generator',
            onTap: () {
              _navigateToNamed(context, '/EmojiGenerator');
            },
          ),SizedBox(height: 10,),
          _buildListTile(
            title: 'Counter App with Provider',
            onTap: () {
              _navigateToNamed(context, '/CounterApp');
            },
          ),SizedBox(height: 10,),
          _buildListTile(
            title: 'Counter App with No Provider',
            onTap: () {
              _navigateToNamed(context, '/CounterAppWithoutProv');
            },
          ),SizedBox(height: 10,),
          _buildListTile(
            title: 'Sushi App',
            onTap: () {
              _navigateTo(context, WelcomeScreen());
            },
          ),SizedBox(height: 10,),
          _buildListTile(
            title: 'Fetch API',
            onTap: () {
              _pushTo(context, ProductScreen());
            },
          ),

        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Wrap(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Created with Flutter',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  const FlutterLogo(size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
  // Push the LoadingScreen
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoadingScreen()),
  );

  // Simulate a delay for loading
  Future.delayed(const Duration(seconds: 1), () {
    // After the delay, pop the loading screen
    Navigator.pop(context);
    // Then navigate to the actual page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  });

  
}


  void _pushTo(BuildContext context, Widget page) {
  // Push the LoadingScreen
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoadingScreen()),
  );

  // Simulate a delay for loading
  Future.delayed(const Duration(seconds: 1), () {
    // After the delay, pop the loading screen
    Navigator.pop(context);
    // Then navigate to the actual page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  });

  
}

void _navigateToNamed(BuildContext context, String routeName) {
  // Push the LoadingScreen
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoadingScreen()),
  );

  // Simulate a delay for loading
  Future.delayed(const Duration(seconds: 1), () {
    // After the delay, pop the loading screen
    Navigator.pop(context);
    // Then navigate to the actual page
    Navigator.pushReplacementNamed(context, routeName);
  });
}

  ListTile _buildListTile({required String title, required VoidCallback onTap}) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: const BorderSide(color: Colors.blueAccent),
      ),
      title: Text(title),
      trailing: const Icon(CupertinoIcons.arrow_right),
      onTap: onTap,
    );
  }
}
