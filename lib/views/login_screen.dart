import 'package:flutter/material.dart';
import 'package:owlpress/services/api_service.dart';
import 'package:owlpress/model/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final usernameOrEmail = _usernameController.text.trim();
    final password = _passwordController.text;

    if (usernameOrEmail.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Text('Username/Email dan password tidak boleh kosong!'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final List<User> users = await _apiService.getUsers();

      final matchedUser = users.firstWhere(
        (user) =>
            (user.username.toLowerCase() == usernameOrEmail.toLowerCase() ||
                user.email.toLowerCase() == usernameOrEmail.toLowerCase()) &&
            user.password == password,
        orElse: () => throw Exception('Username/email atau password salah!'),
      );

      // Jika login berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black87,
          content: Text('Selamat datang, ${matchedUser.username}!'),
        ),
      );

      await _controller.forward();
      await Future.delayed(const Duration(milliseconds: 100));
      await _controller.reverse();

      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Login gagal: ${e.toString().replaceFirst('Exception: ', '')}',
          ),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFD1B97F)),
        filled: true,
        fillColor: const Color(0xFF2A3C30),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD1B97F)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.amber),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2D23),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            const SizedBox(height: 60),
            Center(child: Image.asset('assets/images/logo.png', width: 100)),
            const SizedBox(height: 40),
            _buildTextField(
              label: 'Username / Email',
              controller: _usernameController,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Password',
              controller: _passwordController,
              obscure: true,
            ),
            const SizedBox(height: 20),

            _isLoading
                ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFFD1B97F)),
                )
                : ScaleTransition(
                  scale: _scaleAnimation,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD1B97F),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      shadowColor: Colors.black45,
                    ),
                    child: const Text(
                      'MASUK',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

            const SizedBox(height: 10),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'Baru di OwlPress ?\nGabung Sekarang Yuk!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
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
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: Color(0xFFD1B97F),
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Powered by Kelompok 2',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
