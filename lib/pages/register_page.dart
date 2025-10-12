import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller untuk input form
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      debugPrint('Data pendaftaran:');
      debugPrint('Nama Lengkap: ${fullNameController.text}');
      debugPrint('Email: ${emailController.text}');
      debugPrint('Password: ${passwordController.text}');
      debugPrint('Konfirmasi: ${confirmPasswordController.text}');
      // Tambahkan logika pendaftaran di sini
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran berhasil!')),
      );
    }
  }

  void _navigateToLogin() {
    // Arahkan ke halaman login
    debugPrint('Navigasi ke halaman login');
    // Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gambar latar belakang
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://public.youware.com/users-website-assets/prod/49b013aa-e753-44f6-bbf4-0267772de9ac/4db6f9b65a6a4c889fda7999b43a6f02.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay gelap transparan
          Container(
            color: Colors.black.withValues(alpha: 0.4), // ✅ perbaikan di sini
          ),

          // Konten form
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85), // ✅ perbaikan di sini
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2), // ✅ perbaikan di sini
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Judul
                      const Text(
                        'Daftar akun',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Input Nama Lengkap
                      _buildTextField(
                        controller: fullNameController,
                        label: 'Nama lengkap',
                        hint: 'Masukkan nama lengkap',
                        keyboardType: TextInputType.name,
                      ),

                      const SizedBox(height: 16),

                      // Input Email
                      _buildTextField(
                        controller: emailController,
                        label: 'E-Mail',
                        hint: 'Masukkan email',
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 16),

                      // Input Kata Sandi
                      _buildTextField(
                        controller: passwordController,
                        label: 'Kata Sandi',
                        hint: 'Masukkan kata sandi',
                        obscure: true,
                      ),

                      const SizedBox(height: 16),

                      // Konfirmasi Sandi
                      _buildTextField(
                        controller: confirmPasswordController,
                        label: 'Konfirmasi sandi',
                        hint: 'Konfirmasi kata sandi',
                        obscure: true,
                      ),

                      const SizedBox(height: 24),

                      // Tombol Daftar
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF008000),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 4,
                          ),
                          child: const Text(
                            'Daftar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Teks "Sudah punya akun?"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sudah punya akun? ',
                            style: TextStyle(color: Colors.black87),
                          ),
                          GestureDetector(
                            onTap: _navigateToLogin,
                            child: const Text(
                              'Masuk',
                              style: TextStyle(
                                color: Color(0xFF008000),
                                fontWeight: FontWeight.w600,
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
          ),
        ],
      ),
    );
  }

  // Widget custom untuk text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF008000),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: Color(0xFF008000), width: 2.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Kolom ini wajib diisi';
            }
            return null;
          },
        ),
      ],
    );
  }
}
