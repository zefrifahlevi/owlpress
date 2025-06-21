import 'package:flutter/material.dart';
import 'package:owlpress/services/api_service.dart';
import 'package:owlpress/model/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final rePassword = _rePasswordController.text;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        rePassword.isEmpty) {
      _showSnackBar('Semua field wajib diisi!');
      return;
    }

    if (password != rePassword) {
      _showSnackBar('Password tidak cocok!');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final newUser = User(
        id: '',
        createdAt: DateTime.now(),
        username: username,
        email: email,
        password: password,
        interest: 'General',
      );

      await _apiService.createUser(newUser);

      _showSnackBar('Registrasi berhasil!');
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      _showSnackBar(
        'Registrasi gagal: ${e.toString().replaceFirst('Exception: ', '')}',
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.black, content: Text(message)),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: const TextStyle(color: Color(0xFFD1B97F)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFD1B97F)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFD1B97F)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.amber),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2D23),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: ListView(
          children: [
            Center(child: Image.asset('assets/images/logo2.png', height: 120)),
            const SizedBox(height: 30),

            _buildTextField(controller: _usernameController, label: 'Username'),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _emailController,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _passwordController,
              label: 'Password',
              isPassword: true,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _rePasswordController,
              label: 'Konfirmasi Password',
              isPassword: true,
            ),
            const SizedBox(height: 30),

            _isLoading
                ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFFD1B97F)),
                )
                : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD1B97F),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _register,
                  child: const Text(
                    'DAFTAR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

            const SizedBox(height: 20),
            const Text(
              'Powered by Kelompok 2',
              style: TextStyle(color: Colors.white60, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
