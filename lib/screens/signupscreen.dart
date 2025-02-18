import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'loginscreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String gender = 'Male';
  String mobileNo = '';
  String email = '';
  String country = '';
  String password = '';
  String confirmPassword = '';
  bool agreeTerms = false;

  List<String> countries = []; //Country list

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      final response = await http.get(
        Uri.parse('https://restcountries.com/v3.1/all?fields=name'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          countries = data.map((e) => e['name']['common'].toString()).toList();
          countries.sort(); // Sort country names
        });
      }
    } catch (e) {
      debugPrint("Error fetching countries: $e");
    }
  }

  bool isVaildPassword(String password) {
    final regex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*+]).{8,30}$',
    );
    return regex.hasMatch(password);
  }

  void signUp() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!agreeTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You must agree to the Terms & Condtions"),
          ),
        );
        return;
      }

      _formKey.currentState?.save();

      //Navigate to the login screen after successful sign up
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                //First name
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "First Name",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => firstName = value ?? '',
                  validator:
                      (value) => value!.isEmpty ? 'Enter First Name' : null,
                ),
                const SizedBox(height: 20),

                //Last name
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Last Name",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => lastName = value ?? '',
                  validator:
                      (value) => value!.isEmpty ? 'Enter Last Name' : null,
                ),
                const SizedBox(height: 20),

                //Gender Selection
                const Text("Gender"),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text("Male"),
                        value: "Male",
                        groupValue: gender,
                        onChanged: (value) => setState(() => gender = value!),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text("Female"),
                        value: "Female",
                        groupValue: gender,
                        onChanged: (value) => setState(() => gender = value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Mobile No
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Mobile No",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => mobileNo = value ?? '',
                  validator:
                      (value) => value!.isEmpty ? 'Enter Mobile Number' : null,
                ),
                const SizedBox(height: 20),

                // Email
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => email = value ?? '',
                  validator: (value) => value!.isEmpty ? 'Enter Email' : null,
                ),
                const SizedBox(height: 20),

                /// Country Dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Select Country",
                    border: OutlineInputBorder(),
                  ),
                  value: country.isNotEmpty ? country : null,
                  onChanged: (value) => setState(() => country = value!),
                  items:
                      countries.map((country) {
                        return DropdownMenuItem(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                  validator:
                      (value) => value == null ? 'Select a Country' : null,
                  icon: const Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                ),
                const SizedBox(height: 20),

                // Password
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onSaved: (value) => password = value ?? '',
                  validator: (value) {
                    if (value == null || !isVaildPassword(value)) {
                      return 'Password must be 8-30 characters, include uppercase, lowercase, number, and special character';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Confirm Password
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onSaved: (value) => confirmPassword = value ?? '',
                  validator: (value) {
                    if (value == null || value != password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Terms & Conditions Checkbox
                CheckboxListTile(
                  title: const Text("Agree with Terms & Conditions"),
                  value: agreeTerms,
                  onChanged: (value) => setState(() => agreeTerms = value!),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: signUp,
                        child: const Text("Sign Up"),
                      ),
                    ),
                    const SizedBox(width: 20), // Space between buttons

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text("Back"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
