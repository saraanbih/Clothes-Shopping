import 'package:flutter/material.dart';
import 'login_screen.dart';

//  SplashScreen
//  open the app. After 3 seconds, it automatically

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _goToLogin();
  }

  void _goToLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,

      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFC8553D),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(Icons.checkroom, color: Colors.white, size: 52),
            ),

            const SizedBox(height: 24),

            const Text(
              'DRAPE',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 6,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'YOUR STYLE, YOUR WAY',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white38,
                letterSpacing: 2.5,
              ),
            ),

            const SizedBox(height: 60),

            const CircularProgressIndicator(
              color: Color(0xFFC8553D),
              strokeWidth: 2.5,
            ),
          ],
        ),
      ),
    );
  }
}
