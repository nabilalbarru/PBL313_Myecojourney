import 'package:flutter/material.dart';

// 🔹 Import semua halaman
import 'profile_user/landing_page.dart';
import 'profile_user/login_page.dart';
import 'profile_user/register_page.dart';
import 'profile_user/offset_page.dart';
import 'profile_user/home_page.dart';
import 'profile_user/profile_page.dart';
import 'profile_user/change_password_page.dart';
import 'profile_user/transport_mode_page.dart';
import 'profile_user/monitor_page.dart';
import 'profile_admin/admin_dashboard.dart';
import 'profile_admin/riwayat_page.dart';
import 'profile_admin/kategori_kendaraan_page.dart';
import 'profile_admin/detail_pengguna_page.dart';
import 'profile_admin/organisasi_mitra_page.dart';
import 'profile_admin/admin_profile_page.dart';
import 'profile_admin/antrian_verifikasi_page.dart';

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
      initialRoute: '/landing',

      routes: {
        '/landing': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/offset': (context) => const OffsetPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/change-password': (context) => const ChangePasswordPage(),
        '/tracking': (context) => const TransportModePage(),
        '/monitor': (context) => const MonitorPage(),

        // 🔹 Admin Dashboard
        '/admin': (context) => const AdminDashboardPage(),

        // 🔹 Admin Profile (khusus admin)
        '/admin-profile': (context) => const AdminProfilePage(),

        // 🔹 Riwayat
        '/riwayat': (context) => const RiwayatPage(),

        // 🔹 Kendaraan
        '/kendaraan': (context) => const KategoriKendaraanPage(),
        '/kategori-kendaraan': (context) => const KategoriKendaraanPage(),

        // 🔹 Detail Pengguna
        '/detail_pengguna': (context) => const DetailPenggunaPage(),

        // 🔥 MITRA
        '/mitra': (context) => const OrganisasiMitraPage(),

        // ⭐ BARU → ROUTE ANTRIAN VERIFIKASI
        '/antrian-verifikasi': (context) => const AntrianVerifikasiPage(),
      },
    );
  }
}

// ===========================================================
// 🔹 Helper Navigasi
// ===========================================================
void goToOffset(BuildContext context) => Navigator.pushNamed(context, '/offset');
void goToHome(BuildContext context) => Navigator.pushNamed(context, '/home');
void goToProfile(BuildContext context) =>
    Navigator.pushNamed(context, '/profile');
void goToChangePassword(BuildContext context) =>
    Navigator.pushNamed(context, '/change-password');
void goToTracking(BuildContext context) =>
    Navigator.pushNamed(context, '/tracking');
void goToMonitor(BuildContext context) =>
    Navigator.pushNamed(context, '/monitor');

// 🔥 Navigasi ke Profile Admin
void goToAdminProfile(BuildContext context) =>
    Navigator.pushNamed(context, '/admin-profile');

// ⭐ BARU → Navigasi cepat ke halaman antrian verifikasi
void goToAntrianVerifikasi(BuildContext context) =>
    Navigator.pushNamed(context, '/antrian-verifikasi');

void goBack(BuildContext context) => Navigator.pop(context);

// ===========================================================
// 🔹 Bottom Navigation Bar (Global)
// ===========================================================
Widget buildBottomNavbar(BuildContext context, int currentIndex) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: currentIndex,
    selectedItemColor: const Color(0xFF1F5134),
    unselectedItemColor: Colors.grey,
    backgroundColor: const Color(0xFFE5F3EB),
    onTap: (index) {
      if (index == 0) goToHome(context);
      if (index == 1) goToTracking(context);
      if (index == 2) goToMonitor(context);
      if (index == 3) goToOffset(context);
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Tracking"),
      BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Monitor"),
      BottomNavigationBarItem(icon: Icon(Icons.eco), label: "Offset"),
    ],
  );
}
