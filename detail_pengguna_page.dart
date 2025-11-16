import 'package:flutter/material.dart';

class DetailPenggunaPage extends StatelessWidget {
  const DetailPenggunaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data user dari arguments
    final Map<String, String> user =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F3),

      // ==========================
      // 🔹 APPBAR HIJAU
      // ==========================
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5134),
        elevation: 0,
        title: const Text(
          "Detail Pengguna",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // ==========================
      // 🔹 BODY
      // ==========================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================
            // USER DETAIL BOX
            // ==========================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person,
                            size: 35, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user["name"]!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user["email"]!,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Divider(color: Colors.grey[400]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _totalBox("Total Trip", "45"),
                      _totalBox("Total Emisi", "1.2 Tons\n0.8 Tons"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==========================
            // JUDUL RIWAYAT PERJALANAN
            // ==========================
            const Text(
              "Riwayat Perjalanan",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F5134),
              ),
            ),
            const SizedBox(height: 12),

            // ==========================
            // LIST PERJALANAN
            // ==========================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  _tripItem("Sekupang - Batam Center", "2.5 kilogram"),
                  const SizedBox(height: 10),
                  _tripItem("Tiban - Bengkong", "2.5 kilogram"),
                  const SizedBox(height: 10),
                  _tripItem("Botania - Batu Aji", "2.5 kilogram"),
                ],
              ),
            ),
          ],
        ),
      ),

      // ==========================
      // 🔹 BOTTOM NAVIGASI
      // ==========================
      bottomNavigationBar: _bottomNav(context),
    );
  }

  // ==========================
  // LIST ITEM PERJALANAN
  // ==========================
  static Widget _tripItem(String title, String weight) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              weight,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================
  // TOTAL BOX
  // ==========================
  static Widget _totalBox(String title, String value) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // ==========================
  // BOTTOM NAV
  // ==========================
  Widget _bottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1F5134),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(context, Icons.home, "Home", "/admin"),
          _navItem(context, Icons.history, "Riwayat", "/riwayat"),
          _navItem(context, Icons.directions_car, "Kendaraan", "/kategori-kendaraan"),
          _navItem(context, Icons.handshake, "Mitra", "/mitra"),
          _navItem(context, Icons.person, "Profil", "/admin-profile"),
        ],
      ),
    );
  }

  // ==========================
  // NAV ITEM
  // ==========================
  Widget _navItem(
      BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, route),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: Icon(icon, color: const Color(0xFF1F5134)),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
