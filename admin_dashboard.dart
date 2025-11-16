import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ==========================
      // 🔹 APPBAR (WARNA HIJAU)
      // ==========================
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5134),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/home_page.jpeg',
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              'MYECO JOURNEY',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      // ==========================
      // 🔹 BODY
      // ==========================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              const Text(
                'Hallo Admin',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              _buildInfoCard(
                icon: Icons.person,
                title: 'Total pengguna',
                value: '254',
                subtitle: 'Menggunakan aplikasi untuk memantau jejak karbon',
              ),

              const SizedBox(height: 20),

              _buildInfoCard(
                icon: Icons.directions_car,
                title: 'Total Kendaraan',
                value: '1',
                subtitle: 'Total kendaraan yang di input oleh admin',
              ),

              const SizedBox(height: 20),

              _buildInfoCard(
                icon: Icons.handshake,
                title: 'Total Mitra',
                value: '254',
                subtitle: 'Total mitra yang bekerja sama dengan aplikasi',
              ),
            ],
          ),
        ),
      ),

      // ==========================
      // 🔹 BOTTOM NAVIGATION (WARNA HIJAU)
      // ==========================
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1F5134),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home,
              label: 'Home',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            ),
            _NavItem(
              icon: Icons.history,
              label: 'Riwayat',
              onTap: () {
                Navigator.pushNamed(context, '/riwayat');
              },
            ),
            _NavItem(
              icon: Icons.directions_car,
              label: 'Kendaraan',
              onTap: () {
                Navigator.pushNamed(context, '/kategori-kendaraan');
              },
            ),
            _NavItem(
              icon: Icons.handshake,
              label: 'Mitra',
              onTap: () {
                Navigator.pushNamed(context, '/mitra');
              },
            ),
            _NavItem(
              icon: Icons.person,
              label: 'Profil',
              onTap: () {
                Navigator.pushNamed(context, '/admin-profile');
              },
            ),
          ],
        ),
      ),
    );
  }

  // ==========================
  // 🔹 CARD INFO
  // ==========================
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: const Color(0xFF1F5134)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF1F5134),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================
// 🔹 NAV ITEM (IKON WARNA HIJAU)
// ==========================
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: const Color(0xFF1F5134),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
