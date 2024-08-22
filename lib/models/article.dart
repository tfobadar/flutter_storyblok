//import 'models.dart';

class Article {
  final String name;
  final String slug;
  final String imageUrl;
  final Map<String, dynamic>? content;

  Article({
    required this.name,
    required this.slug,
    required this.imageUrl,
    this.content = const {},
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      imageUrl: json['content']['image']['filename'] ?? '',
      content: json['content']['content'] ?? '',
    );
  }
}

// class Content {
//   final String type;
//   final String? text;
//   final List<Content>? content;
//   final Map<String, dynamic>? attrs;

//   Content({required this.type, this.text, this.content, this.attrs});

//   factory Content.fromJson(Map<String, dynamic> json) {
//     return Content(
//       type: json['type'],
//       text: json['text'],
//       content: json['content'] != null
//           ? (json['content'] as List).map((i) => Content.fromJson(i)).toList()
//           : null,
//       attrs: json['attrs'],
//     );
//   }

//   toJson() {}
// }
