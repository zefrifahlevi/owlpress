import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /*
  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selamat datang, $username!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan password wajib diisi!')),
      );
    }
  }

  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2D23),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            const SizedBox(height: 60),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _usernameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD1B97F),
              ),
              onPressed: () {
              // Validasi dulu jika perlu, lalu arahkan ke dashboard
              Navigator.pushReplacementNamed(context, '/dashboard');
              },
              child: const Text('MASUK'),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'Baru di OwlPress ?\nGabung Sekarang Yuk!',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '"Kami bukan Morgans. Kami bukan Krab. Kami Owl.\n'
              'Kami tak berisik. Tapi kami melihat segalanya.\n'
              'Dalam dunia penuh gema dan desas-desus,\n'
              'kami memilih diam dan menyaring.\n'
              'Karena berita bukan soal siapa paling cepat,\n'
              'tapi siapa paling tepat."',
              style: TextStyle(
                color: Color(0xFFD1B97F),
                fontStyle: FontStyle.italic,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'Powered by Kelompok 2',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
