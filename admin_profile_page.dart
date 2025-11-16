import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  File? profileImage;

  bool oldPassHide = true;
  bool newPassHide = true;
  bool repeatPassHide = true;

  Future pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() => profileImage = File(picked.path));
    }
  }

  void showSavedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Berhasil!"),
        content: const Text("Perubahan berhasil disimpan."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5134),
        title: const Text("Admin Profil", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // ======================================================
            // 🔥 PROFILE PHOTO WITH CAMERA ICON
            // ======================================================
            Stack(
              children: [
                GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage:
                        profileImage != null ? FileImage(profileImage!) : null,
                    child: profileImage == null
                        ? const Icon(Icons.person, size: 55, color: Colors.grey)
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1F5134),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ======================================================
            // 🔥 INFORMASI AKUN
            // ======================================================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Informasi Akun",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                  const SizedBox(height: 10),

                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Nama Admin",
                      border: UnderlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Email Admin",
                      border: UnderlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F5134),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: showSavedDialog,
                    child: const Text("Simpan", style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ======================================================
            // 🔥 GANTI PASSWORD
            // ======================================================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Ganti Sandi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                  const SizedBox(height: 10),

                  // old password
                  TextField(
                    obscureText: oldPassHide,
                    decoration: InputDecoration(
                      labelText: "Kata sandi lama",
                      border: const UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          oldPassHide ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() => oldPassHide = !oldPassHide);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // new password
                  TextField(
                    obscureText: newPassHide,
                    decoration: InputDecoration(
                      labelText: "Kata sandi baru",
                      border: const UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          newPassHide ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() => newPassHide = !newPassHide);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // repeat password
                  TextField(
                    obscureText: repeatPassHide,
                    decoration: InputDecoration(
                      labelText: "Ulangi kata sandi",
                      border: const UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          repeatPassHide ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() => repeatPassHide = !repeatPassHide);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F5134),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: showSavedDialog,
                          child: const Text("Perbarui Sandi",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            // tetap di sini dan tidak keluar
                          },
                          child: const Text("Batal",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ======================================================
            // 🔥 LOGOUT BUTTON (tombol keluar dengan teks merah)
            // ======================================================
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.red),
                ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
              },
              child: const Text(
                "Keluar",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
