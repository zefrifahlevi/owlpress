import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
          // CATEGORY TABS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                CategoryChip(label: "Top", color: Colors.orange),
                CategoryChip(label: "World", color: Colors.green),
                CategoryChip(label: "National", color: Colors.teal),
                CategoryChip(label: "Sport", color: Colors.greenAccent),
                CategoryChip(label: "Technology", color: Colors.black54),
                CategoryChip(label: "Entertainment", color: Colors.lightGreen),
              ],
            ),
          ),

          const Divider(),

          // LIST OF ARTICLES
          Expanded(
            child: ListView(
              children: const [
                ArticleListItem(
                  title: "Wabah Monster Krabby Patty!",
                  date: "1 Desember 1950",
                  image: "images/bikinibottom2.png",
                ),
                ArticleListItem(
                  title: "Wabah Jamur Gatal!",
                  date: "1 Desember 1950",
                  image: "images/bikinibottom2.png",
                ),
                ArticleListItem(
                  title: "Wabah Bodoh Patrick!",
                  date: "1 Desember 1950",
                  image: "images/bikinibottom2.png",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// WIDGET CHIP
class CategoryChip extends StatelessWidget {
  final String label;
  final Color color;

  const CategoryChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color,
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

// WIDGET LIST ITEM
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
