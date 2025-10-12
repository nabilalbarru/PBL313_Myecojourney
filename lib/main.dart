import 'package:flutter/material.dart';
import 'pages/login_pages.dart';
import 'pages/register_page.dart';
import 'pages/dashboard_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/dashboard',
      routes: {
        '/login': (context) => const LoginPages(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const DashboardPages(),
      },
    );
  }
}
