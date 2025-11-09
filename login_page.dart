import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controller opsional kalau nanti mau ambil nilai input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // state untuk toggle visibility password
  bool _isPasswordVisible = false; // 🔹 sudah ada

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🖼 Background image
          Image.asset(
            'assets/images/login_pages.png', // ganti sesuai nama file background kamu
            fit: BoxFit.cover,
          ),

          // Overlay gelap biar teks lebih jelas
          Container(color: Colors.black.withOpacity(0.3)),

          // Konten utama
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'E–Mail',
                      style: TextStyle(color: Colors.green[700]),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Kata Sandi',
                      style: TextStyle(color: Colors.green[700]),
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Password field dengan ikon mata 👇
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible, // 🔹 ubah sesuai toggle
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      // 🔹 Ikon mata pakai animasi lembut
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder: (child, anim) => RotationTransition(
                              turns: Tween(begin: 0.75, end: 1.0).animate(anim),
                              child: child,
                            ),
                            child: _isPasswordVisible
                                ? const Icon(
                                    Icons.visibility,
                                    key: ValueKey('visible'),
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    key: ValueKey('hidden'),
                                    color: Colors.green,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tombol Masuk
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        // 🔹 langsung masuk ke halaman home tanpa login data
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text(
                        'Masuk',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Belum punya akun? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register'); // ✅ ke halaman register
                        },
                        child: Text(
                          "Daftar",
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
