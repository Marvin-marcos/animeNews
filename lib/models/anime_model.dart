class AnimeModel {
  final int malId;
  final String title;
  final String? synopsis;
  final String imageUrl;
  final String? url;

  AnimeModel({
    required this.malId,
    required this.title,
    required this.imageUrl,
    this.synopsis,
    this.url,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    // Estrutura baseada no retorno de: https://api.jikan.moe/v4/top/anime
    return AnimeModel(
      malId: json['mal_id'] ?? 0,
      title: json['title'] ?? 'Sem título',
      synopsis: json['synopsis'],
      imageUrl: (json['images']?['jpg']?['image_url'] ??
          json['image_url'] ??
          'https://via.placeholder.com/300x180.png?text=No+Image'),
      url: json['url'],
    );
  }
}
