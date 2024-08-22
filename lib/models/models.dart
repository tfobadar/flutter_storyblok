import 'dart:convert';

class RichTextContent {
  final String type;
  final List<Content> content;
  final List<Section>? topSection; // Add this line

  RichTextContent(
      {required this.type,
      required this.content,
      this.topSection}); // Update constructor

  factory RichTextContent.fromJson(Map<String, dynamic> json) {
    return RichTextContent(
      type: json['type'],
      content:
          (json['content'] as List).map((i) => Content.fromJson(i)).toList(),
      topSection: json['topSection'] != null
          ? (json['topSection'] as List)
              .map((i) => Section.fromJson(i))
              .toList()
          : null,
    );
  }
}

class Content {
  final String type;
  final String? text;
  final List<Content>? content;
  final Map<String, dynamic>? attrs;

  Content({required this.type, this.text, this.content, this.attrs});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      type: json['type'],
      text: json['text'],
      content: json['content'] != null
          ? (json['content'] as List).map((i) => Content.fromJson(i)).toList()
          : null,
      attrs: json['attrs'],
    );
  }
}

// Create a new Section class to represent components like sectionTitle and image
class Section {
  final String component;
  final String? title;
  final String? description;
  final Map<String, dynamic>? attrs;

  Section({
    required this.component,
    this.title,
    this.description,
    this.attrs,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      component: json['component'],
      title: json['title'],
      description: json['description'],
      attrs: json['attrs'],
    );
  }
}
