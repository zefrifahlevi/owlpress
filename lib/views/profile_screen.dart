import 'package:flutter/material.dart';
import 'package:owlpress/views/add_article_screen.dart';
import 'package:owlpress/views/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDEFD9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.red,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(
                    initialName: 'Kelompok 2',
                    initialEmail: 'kelompok2@owlpress.org',
                    initialJoined: 'Desember 1999',
                    initialInterest: 'Tech, Nasional',
                    onSave: (name, email, joined, interest) {
                      // Simpan atau update state
                      print('Updated profile: $name, $email, $joined, $interest');
                    },
                  ),
                ),
              );
            },
          ),
        ],
        backgroundColor: const Color(0xFFDDEFD9),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black54,
              child: Icon(Icons.person, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 16),
            const Text(
              'Owl Press',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('loremipsum@owlpress.org'),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Name'),
              subtitle: const Text('Kelompok 2'),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('kelompok2@owlpress.org'),
            ),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('Joined'),
              subtitle: const Text('Desember 1999'),
            ),
            ListTile(
              leading: const Icon(Icons.interests),
              title: const Text('Interest'),
              subtitle: const Text('Tech, Nasional'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddArtikelScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Tambah Artikel'),
            ),
          ],
        ),
      ),
    );
  }
}
