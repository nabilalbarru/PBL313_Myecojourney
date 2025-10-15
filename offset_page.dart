import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MaterialApp(home: OffsetPage()));
}

// ================= OFFSET PAGE =================

class OffsetPage extends StatefulWidget {
  const OffsetPage({super.key});

  @override
  State<OffsetPage> createState() => _OffsetPageState();
}

class _OffsetPageState extends State<OffsetPage> {
  double donation = 0;
  String? selectedOrganization;
  final TextEditingController donationController = TextEditingController();

  final List<String> organizations = [
    'Yayasan Hutan Indonesia',
    'Green Earth Foundation',
    'Mangrove Care Indonesia',
    'Lindungi Hutan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5134),
        elevation: 0,
        title: const Text('Offset Karbon', style: TextStyle(color: Colors.white)),
        actions: [
          // Profile dropdown
          PopupMenuButton<String>(
            icon: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF1F5134)),
            ),
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              } else if (value == 'edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfilePage()),
                );
              } else if (value == 'password') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
                );
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'profile', child: Text('Profile')),
              PopupMenuItem(value: 'edit', child: Text('Edit Profile')),
              PopupMenuItem(value: 'password', child: Text('Ganti Password')),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryCards(),
            const SizedBox(height: 20),
            _buildOrgSection(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _summaryCard('Total Emisi', '0.00 kg CO₂', 'dari 0 perjalanan', Colors.red),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _summaryCard('Total Offset', '0.00 kg CO₂', 'Rp 0 donasi', Colors.green),
        ),
      ],
    );
  }

  Widget _summaryCard(String title, String value, String sub, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.green.shade100, blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Color(0xFF768F7D))),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(sub, style: const TextStyle(fontSize: 12, color: Color(0xFF9EAFA6))),
        ],
      ),
    );
  }

  Widget _buildOrgSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Organisasi Rekomendasi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F5134))),
          ElevatedButton.icon(
            onPressed: () => _showDonationDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F5134),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.eco),
            label: const Text('Offset'),
          ),
        ]),
        const SizedBox(height: 10),
        _orgTile('Yayasan Hutan Indonesia',
            'https://images.unsplash.com/photo-1482192596544-9eb780fc7f66?auto=format&fit=crop&w=400&q=80',
            'Menjaga kelestarian hutan tropis dan habitat satwa liar.'),
        _orgTile('Green Earth Foundation',
            'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=400&q=80',
            'Mengedukasi publik dan menggerakkan aksi penghijauan global.'),
        _orgTile('Mangrove Care Indonesia',
            'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=400&q=80',
            'Fokus pada rehabilitasi dan pelestarian hutan mangrove.'),
        _orgTile('Lindungi Hutan',
            'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=400&q=80',
            'Menanam pohon untuk mengurangi dampak perubahan iklim.'),
      ],
    );
  }

  Widget _orgTile(String name, String image, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4ED),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.green.shade200, blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(image, width: 56, height: 56, fit: BoxFit.cover),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1F5134))),
        subtitle: Text(desc, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ),
    );
  }

  void _showDonationDialog(BuildContext context) {
    selectedOrganization = null;
    donationController.clear();
    donation = 0;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Offset Karbon', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Pilih organisasi dan jumlah donasi untuk mengoffset jejak karbon Anda',
                style: TextStyle(fontSize: 13)),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Pilih Organisasi', border: OutlineInputBorder()),
              value: selectedOrganization,
              items: organizations.map((org) => DropdownMenuItem(value: org, child: Text(org))).toList(),
              onChanged: (value) => setState(() => selectedOrganization = value),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: donationController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Jumlah Donasi (Rupiah)', border: OutlineInputBorder()),
              onChanged: (val) => setState(() => donation = double.tryParse(val) ?? 0),
            ),
            const SizedBox(height: 10),
            Text('Estimasi offset: ${(donation / 10000).toStringAsFixed(2)} kg CO₂'),
            const SizedBox(height: 4),
            const Text('Minimal donasi: Rp 10.000', style: TextStyle(fontSize: 12, color: Colors.red)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
            onPressed: () {
              if (donation < 10000) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Donasi minimal Rp 10.000')),
                );
                return;
              }
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TransferMethodPage()),
              );
            },
            child: const Text('Transfer Bank'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.location_on, 'label': 'Tracking'},
      {'icon': Icons.bar_chart, 'label': 'Monitor'},
      {'icon': Icons.eco, 'label': 'Offset'},
    ];

    return BottomNavigationBar(
      currentIndex: 3,
      selectedItemColor: const Color(0xFF1F5134),
      unselectedItemColor: Colors.grey,
      backgroundColor: const Color(0xFFE5F3EB),
      type: BottomNavigationBarType.fixed,
      items: items
          .map((e) => BottomNavigationBarItem(icon: Icon(e['icon'] as IconData), label: e['label'] as String))
          .toList(),
    );
  }
}

