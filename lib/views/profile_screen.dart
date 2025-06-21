import 'package:flutter/material.dart';
import 'package:owlpress/views/add_article_screen.dart';
import 'package:owlpress/views/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Kelompok 2';
  String email = 'kelompok2@owlpress.org';
  String joined = 'Desember 1999';
  String interest = 'Tech, Nasional';

  void _openSettings() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SettingScreen(
              initialName: name,
              initialEmail: email,
              initialJoined: joined,
              initialInterest: interest,
              onSave: (
                updatedName,
                updatedEmail,
                updatedJoined,
                updatedInterest,
              ) {
                setState(() {
                  name = updatedName;
                  email = updatedEmail;
                  joined = updatedJoined;
                  interest = updatedInterest;
                });
              },
            ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3C30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1B97F), width: 1),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFD1B97F)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2D23),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFD1B97F)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFFD1B97F)),
            onPressed: _openSettings,
          ),
        ],
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color(0xFFD1B97F),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black54,
              child: Icon(Icons.person, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(email, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 30),

            // Info Tiles
            _buildInfoTile(Icons.person, 'Name', name),
            _buildInfoTile(Icons.email, 'Email', email),
            _buildInfoTile(Icons.date_range, 'Joined', joined),
            _buildInfoTile(Icons.interests, 'Interest', interest),
            const SizedBox(height: 30),

            // Tombol Tambah Artikel
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddArtikelScreen()),
                );
              },
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text("Tambah Artikel"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD1B97F),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
