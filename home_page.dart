import 'package:flutter/material.dart';
import '../main.dart'; // 🔹 untuk akses helper navigasi seperti goToOffset(), goToProfile(), dll

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      goToHome(context);
    } else if (index == 1) {
      goToTracking(context);
    } else if (index == 2) {
      goToMonitor(context);
    } else if (index == 3) {
      goToOffset(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 Ambil ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F3),

      // ================= APPBAR RESPONSIF =================
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.20), // ✅ proporsional
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1F5134),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.015,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Bar atas: logo + profil
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/home_page.jpeg',
                              width: screenWidth * 0.12,
                              height: screenWidth * 0.12,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "MYECO JOURNEY",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Carbon Calculator",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Color(0xFF1F5134)),
                        ),
                        onPressed: () => goToProfile(context),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  // 🔹 Kartu sambutan responsif
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2DBE60),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Selamat datang, User MYECO JOURNEY!\nMari kelola jejak karbon transportasi Anda untuk lingkungan yang lebih bersih.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ================= ISI HALAMAN =================
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          child: Column(
            children: [
              _buildInfoCard(
                icon: Icons.directions_car_rounded,
                backgroundColor: Colors.red,
                iconColor: Colors.white,
                title: "Total Emisi",
                value: "0.00 kg",
                subtitle: "CO₂ yang dihasilkan",
                screenWidth: screenWidth,
              ),
              _buildInfoCard(
                icon: Icons.park_rounded,
                backgroundColor: Colors.green,
                iconColor: Colors.white,
                title: "Total Offset",
                value: "0.00 kg",
                subtitle: "CO₂ yang dioffset",
                screenWidth: screenWidth,
              ),
              _buildInfoCard(
                icon: Icons.bar_chart_rounded,
                backgroundColor: Colors.blue,
                iconColor: Colors.white,
                title: "Total Laporan",
                value: "1",
                subtitle: "Total Laporan Track",
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),

      // ================= NAVBAR BAWAH =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1F5134),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFE5F3EB),
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Tracking"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Monitor"),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: "Offset"),
        ],
      ),
    );
  }

  // ================= CARD INFO (Responsif) =================
  Widget _buildInfoCard({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required String title,
    required String value,
    required String subtitle,
    required double screenWidth,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.06,
        vertical: screenWidth * 0.025,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(screenWidth * 0.045),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Icon(icon, color: iconColor, size: screenWidth * 0.07),
            ),
            SizedBox(width: screenWidth * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
