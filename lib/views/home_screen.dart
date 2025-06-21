import 'dart:async';
import 'package:flutter/material.dart';
import 'package:owlpress/model/article.dart';
import 'package:owlpress/services/api_service.dart';
import 'package:owlpress/views/article_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Article>> _futureArticles;

  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _futureArticles = _apiService.getArticles();

    _pageController = PageController(initialPage: 0);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage % 3,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2D23),
      appBar: AppBar(
        title: const Text(
          'OWL PRESS',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFFD1B97F),
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<Article>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFD1B97F)),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Gagal load artikel: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada artikel ditemukan.',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          final articles = snapshot.data!;
          final headlineArticles = articles.take(3).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // AUTO-SCROLL HEADLINE SLIDER
              SizedBox(
                height: 220,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: headlineArticles.length,
                  itemBuilder: (context, index) {
                    final article = headlineArticles[index];
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image:
                              article.imageUrl.isNotEmpty
                                  ? NetworkImage(article.imageUrl)
                                  : const AssetImage('images/default.png')
                                      as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            article.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Colors.black,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // LIST OF OTHER ARTICLES
              ...articles.map((article) {
                return Card(
                  color: const Color(0xFF2A3C30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child:
                          article.imageUrl.isNotEmpty
                              ? Image.network(
                                article.imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => Image.asset(
                                      'images/default.png',
                                      width: 60,
                                      height: 60,
                                    ),
                              )
                              : Image.asset(
                                'images/default.png',
                                width: 60,
                                height: 60,
                              ),
                    ),
                    title: Text(
                      article.title,
                      style: const TextStyle(
                        color: Color(0xFFD1B97F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      article.author,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  ArticleDetailScreen(article: article),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
