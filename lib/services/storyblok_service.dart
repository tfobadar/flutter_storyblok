// lib/services/storyblok_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class StoryblokService {
  // final String apiUrl =
  //     'https://api.storyblok.com/v2/cdn/stories?cv=1724221589&language=en&page=1&per_page=10&sort_by=content.PublishDate%3Adesc&starts_with=insights%2Farticles&token=jxjzZquYCxzN9rKmxl6yvQtt';
  final String apiUrl =
      'https://api.storyblok.com/v2/cdn/stories?cv=1724221589&language=en&page=1&per_page=10&sort_by=content.PublishDate%3Adesc&starts_with=insights%2Fmanagement-views&token=jxjzZquYCxzN9rKmxl6yvQtt';
  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List articlesJson = jsonResponse['stories'];

      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
