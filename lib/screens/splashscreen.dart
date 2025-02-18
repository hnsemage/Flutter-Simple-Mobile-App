import 'dart:async';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '/screens/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String appVersion = "Loading...";

  @override
  void initState() {
    super.initState();
    _getAppVersion(); // Fetch version info

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  // Fetch App Version
  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = "v${packageInfo.version}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        // Center everything vertically and horizontally
        child: Column(
          mainAxisSize: MainAxisSize.min, // Shrink to fit content
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "My Demo App",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 6, 5, 103),
              ),
            ),
            const SizedBox(height: 10),
            Image.asset('assets/logo.jpeg', width: 200),
            const SizedBox(height: 10),
            Text(
              appVersion,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 6, 5, 103),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
