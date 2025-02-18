import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'loginscreen.dart'; // Import the LoginScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to Home Screen!",
              style: TextStyle(
                color: Color.fromARGB(255, 6, 5, 103),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/logo.jpeg', width: 200),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Login Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Close the app
                SystemNavigator.pop();
              },
              child: const Text("Exit"),
            ),
          ],
        ),
      ),
    );
  }
}
