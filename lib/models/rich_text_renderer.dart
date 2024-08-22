import 'package:flutter/material.dart';
import 'models.dart';
import 'section_title.dart';
import 'image_banner.dart';

class RichTextRenderer extends StatelessWidget {
  final Content content;

  RichTextRenderer({required this.content});

  @override
  Widget build(BuildContext context) {
    switch (content.type) {
      case 'paragraph':
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content.content!.map((childContent) {
              return RichTextRenderer(content: childContent);
            }).toList(),
          ),
        );
      case 'text':
        return Text(
          content.text ?? '',
          style: const TextStyle(fontSize: 16),
        );
      case 'image':
        return ImageBanner(
          imageUrl: content.attrs?['src'] ?? '',
        );
      case 'heading':
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content.content!.map((childContent) {
              if (childContent.type == 'text') {
                return Text(
                  childContent.text ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else {
                return RichTextRenderer(content: childContent);
              }
            }).toList(),
          ),
        );
      default:
        return const SizedBox
            .shrink(); // Return empty if the type is not supported
    }
  }
}
