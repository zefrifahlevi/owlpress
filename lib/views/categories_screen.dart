import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String selectedCategory = "Top";

  // Data dummy berdasarkan kategori
  final Map<String, List<Map<String, String>>> categoryArticles = {
    "Top": [
      {
        "title": "Wabah Monster Krabby Patty!",
        "date": "1 Desember 1950",
        "image": "assets/images/bikinibottom1.png"
      },
      {
        "title": "Wabah Jamur Gatal!",
        "date": "1 Desember 1950",
        "image": "assets/images/bikinibottom2.png"
      },
      {
        "title": "Wabah Bodoh Patrick!",
        "date": "1 Desember 1950",
        "image": "assets/images/bikinibottom1.png"
      },
    ],
    "World": [
      {
        "title": "Wabah Monster Krabby Patty!",
        "date": "1 Desember 1950",
        "image": "assets/images/bikinibottom1.png"
      },
    ],
    "National": [
      {
        "title": "Wabah Jamur Gatal!",
        "date": "1 Desember 1950",
        "image": "assets/images/bikinibottom2.png"
      },
    ],
    "Sport": [
      {
        "title": "Wabah Bodoh Patrick!",
        "date": "1 Desember 1950",
        "image": "assets/images/bikinibottom2.png"
      },
    ],
    "Technology": [
      {
        "title": "Wabah Bodoh Patrick!",
        "date": "1 Desember 1950",
        "image": "assets/images/bikinibottom1.png"
      },
    ],
    "Entertainment": [
      {
        "title": "Wabah Bodoh Patrick!",
        "date": "1 Desember 1950",
        "image": "assets/images/bikinibottom2.png"
      },
    ],
  };

  final List<String> categories = [
    "Top",
    "World",
    "National",
    "Sport",
    "Technology",
    "Entertainment"
  ];

  final Map<String, Color> categoryColors = {
    "Top": Colors.orange,
    "World": Colors.green,
    "National": Colors.teal,
    "Sport": Colors.greenAccent,
    "Technology": Colors.black54,
    "Entertainment": Colors.lightGreen,
  };

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> articles =
        categoryArticles[selectedCategory] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFDDEFD9),
      appBar: AppBar(
        /*
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        */
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.red,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // CATEGORY SELECTOR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((category) {
                final isSelected = selectedCategory == category;
                return ChoiceChip(
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                    ),
                  ),
                  selectedColor: Colors.orange[100],
                  backgroundColor: categoryColors[category],
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
          ),

          const Divider(),

          // ARTICLE LIST BASED ON CATEGORY
          Expanded(
            child: articles.isEmpty
                ? const Center(child: Text('Tidak ada artikel.'))
                : ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return ArticleListItem(
                        title: article['title'] ?? '',
                        date: article['date'] ?? '',
                        image: article['image'] ?? '',
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}

// REUSABLE ARTICLE ITEM WIDGET
class ArticleListItem extends StatelessWidget {
  final String title;
  final String date;
  final String image;

  const ArticleListItem({
    super.key,
    required this.title,
    required this.date,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date, style: const TextStyle(fontSize: 12)),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      isThreeLine: true,
    );
  }
}
