import 'package:flutter/material.dart';
import 'package:owlpress/model/article.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

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
        backgroundColor: Colors.black87,
        content: Text(
          isBookmarked
              ? 'Artikel ditambahkan ke bookmark!'
              : 'Artikel dihapus dari bookmark.',
          style: const TextStyle(color: Color(0xFFD1B97F)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return Scaffold(
      backgroundColor: const Color(0xFF1E2D23),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFD1B97F)),
          onPressed:
              () => Navigator.pop(context, isBookmarked ? article : null),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.imageUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Image.network(article.imageUrl),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD1B97F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${article.createdAt.day}-${article.createdAt.month}-${article.createdAt.year}',
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article.content,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),

          // Tombol Bookmark
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF2A3C30),
              border: Border(top: BorderSide(color: Colors.white12)),
            ),
            child: GestureDetector(
              onTap: toggleBookmark,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    size: 28,
                    color: const Color(0xFFD1B97F),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isBookmarked ? 'Bookmarked' : 'Add to Bookmark',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
