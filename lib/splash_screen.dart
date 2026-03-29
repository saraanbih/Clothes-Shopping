import 'package:flutter/material.dart';
import 'login_screen.dart';

//  SplashScreen
//  open the app. After 3 seconds, it automatically

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// We use StatefulWidget because we need to run
// code when the screen first appears (the timer).
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // initState() runs once when the screen is created.
    // We use it to start a 3-second timer, then navigate.
    _goToLogin();
  }

  // This function waits 3 seconds then goes to Login.
  void _goToLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    // Make sure the screen is still open before navigating
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      // pushReplacement means the user can't press Back
      // to return to the splash screen.
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dark navy background color
      backgroundColor: const Color(0xFF1A1A2E),

      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // center everything vertically
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

            const SizedBox(height: 24), // spacing
            // App Name
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

            // Tagline
            const Text(
              'YOUR STYLE, YOUR WAY',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white38, // semi-transparent white
                letterSpacing: 2.5,
              ),
            ),

            const SizedBox(height: 60),

            // Loading Spinner
            // Shows the user something is happening
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
