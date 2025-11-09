import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../main.dart'; // 🔹 Import helper navigasi

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  String username = "User TransEC";
  String email = "polibatam24@gmail.com";
  String? profileImagePath;

  late TextEditingController usernameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: username);
    emailController = TextEditingController(text: email);
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> pickProfileImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        profileImagePath = result.files.single.path!;
      });
    }
  }

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        usernameController.text = username;
        emailController.text = email;
      }
    });
  }

  void saveChanges() {
    setState(() {
      username = usernameController.text;
      email = emailController.text;
      isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil diperbarui ✅')),
    );
  }

  /// 🔹 Fungsi logout baru: arahkan ke halaman login dan hapus riwayat halaman
  void logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5134),
        elevation: 0,
        centerTitle: true, // ✅ Menengahkan teks "Profile"
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // ✅ tetap putih
          onPressed: () => goBack(context), // 🔙 kembali ke halaman sebelumnya
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- CARD PROFILE USER ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade100,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: const Color(0xFFDFF2E1),
                        backgroundImage: profileImagePath != null
                            ? FileImage(File(profileImagePath!))
                            : null,
                        child: profileImagePath == null
                            ? const Icon(Icons.person,
                                size: 45, color: Color(0xFF1F5134))
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: pickProfileImage,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF1F5134),
                            ),
                            child: const Icon(Icons.camera_alt,
                                size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(username,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text("@polibatam"),
                        Text(email),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isEditing ? Icons.close : Icons.edit,
                      color: const Color(0xFF1F5134),
                    ),
                    onPressed: toggleEdit,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // --- STATISTIK CARD ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade100,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Statistik Saya",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1F5134),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatBox(Icons.assignment, "Total Laporan", "0"),
                      _buildStatBox(Icons.eco, "Total Offset", "0.00 kg"),
                      _buildStatBox(Icons.fireplace, "Total Emisi", "0.00 kg"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // --- FORM EDIT PROFILE ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade100,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Username:"),
                  const SizedBox(height: 4),
                  TextField(
                    controller: usernameController,
                    readOnly: !isEditing,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: isEditing ? Colors.white : Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: isEditing
                            ? const BorderSide(color: Colors.green)
                            : BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text("Email:"),
                  const SizedBox(height: 4), 
                  TextField(
                    controller: emailController,
                    readOnly: !isEditing,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: isEditing ? Colors.white : Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: isEditing
                            ? const BorderSide(color: Colors.green)
                            : BorderSide.none,
                      ),
                    ),
                  ),

                  if (isEditing) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: toggleEdit,
                          child: const Text("Batal"),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F5134),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: saveChanges,
                          child: const Text("Simpan"),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),

            const SizedBox(height: 16),

            // --- GANTI SANDI ---
            InkWell(
              onTap: () => goToChangePassword(context),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade100,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ganti Sandi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F5134),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Color(0xFF1F5134), size: 18),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // --- KELUAR BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Keluar",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => logout(context), // ✅ arahkan ke login
              ),
            ),
          ],
        ),
      ),

      // ✅ Tidak dihapus, hanya dinonaktifkan untuk mencegah bug tab aktif
      bottomNavigationBar: null,
    );
  }

  static Widget _buildStatBox(IconData icon, String title, String value) {
    Color bgColor;
    if (title.contains("Offset")) {
      bgColor = Colors.green.shade100;
    } else if (title.contains("Emisi")) {
      bgColor = Colors.red.shade100;
    } else {
      bgColor = Colors.blue.shade100;
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF1F5134)),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 12)),
        Text(value,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }
}
