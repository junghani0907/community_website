import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:community_website/models/post.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000';

  static Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      Iterable json = jsonDecode(response.body);
      return List<Post>.from(json.map((model) => Post.fromJson(model)));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<void> createPost(Post post) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create post');
    }
  }
}
