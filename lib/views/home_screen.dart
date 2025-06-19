import 'package:flutter/material.dart';
import 'article_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDEFD9),
      appBar: AppBar(
        title: const Text(
          'News!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tab Kategori
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              CategoryTab(label: 'Top', isSelected: true),
              CategoryTab(label: 'World'),
              CategoryTab(label: 'National'),
              CategoryTab(label: 'Tech'),
            ],
          ),
          const Divider(),

          // Artikel Unggulan
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
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('images/bikinibottom1.png'),
                    ),
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                    const Positioned.fill(
                      child: Center(
                        child: Text(
                          'Bikini Bottom Diserang Virus Siput Gila!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Headline of The Featured Article!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 20),
          const ArticleItem(
            title: 'Wabah Monster Krabby Patty!',
            date: '1 Desember 1950',
            image: 'images/bikinibottom2.png',
          ),
          const ArticleItem(
            title: 'Wabah Jamur Gatal!',
            date: '1 Desember 1950',
            image: 'images/bikinibottom2.png',
          ),
          const ArticleItem(
            title: 'Wabah Bodoh Patrick!',
            date: '1 Desember 1950',
            image: 'images/bikinibottom2.png',
          ),
        ],
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryTab({super.key, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 20,
            height: 3,
            color: Colors.orange,
          )
      ],
    );
  }
}

class ArticleItem extends StatelessWidget {
  final String title;
  final String date;
  final String image;

  const ArticleItem({
    super.key,
    required this.title,
    required this.date,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date, style: const TextStyle(fontSize: 12)),
          const Text(
            'Lorem Ipsum dolor sit amet, consectetur adipiscing elit.',
            style: TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
