import 'package:flutter/material.dart';

class KategoriKendaraanPage extends StatefulWidget {
  const KategoriKendaraanPage({super.key});

  @override
  State<KategoriKendaraanPage> createState() => _KategoriKendaraanPageState();
}

class _KategoriKendaraanPageState extends State<KategoriKendaraanPage> {
  final TextEditingController namaCtrl = TextEditingController();
  final TextEditingController ccCtrl = TextEditingController();
  final TextEditingController emisiCtrl = TextEditingController();

  // ==============================
  // 🔥 DAFTAR ICON LENGKAP
  // ==============================
  final List<IconData> semuaIcon = [
    Icons.motorcycle,
    Icons.directions_car,
    Icons.electric_bike,
    Icons.pedal_bike,
    Icons.electric_scooter,
    Icons.directions_bus,
    Icons.local_shipping,
    Icons.agriculture_outlined,
    Icons.directions_bike,
    Icons.electric_scooter,
    Icons.local_taxi,
    Icons.train,
    Icons.tram,
    Icons.subway,
    Icons.sailing,
    Icons.directions_boat,
    Icons.airplanemode_active,
    Icons.airplanemode_on,
  ];

  IconData? selectedIcon;

  // ====================================
  // 🔥 POPUP PILIH ICON (GRID + SEARCH)
  // ====================================
  Future<void> pilihIconDialog() async {
    List<IconData> filteredIcons = List.from(semuaIcon);
    TextEditingController searchCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Pilih Icon"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: searchCtrl,
                    decoration: const InputDecoration(
                      labelText: "Cari icon...",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setStateDialog(() {
                        filteredIcons = semuaIcon.where((icon) {
                          return icon
                              .toString()
                              .toLowerCase()
                              .contains(value.toLowerCase());
                        }).toList();
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 250,
                    width: 300,
                    child: GridView.builder(
                      itemCount: filteredIcons.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIcon = filteredIcons[index];
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedIcon == filteredIcons[index]
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(filteredIcons[index], size: 28),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ===========================
  // DATA KENDARAAN
  // ===========================
  List<Map<String, dynamic>> kendaraanList = [
    {
      "icon": Icons.motorcycle,
      "title": "Motor Besar",
      "cc": ">250 cc",
      "emisi": "0.10 g CO₂/km"
    },
    {
      "icon": Icons.electric_bike,
      "title": "Motor Listrik",
      "cc": "Ramah Lingkungan",
      "emisi": "0.00 g CO₂/km"
    },
    {
      "icon": Icons.motorcycle,
      "title": "Motor Kecil",
      "cc": "<250 cc",
      "emisi": "0.05 g CO₂/km"
    },
  ];

  // ===========================
  // TAMBAH KENDARAAN
  // ===========================
  void tambahKendaraan() {
    if (namaCtrl.text.isEmpty ||
        ccCtrl.text.isEmpty ||
        emisiCtrl.text.isEmpty ||
        selectedIcon == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field & icon harus diisi")),
      );
      return;
    }

    setState(() {
      kendaraanList.add({
        "icon": selectedIcon,
        "title": namaCtrl.text,
        "cc": ccCtrl.text,
        "emisi": emisiCtrl.text,
      });
    });

    namaCtrl.clear();
    ccCtrl.clear();
    emisiCtrl.clear();
    selectedIcon = null;
  }

  // ===========================
  // EDIT KENDARAAN
  // ===========================
  void editKendaraan(int index) {
    namaCtrl.text = kendaraanList[index]["title"];
    ccCtrl.text = kendaraanList[index]["cc"];
    emisiCtrl.text = kendaraanList[index]["emisi"];
    selectedIcon = kendaraanList[index]["icon"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Kendaraan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaCtrl,
                decoration: const InputDecoration(labelText: "Nama kendaraan"),
              ),
              TextField(
                controller: ccCtrl,
                decoration: const InputDecoration(labelText: "Deskripsi CC"),
              ),
              TextField(
                controller: emisiCtrl,
                decoration: const InputDecoration(labelText: "Emisi CO₂"),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: pilihIconDialog,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(selectedIcon ?? Icons.image_search,
                          color: Colors.green),
                      const SizedBox(width: 10),
                      const Text("Ganti Icon Kendaraan"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  kendaraanList[index]["title"] = namaCtrl.text;
                  kendaraanList[index]["cc"] = ccCtrl.text;
                  kendaraanList[index]["emisi"] = emisiCtrl.text;
                  kendaraanList[index]["icon"] = selectedIcon;
                });
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  // ===========================
  // HAPUS
  // ===========================
  void hapusKendaraan(int index) {
    setState(() {
      kendaraanList.removeAt(index);
    });
  }

  // ===========================
  // UI UTAMA
  // ===========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F3),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5134),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text("Kategori kendaraan",
            style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Kategori Kendaraan",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F5134),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Kelola daftar kendaraan yang bisa dipilih pengguna, termasuk data besar CC dan faktor emisi per kilometer.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),

            const SizedBox(height: 20),

            // ==============================
            // FORM TAMBAH KENDARAAN
            // ==============================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: namaCtrl,
                    decoration: const InputDecoration(
                      labelText: "Nama kategori",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  TextField(
                    controller: ccCtrl,
                    decoration: const InputDecoration(
                      labelText: "Deskripsi CC Motor",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  TextField(
                    controller: emisiCtrl,
                    decoration: const InputDecoration(
                      labelText: "Faktor Emisi",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: pilihIconDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(selectedIcon ?? Icons.image_search,
                              color: Colors.green),
                          const SizedBox(width: 10),
                          Text(selectedIcon == null
                              ? "Pilih Icon Kendaraan"
                              : "Icon dipilih"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F5134),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: tambahKendaraan,
                      child: const Text("Tambah kategori",
                          style:
                              TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =================================
            // GRID LIST KATEGORI KENDARAAN
            // =================================
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: kendaraanList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final item = kendaraanList[index];

                return GestureDetector(
                  onTap: () => editKendaraan(index),
                  child: Stack(
                    children: [
                      KendaraanCard(
                        icon: item["icon"],
                        title: item["title"],
                        cc: item["cc"],
                        emisi: item["emisi"],
                      ),

                      Positioned(
                        right: 6,
                        top: 6,
                        child: GestureDetector(
                          onTap: () => hapusKendaraan(index),
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // ====================
      // 🔹 BOTTOM NAV (WARNA + IKON BARU)
      // ====================
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
            _AdminNavItem(
              icon: Icons.home,
              label: "Home",
              onTap: () =>
                  Navigator.pushReplacementNamed(context, '/admin'),
            ),
            _AdminNavItem(
              icon: Icons.history,
              label: "Riwayat",
              onTap: () => Navigator.pushNamed(context, '/riwayat'),
            ),
            _AdminNavItem(
              icon: Icons.directions_car,
              label: "Kendaraan",
              onTap: () {},
            ),
            _AdminNavItem(
              icon: Icons.handshake,
              label: "Mitra",
              onTap: () => Navigator.pushNamed(context, '/mitra'),
            ),
            _AdminNavItem(
              icon: Icons.person,
              label: "Profil",
              onTap: () => Navigator.pushNamed(context, '/admin-profile'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================
// KARTU KENDARAAN
// ==============================
class KendaraanCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String cc;
  final String emisi;

  const KendaraanCard({
    super.key,
    required this.icon,
    required this.title,
    required this.cc,
    required this.emisi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: const Color(0xFF1F5134)),
          const SizedBox(height: 5),
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          Text(cc,
              style:
                  const TextStyle(fontSize: 12, color: Colors.black54)),
          Text(emisi,
              style:
                  const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}

// ==============================
// NAV ITEM ADMIN (IKON WARNA BARU)
// ==============================
class _AdminNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AdminNavItem({
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
              color: Color(0xFF1F5134), // 🔥 WARNA IKON BARU
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