// ================= TRANSFER =================

class TransferMethodPage extends StatelessWidget {
  const TransferMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final banks = [
      {'name': 'Bank BCA', 'logo': Icons.account_balance_wallet},
      {'name': 'Bank BRI', 'logo': Icons.account_balance},
      {'name': 'Bank BNI', 'logo': Icons.savings},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Metode Transfer'), backgroundColor: const Color(0xFF1F5134)),
      backgroundColor: const Color(0xFFF2F7F3),
      body: ListView.builder(
        itemCount: banks.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final bank = banks[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(bank['logo'] as IconData, color: const Color(0xFF1F5134)),
              title: Text(bank['name'] as String),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransferDetailPage(bankName: bank['name'] as String),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ================= DETAIL TRANSFER =================

class TransferDetailPage extends StatelessWidget {
  final String bankName;
  const TransferDetailPage({super.key, required this.bankName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Transfer ($bankName)'), backgroundColor: const Color(0xFF1F5134)),
      backgroundColor: const Color(0xFFF2F7F3),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Nomor Rekening', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration:
                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('2222744635 - Yayasan Pohon Indonesia'), Icon(Icons.copy)],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Jumlah Transfer', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration:
                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const Text('Rp 10.000'),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F5134),
                  padding: const EdgeInsets.symmetric(vertical: 14)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadProofPage()),
                );
              },
              child: const Text('Saya Sudah Transfer'),
            ),
          ),
        ]),
      ),
    );
  }
}

// ================= UPLOAD BUKTI OPSIONAL =================

class UploadProofPage extends StatefulWidget {
  const UploadProofPage({super.key});

  @override
  State<UploadProofPage> createState() => _UploadProofPageState();
}

class _UploadProofPageState extends State<UploadProofPage> {
  String? selectedFileName;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFileName = result.files.single.name;
      });
    } else {
      debugPrint("Tidak ada file dipilih (opsional).");
    }
  }

  void submitProof() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SuccessTransferPage()),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(selectedFileName == null
            ? "Lanjut tanpa upload bukti (opsional) ✅"
            : "File berhasil diupload: $selectedFileName"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Bukti Transfer'), backgroundColor: const Color(0xFF1F5134)),
      backgroundColor: const Color(0xFFF2F7F3),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.upload_file, size: 100, color: Color(0xFF1F5134)),
            const SizedBox(height: 20),
            const Text('Silakan unggah bukti transfer Anda (opsional).', textAlign: TextAlign.center),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.folder_open),
              label: const Text('Pilih File'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F5134),
                foregroundColor: Colors.white,
              ),
              onPressed: pickFile,
            ),
            const SizedBox(height: 16),
            if (selectedFileName != null)
              Text('File terpilih: $selectedFileName', style: const TextStyle(fontSize: 14, color: Colors.black87)),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F5134),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: submitProof,
              child: const Text('Kirim Bukti'),
            ),
          ]),
        ),
      ),
    );
  }
}

// ================= SUCCESS =================

class SuccessTransferPage extends StatelessWidget {
  const SuccessTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F3),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 120, color: Colors.green),
              const SizedBox(height: 20),
              const Text('Transaksi Berhasil Dicatat!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1F5134))),
              const SizedBox(height: 10),
              const Text('Terima kasih telah mendukung penghijauan bumi.',
                  textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F5134),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Kembali ke Halaman Utama'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= EDIT PROFILE =================

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'), backgroundColor: const Color(0xFF1F5134)),
      body: const Center(child: Text('Form Edit Profile di sini')),
    );
  }
}

// ================= CHANGE PASSWORD =================

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ganti Password'), backgroundColor: const Color(0xFF1F5134)),
      body: const Center(child: Text('Form Ganti Password di sini')),
    );
  }
}

// ================= PROFILE PAGE =================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), backgroundColor: const Color(0xFF1F5134)),
      body: const Center(child: Text('Halaman Profile di sini')),
    );
  }
}
