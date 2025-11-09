import 'package:flutter/material.dart';

// 🔹 Import semua halaman
import 'pages/landing_page.dart'; // ✅ Tambahkan ini
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/offset_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/change_password_page.dart';
import 'pages/transport_mode_page.dart';
import 'pages/monitor_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyEcoJourney',
      // ✅ Ubah jadi halaman pertama: Landing Page
      initialRoute: '/landing',

      routes: {
        '/landing': (context) => const LandingPage(), // ✅ Halaman pertama
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/offset': (context) => const OffsetPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/change-password': (context) => const ChangePasswordPage(),
        '/tracking': (context) => const TransportModePage(),
        '/monitor': (context) => const MonitorPage(),
      },
    );
  }
}

//
// ===============================================
// 🔹 Helper Navigasi (optional)
// ===============================================
void goToOffset(BuildContext context) => Navigator.pushNamed(context, '/offset');
void goToHome(BuildContext context) => Navigator.pushNamed(context, '/home');
void goToProfile(BuildContext context) => Navigator.pushNamed(context, '/profile');
void goToChangePassword(BuildContext context) =>
    Navigator.pushNamed(context, '/change-password');
void goToTracking(BuildContext context) => Navigator.pushNamed(context, '/tracking');
void goToMonitor(BuildContext context) => Navigator.pushNamed(context, '/monitor');
void goBack(BuildContext context) => Navigator.pop(context);

//
// ===============================================
// 🔹 Bottom Navigation Bar (Global)
// ===============================================
Widget buildBottomNavbar(BuildContext context, int currentIndex) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: currentIndex,
    selectedItemColor: const Color(0xFF1F5134),
    unselectedItemColor: Colors.grey,
    backgroundColor: const Color(0xFFE5F3EB),
    onTap: (index) {
      if (index == 0) {
        goToHome(context);
      } else if (index == 1) {
        goToTracking(context);
      } else if (index == 2) {
        goToMonitor(context);
      } else if (index == 3) {
        goToOffset(context);
      }
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Tracking"),
      BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Monitor"),
      BottomNavigationBarItem(icon: Icon(Icons.eco), label: "Offset"),
    ],
  );
}
