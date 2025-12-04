class Article {
final String id;
final String title;
final String summary;
final String imageUrl;
final String url;
final DateTime publishedAt;


Article({
required this.id,
required this.title,
required this.summary,
required this.imageUrl,
required this.url,
required this.publishedAt,
});


factory Article.fromJson(Map<String, dynamic> json) => Article(
id: json['id']?.toString() ?? json['url'],
title: json['title'] ?? '',
summary: json['summary'] ?? '',
imageUrl: json['imageUrl'] ?? '',
url: json['url'] ?? '',
publishedAt: DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
);
}