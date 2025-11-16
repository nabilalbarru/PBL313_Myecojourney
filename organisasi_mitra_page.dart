import 'package:flutter/material.dart';

class OrganisasiMitraPage extends StatefulWidget {
  const OrganisasiMitraPage({super.key});

  @override
  State<OrganisasiMitraPage> createState() => _OrganisasiMitraPageState();
}

class _OrganisasiMitraPageState extends State<OrganisasiMitraPage> {
  final TextEditingController namaCtrl = TextEditingController();
  final TextEditingController desCtrl = TextEditingController();
  final TextEditingController fokusCtrl = TextEditingController();
  final TextEditingController urlCtrl = TextEditingController();

  final List<Map<String, String>> organisasiList = [
    {
      'title': 'Bangun Karbon',
      'desc': 'Melalui penanaman pohon untuk offset karbon di Indonesia.',
      'focus': 'Penanaman Pohon',
      'image':
          'https://images.pexels.com/photos/1671325/pexels-photo-1671325.jpeg',
    },
    {
      'title': 'Lingkungan Hijau',
      'desc': 'Fokus penghijauan dan daur ulang.',
      'focus': 'Reboisasi',
      'image':
          'https://images.pexels.com/photos/1671325/pexels-photo-1671325.jpeg',
    },
  ];

  bool _showSuccessOverlay = false;

  void _tambahOrganisasi() {
    if (namaCtrl.text.trim().isEmpty ||
        desCtrl.text.trim().isEmpty ||
        fokusCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama, deskripsi, dan fokus wajib diisi')),
      );
      return;
    }

    setState(() {
      organisasiList.insert(0, {
        'title': namaCtrl.text.trim(),
        'desc': desCtrl.text.trim(),
        'focus': fokusCtrl.text.trim(),
        'image': urlCtrl.text.trim().isNotEmpty
            ? urlCtrl.text.trim()
            : 'https://images.pexels.com/photos/1671325/pexels-photo-1671325.jpeg',
      });

      namaCtrl.clear();
      desCtrl.clear();
      fokusCtrl.clear();
      urlCtrl.clear();
      _showSuccessOverlay = true;
    });

    Future.delayed(const Duration(milliseconds: 1100), () {
      setState(() => _showSuccessOverlay = false);
    });
  }

  void _bukaVerifikasiPembayaran() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Verifikasi Pembayaran',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Text("Transfer Berhasil",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text("Rp150.000",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text("Nomor Referensi: 1750321"),
                    const SizedBox(height: 8),
                    Container(
                      height: 160,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.receipt_long,
                            size: 48, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pembayaran diterima')));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Terima pembayaran'),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pembayaran ditolak')));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Tolak pembayaran'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOrgCard(Map<String, String> item) {
    return GestureDetector(
      onTap: _bukaVerifikasiPembayaran,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              child: Image.network(
                item['image'] ?? '',
                height: 90,
                width: 110,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['title'] ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 6),
                    Text(item['desc'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.black54, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(6)),
                      child: Text("Fokus: ${item['focus']}",
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController ctrl,
      {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ============================
  // 🔥 NAVBAR BARU (WARNA + IKON)
  // ============================
  Widget _bottomNav() {
    return Container(
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
          _navButton(Icons.home, "Home",
              () => Navigator.pushReplacementNamed(context, '/admin')),
          _navButton(Icons.history, "Riwayat",
              () => Navigator.pushNamed(context, '/riwayat')),
          _navButton(Icons.directions_car, "Kendaraan",
              () => Navigator.pushNamed(context, '/kategori-kendaraan')),
          _navButton(Icons.handshake, "Mitra", () {}), // halaman aktif
          _navButton(Icons.person, "Profil",
              () => Navigator.pushNamed(context, '/admin-profile')),
        ],
      ),
    );
  }

  Widget _navButton(IconData icon, String label, VoidCallback onTap) {
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
              color: Color(0xFF1F5134), // 🔥 warna ikon baru
            ),
          ),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F3),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5134),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text("Organisasi Mitra",
            style: TextStyle(color: Colors.white)),
      ),

      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  ...organisasiList.map((e) => _buildOrgCard(e)),
                  const SizedBox(height: 20),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Tambah organisasi baru",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        _buildInputField("Nama organisasi", namaCtrl),
                        const SizedBox(height: 12),
                        _buildInputField("Deskripsi singkat", desCtrl,
                            maxLines: 3),
                        const SizedBox(height: 12),
                        _buildInputField("Fokus area", fokusCtrl),
                        const SizedBox(height: 12),
                        _buildInputField("URL gambar (opsional)", urlCtrl),
                        const SizedBox(height: 20),
                        ElevatedButton(
                        onPressed: _tambahOrganisasi,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1F5134),
                          foregroundColor: Colors.white, // 🔥 ini membuat teks putih
                        ),
                        child: const Text("Simpan organisasi"),
                      )

                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          Positioned(bottom: 0, left: 0, right: 0, child: _bottomNav()),

          if (_showSuccessOverlay)
            Positioned.fill(
              child: Container(
                color: Colors.black26,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: 220,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.check_circle,
                            size: 60, color: Colors.green),
                        SizedBox(height: 12),
                        Text("Organisasi Berhasil Ditambahkan",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
