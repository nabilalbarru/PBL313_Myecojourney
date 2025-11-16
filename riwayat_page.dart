import 'package:flutter/material.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  final List<Map<String, String>> allUsers = [
    {"name": "Muhammad Ridho Syahputra", "email": "iidooo@gmail.com"},
    {"name": "Nazwa Salsabila", "email": "cacacantik0111@gmail.com"},
    {"name": "Bayu Cety", "email": "bayucetyo@gmail.com"},
    {"name": "Nova Eko Prastyo", "email": "ekoprastyo@gmail.com"},
    {"name": "Bayu Cety", "email": "bayucetyo@gmail.com"},
    {"name": "Nova Eko Prastyo", "email": "ekoprastyo@gmail.com"},
    {"name": "Bayu Cety", "email": "bayucetyo@gmail.com"},
    {"name": "Nova Eko Prastyo", "email": "ekoprastyo@gmail.com"},
  ];

  List<Map<String, String>> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = List.from(allUsers);
  }

  void searchUser(String query) {
    final results = allUsers.where((user) {
      final name = user["name"]!.toLowerCase();
      final email = user["email"]!.toLowerCase();
      final q = query.toLowerCase();
      return name.contains(q) || email.contains(q);
    }).toList();

    setState(() {
      filteredUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ==========================
      // 🔹 APPBAR (warna sama seperti kategori kendaraan)
      // ==========================
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5134), // ← WARNA DIUBAH
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Riwayat",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),

      // ==========================
      // 🔹 BODY
      // ==========================
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // JUDUL BESAR
            const Text(
              "Riwayat",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F5134),
              ),
            ),
            const SizedBox(height: 4),

            const Text(
              "Daftar riwayat perjalanan pengguna.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 20),

            // SEARCH BAR
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: searchUser,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: "Cari pengguna...",
                ),
              ),
            ),

            const SizedBox(height: 20),

            // LIST USER
            Expanded(
              child: ListView.separated(
                itemCount: filteredUsers.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail_pengguna',
                        arguments: user,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person,
                                color: Colors.white, size: 28),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user["name"]!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                user["email"]!,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ==========================
      // 🔹 BOTTOM NAV ADMIN
      // ==========================
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1F5134), // ← WARNA SAMA JUGA
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(context,
                icon: Icons.home, label: "Home", route: '/admin'),
            navItem(context,
                icon: Icons.history, label: "Riwayat", route: '/riwayat'),
            navItem(context,
                icon: Icons.directions_car, label: "Kendaraan", route: '/kendaraan'),
            navItem(context,
                icon: Icons.handshake, label: "Mitra", route: '/mitra'),
            navItem(context,
                icon: Icons.person, label: "Profil", route: '/admin-profile'),
          ],
        ),
      ),
    );
  }

  // NAV ITEM
  Widget navItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
  }) {
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
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
