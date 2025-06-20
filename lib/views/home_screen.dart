import 'package:flutter/material.dart';
import 'article_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Top';

  final List<String> categories = ['Top', 'World', 'National', 'Tech'];

  final Map<String, List<Map<String, String>>> articlesByCategory = {
    'Top': [
      {
        'title': 'Wabah Monster Krabby Patty!',
        'date': '1 Desember 1950',
        'image': 'images/bikinibottom2.png'
      },
      {
        'title': 'Wabah Jamur Gatal!',
        'date': '1 Desember 1950',
        'image': 'images/bikinibottom2.png'
      },
      {
        'title': 'Wabah Bodoh Patrick!',
        'date': '1 Desember 1950',
        'image': 'images/bikinibottom1.png'
      },
    ],
    'World': [
      {
        'title': 'Krisis Bikini Bottom!',
        'date': '1 Desember 1950',
        'image': 'images/bikinibottom1.png'
      },
    ],
    'National': [
      {
        'title': 'Jamur Menyerang Patrick!',
        'date': '1 Desember 1950',
        'image': 'images/bikinibottom2.png'
      },
    ],
    'Tech': [
      {
        'title': 'Inovasi Canggih di Krusty Krab!',
        'date': '1 Desember 1950',
        'image': 'images/bikinibottom1.png'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final articles = articlesByCategory[selectedCategory] ?? [];

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
          // TAB KATEGORI
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: categories.map((cat) {
              final isSelected = selectedCategory == cat;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = cat;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      cat,
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
                ),
              );
            }).toList(),
          ),

          const Divider(),
          const SizedBox(height: 16),

          // ARTIKEL UNGGULAN
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
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

          // ARTIKEL BERDASARKAN KATEGORI
          ...articles.map((article) => ArticleItem(
                title: article['title']!,
                date: article['date']!,
                image: article['image']!,
              )),
        ],
      ),
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
