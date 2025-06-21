import 'package:flutter/material.dart';
import 'package:owlpress/model/article.dart';
import 'package:owlpress/services/api_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String selectedCategory = "top";
  final List<String> categories = [
    "top",
    "world",
    "national",
    "sports",
    "technology",
    "entertainment",
    "health",
    "science",
    "business",
  ];

  final Map<String, String> categoryLabels = {
    "top": "Top",
    "world": "World",
    "national": "National",
    "sports": "Sport",
    "technology": "Technology",
    "entertainment": "Entertainment",
    "health": "Health",
    "science": "Science",
    "business": "Business",
  };

  final ApiService _apiService = ApiService();
  List<Article> articles = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchArticles(selectedCategory);
  }

  Future<void> fetchArticles(String category) async {
    setState(() {
      isLoading = true;
    });

    try {
      final allArticles = await _apiService.getArticles();

      final filtered =
          allArticles.where((article) {
            return article.category.toLowerCase().contains(
              category.toLowerCase(),
            );
          }).toList();

      setState(() {
        articles = filtered;
      });
    } catch (e) {
      print("Error fetching articles: $e");
      setState(() {
        articles = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2D23),
      appBar: AppBar(
        title: const Text(
          'CATEGORIES',
          style: TextStyle(
            color: Color(0xFFD1B97F),
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children:
                  categories.map((category) {
                    final isSelected = selectedCategory == category;
                    return ChoiceChip(
                      label: Text(
                        category[0].toUpperCase() + category.substring(1),
                        style: TextStyle(
                          color:
                              isSelected
                                  ? Colors.black
                                  : const Color(0xFFD1B97F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFFD1B97F),
                      backgroundColor: const Color(0xFF2A3C30),
                      shape: StadiumBorder(
                        side: BorderSide(
                          color:
                              isSelected
                                  ? const Color(0xFFD1B97F)
                                  : Colors.grey,
                        ),
                      ),
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                        });
                        fetchArticles(category);
                      },
                    );
                  }).toList(),
            ),
          ),
          const Divider(color: Colors.white24),
          Expanded(
            child:
                isLoading
                    ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFD1B97F),
                      ),
                    )
                    : articles.isEmpty
                    ? const Center(
                      child: Text(
                        'Tidak ada artikel.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                    : ListView.builder(
                      key: ValueKey(selectedCategory),
                      itemCount: articles.length,
                      padding: const EdgeInsets.all(12),
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return ArticleListItem(
                          title: article.title,
                          date: article.createdAt
                              .toLocal()
                              .toString()
                              .substring(0, 10),
                          image: article.imageUrl,
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3C30),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                image.isNotEmpty
                    ? Image.network(
                      image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => const Icon(
                            Icons.image_not_supported,
                            color: Colors.white,
                          ),
                    )
                    : const Icon(Icons.image, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFD1B97F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const Text(
                  'Klik untuk lihat selengkapnya...',
                  style: TextStyle(color: Colors.white60, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
