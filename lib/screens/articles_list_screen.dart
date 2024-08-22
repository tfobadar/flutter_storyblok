// lib/screens/articles_list_screen.dart

import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/storyblok_service.dart';
import 'article_detail_screen.dart';

class ArticlesListScreen extends StatelessWidget {
  final StoryblokService storyblokService = StoryblokService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Articles')),
      body: FutureBuilder<List<Article>>(
        future: storyblokService.fetchArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No articles found'));
          }

          final articles = snapshot.data!;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Column(
                children: [
                  ListTile(
                    leading: Image.network(article.imageUrl),
                    title: Text(article.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailScreen(
                            slug: article.slug,
                            articleName: article.name,
                            bannerUrl: article.imageUrl,
                            title: article.name,
                            content: article.content,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
