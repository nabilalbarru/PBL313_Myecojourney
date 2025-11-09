import 'package:flutter/material.dart';
import '../main.dart'; // 🔹 biar bisa pakai goToHome(), goBack(), dll.

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isOldPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5134),
        elevation: 0,
        title: const Text(
          'Ganti Sandi',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => goBack(context), // 🔹 pakai helper
        ),
      ),

      // =============== BODY ===============
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20),
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
                _buildPasswordField(
                  label: "Kata sandi lama:",
                  controller: oldPasswordController,
                  hint: "Masukkan kata sandi lama...",
                  isVisible: isOldPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      isOldPasswordVisible = !isOldPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 14),
                _buildPasswordField(
                  label: "Kata sandi baru:",
                  controller: newPasswordController,
                  hint: "Masukkan kata sandi baru...",
                  isVisible: isNewPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      isNewPasswordVisible = !isNewPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 14),
                _buildPasswordField(
                  label: "Ulangi kata sandi:",
                  controller: confirmPasswordController,
                  hint: "Ulangi kata sandi baru...",
                  isVisible: isConfirmPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 28),

                // Tombol aksi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => goBack(context), // 🔹 pakai helper
                        child: const Text(
                          'Batal',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1F5134),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Kata sandi berhasil diperbarui ✅'),
                            ),
                          );
                          goToProfile(context); // 🔹 setelah ubah, balik ke profil
                        },
                        child: const Text(
                          'Perbarui Sandi',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // =============== BOTTOM NAVIGATION ===============
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1F5134),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFE5F3EB),
        showUnselectedLabels: true,
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) goToHome(context);
          if (index == 3) goToOffset(context);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: "Tracking"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Monitor"),
          BottomNavigationBarItem(
              icon: Icon(Icons.eco_outlined), label: "Offset"),
        ],
      ),
    );
  }

  // ================= PASSWORD FIELD BUILDER =================
  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F5134),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: !isVisible,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: const Color(0xFFF2F2F2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFF1F5134),
              ),
              onPressed: onToggleVisibility,
            ),
          ),
        ),
      ],
    );
  }
}
