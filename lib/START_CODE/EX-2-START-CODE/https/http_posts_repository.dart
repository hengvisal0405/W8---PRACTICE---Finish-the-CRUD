import 'dart:convert';
import '../dto/post_dto.dart';
import '../repository/post_repository1.dart';
import 'package:http/http.dart' as http;


class HttpPostsRepository implements PostRepository1 {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  final PostDTO dto = PostDTO();
  
  @override
  Future<List<Post1>> getPosts(List<int> postIds) async {
    return Future.wait(postIds.map((id) async {
      try {
        final response = await http.get(Uri.parse('$apiUrl/$id'));
        if (response.statusCode == 200) {
          return dto.fromJson(json.decode(response.body));
        }
        throw Exception('Failed to load post: ${response.statusCode}');
      } catch (e) {
        throw Exception('Network error: $e');
      }
    }));
  }
}