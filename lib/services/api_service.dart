import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:owlpress/model/article.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:owlpress/model/user.dart';

final String _newsDataApiKey = dotenv.env['NEWSDATA_API_KEY'] ?? '';
const String _newsDataUrl = 'https://newsdata.io/api/1/news';
final String _baseUrl = dotenv.env['MOCKAPI_BASE_URL'] ?? '';

class ApiService {
  // Ambil Artikel Dari Newsdata.io
  Future<List<Article>> getArticles() async {
    final uri = Uri.parse(
      '$_newsDataUrl?apikey=$_newsDataApiKey&country=id&language=id&category=technology',
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        final List<dynamic> jsonList = jsonMap['results'];

        return jsonList.map((json) {
          return Article(
            id: json['link'] ?? '', // Tidak ada ID, pakai link sebagai ID dummy
            title: json['title'] ?? '',
            content: json['description'] ?? 'Konten tidak tersedia.',
            imageUrl: json['image_url'] ?? '',
            author:
                (json['creator'] != null && json['creator'] is List)
                    ? (json['creator'] as List).join(', ')
                    : 'Unknown',
            createdAt:
                DateTime.tryParse(json['pubDate'] ?? '') ?? DateTime.now(),
            category:
                (json['category'] != null && json['category'] is List)
                    ? (json['category'] as List).join(', ')
                    : 'technology',
          );
        }).toList();
      } else {
        throw Exception('Gagal load artikel. Kode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gagal konek ke NewsData API: $e');
    }
  }

  // ✅ Fungsi-fungsi USER di dalam class ApiService
  Future<List<User>> getUsers() async {
    final uri = Uri.parse('$_baseUrl/users');
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load users. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to API: $e');
    }
  }

  Future<User> createUser(User user) async {
    final uri = Uri.parse('$_baseUrl/users');
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        return User.fromJson(jsonMap);
      } else {
        throw Exception(
          'Failed to create user. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to API or create user: $e');
    }
  }
}
