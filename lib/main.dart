import 'package:flutter/material.dart';
import 'package:owlpress/views/dashboard_screen.dart';
import 'package:owlpress/views/login_screen.dart';
import 'package:owlpress/views/register_screen.dart';
import 'package:owlpress/views/splash_screen.dart';

void main() {
  runApp(const OwlPressApp());
}

class OwlPressApp extends StatelessWidget {
  const OwlPressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OwlPress',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sans',
        scaffoldBackgroundColor: const Color(0xFF1E2D23),
        primaryColor: const Color(0xFFD1B97F),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Color(0xFFD1B97F)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD1B97F)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD1B97F), width: 2),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(), // Tambahan route
      },
    );
  }
}
