class Article {
  final String id;
  final DateTime createdAt;
  final String title;
  final String category;
  final String imageUrl;
  final String content;
  final String author;

  Article({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.content,
    required this.author,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      title: json['title'],
      category: json['category'],
      imageUrl: json['image'],
      content: json['content'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'title': title,
      'category': category,
      'image': imageUrl,
      'content': content,
      'author': author,
    };
  }
}