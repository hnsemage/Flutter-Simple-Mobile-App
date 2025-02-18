import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermobileapp/screens/homescreen.dart';
import 'signupscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  //Company Logo
  Widget companyLogo() {
    return Image.asset('assets/logo.jpeg', width: 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Company Logo
              companyLogo(),

              const SizedBox(height: 20),
              Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              //Username Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "User Name",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  username = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a user name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              //Password Field
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  password = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              //Sign Up Hyperlink
              GestureDetector(
                onTap: () {
                  //Navgate to the Sign Up Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              //Login Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();

                    //Proceed to the Home screen if vaild
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 20),

              //Back Button to exist app
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
