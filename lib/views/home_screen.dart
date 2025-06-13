import 'package:flutter/material.dart';
import 'article_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News!'), backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Top  World  National  Tech'),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ArticleDetailScreen()),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logo2.png'),
                const SizedBox(height: 8),
                const Text(
                  'Bikini Bottom Diserang Virus Siput Gila!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text('Headline of The Featured Article!'),
              ],
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.article),
            title: Text('Wabah Monster Krabby Patty!'),
            subtitle: Text('1 Desember 1950'),
          ),
          const ListTile(
            leading: Icon(Icons.article),
            title: Text('Wabah Jamur Gatal!'),
            subtitle: Text('1 Desember 1950'),
          ),
        ],
      ),
    );
  }
}
