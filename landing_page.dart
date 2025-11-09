import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  // 🔹 Fungsi helper untuk navigasi dengan animasi transisi halus
  void _navigateWithAnimation(BuildContext context, String routeName) {
    Navigator.of(context).push(_createRoute(routeName));
  }

  // 🔹 Buat animasi transisi fade + slide
  Route _createRoute(String routeName) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          _getPage(routeName),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.2);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var fadeTween =
            Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 600),
    );
  }

  // 🔹 Ambil halaman tujuan berdasarkan nama route
  Widget _getPage(String routeName) {
    switch (routeName) {
      case '/login':
        return const _LazyPage(routeName: '/login');
      case '/register':
        return const _LazyPage(routeName: '/register');
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🔹 Background image
          Image.asset(
            'assets/images/login_pages.png',
            fit: BoxFit.cover,
          ),

          // 🔹 Overlay gelap
          Container(color: Colors.black.withOpacity(0.4)),

          // 🔹 Konten utama
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Ketahuilah jumlah emisi karbon yang dikeluarkan dan temukan solusi untuk menguranginya",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // 🔹 Tombol Masuk (Hijau)
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _navigateWithAnimation(context, '/login');
                    },
                    child: const Text(
                      "Masuk",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // 🔹 Tombol Daftar (Transparan)
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _navigateWithAnimation(context, '/register');
                    },
                    child: const Text(
                      "Daftar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///
/// 🔸 Lazy loader untuk halaman berikutnya agar animasi tetap mulus
/// (biar Flutter tidak rebuild semua widget sebelum animasi selesai)
///
class _LazyPage extends StatelessWidget {
  final String routeName;
  const _LazyPage({required this.routeName});

  @override
  Widget build(BuildContext context) {
    // Gunakan Future.microtask supaya build tetap ringan
    Future.microtask(() => Navigator.pushReplacementNamed(context, routeName));
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: CircularProgressIndicator(color: Colors.green)),
    );
  }
}
