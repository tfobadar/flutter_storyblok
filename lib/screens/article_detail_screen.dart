import 'package:flutter/material.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String articleName;
  final String title;
  final String bannerUrl;
  final Map<String, dynamic>? content;

  const ArticleDetailScreen({
    Key? key,
    required this.articleName,
    required this.title,
    required this.bannerUrl,
    required String slug,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(articleName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              bannerUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200, // Adjust the height as needed
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (content != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ContentWidget(content: content!),
              ),
          ],
        ),
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  final Map<String, dynamic> content;

  const ContentWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildContent(context, content['content']),
    );
  }

  List<Widget> _buildContent(BuildContext context, List<dynamic> contentList) {
    List<Widget> widgets = [];

    for (var element in contentList) {
      widgets.add(_renderContentNode(context, element));
    }
    return widgets;
  }

  Widget _renderContentNode(
      BuildContext context, Map<String, dynamic> content) {
    if (content.isEmpty || content['type'] == null) {
      return const Text(
        '',
        style: TextStyle(fontSize: 16),
      );
    }

    switch (content['type']) {
      case 'paragraph':
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content['content']?.map<Widget>((childContent) {
                  return _renderContentNode(context, childContent);
                }).toList() ??
                [],
          ),
        );
      case 'text':
        if (content['marks'] != null) {
          for (var mark in content['marks']) {
            if (mark['type'] == 'link') {
              return GestureDetector(
                onTap: () {
                  final url = mark['attrs']?['href'] ?? '';
                  if (url.isNotEmpty) {
                    // Launch the URL (use a package like `url_launcher`)
                    // launch(url);
                  }
                },
                child: Text(
                  content['text'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.amber, // Gold color
                    decoration: TextDecoration.underline, // Underline for links
                  ),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              );
            }
          }
        }
        return Text(
          content['text'] ?? '',
          style: const TextStyle(
            fontSize: 16,
          ),
          softWrap: true,
          overflow: TextOverflow.clip,
        );
      case 'image':
        return Image.network(
          content['attrs']?['src'] ?? '',
        );
      case 'heading':
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content['content']?.map<Widget>((childContent) {
                  if (childContent['type'] == 'text') {
                    return Text(
                      childContent['text'] ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return _renderContentNode(context, childContent);
                  }
                }).toList() ??
                [],
          ),
        );
      case 'bullet_list':
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content['content']?.map<Widget>((childContent) {
                  return _renderContentNode(context, childContent);
                }).toList() ??
                [],
          ),
        );
      case 'list_item':
        return Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("• ", style: TextStyle(fontSize: 16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content['content']?.map<Widget>((childContent) {
                        return _renderContentNode(context, childContent);
                      }).toList() ??
                      [],
                ),
              ),
            ],
          ),
        );
      default:
        return const Text(
          '', // Default to empty text if content is unsupported or undefined
          style: TextStyle(fontSize: 16),
        );
    }
  }
}
