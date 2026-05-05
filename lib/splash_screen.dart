import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final bool isNavigating;

  const SplashScreen({super.key, this.isNavigating = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
