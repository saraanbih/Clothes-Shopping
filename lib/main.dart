import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/shop_provider.dart';
import 'screens/app_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialization is handled in FirebaseService
  // to avoid double initialization and ensure proper error handling
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShopProvider(),
      child: MaterialApp(
        title: 'Drape',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC8553D)),
          useMaterial3: true,
        ),
        home: const AppEntry(),
      ),
    );
  }
}
