// models/news.dart
class News {
  final int id;
  final String title;
  final List<ContentBlock> contentBlocks;

  News(  {required this.id, required this.title, required this.contentBlocks,}  );

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      contentBlocks: (json['contentBlocks'] as List<dynamic>)
          .map((json) => ContentBlock.fromJson(json))
          .toList(),
    );
  }
}

class ContentBlock {
  final String type;
  final String content;

  ContentBlock({required this.type, required this.content});

  factory ContentBlock.fromJson(Map<String, dynamic> json) {
    return ContentBlock(
      type: json['type'],
      content: json['content'],
    );
  }
}
