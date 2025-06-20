import 'package:flutter/material.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool isBookmarked = false;

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isBookmarked
              ? 'Artikel ditambahkan ke bookmark!'
              : 'Artikel dihapus dari bookmark.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDEFD9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Image(image: AssetImage('images/bikinibottom2.png')),
                  SizedBox(height: 16),
                  Text(
                    'Wabah Mosnter Krabby Patty!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                  Text(
                    'Des 1, 1950',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Lorem ipsum dolor amet, consectetur adipiscing elit. '
                    'Lorem ipsum dolor amet, consectetur adipiscing elit. '
                    'Lorem ipsum dolor amet, consectetur adipiscing elit. '
                    'Lorem ipsum dolor amet, consectetur adipiscing elit.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 60), // untuk memberi ruang ke tombol bawah
                ],
              ),
            ),
          ),

          // Tombol Bookmark
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              border: const Border(
                top: BorderSide(color: Colors.black12),
              ),
            ),
            child: GestureDetector(
              onTap: toggleBookmark,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    size: 28,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isBookmarked ? 'Bookmarked' : 'Add to Bookmark',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
