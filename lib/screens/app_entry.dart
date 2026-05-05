import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';
import '../splash_screen.dart';
import '../login_screen.dart';
import '../home_screen.dart';

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ShopProvider>();
    if (provider.initializing) {
      return const SplashScreen(isNavigating: false);
    }

    if (provider.currentUser == null) {
      return const LoginScreen();
    }

    return const HomeScreen();
  }
}
