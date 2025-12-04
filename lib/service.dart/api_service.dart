import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime_model.dart';

class ApiService {
  // Base URL: usando Jikan (exemplo público)
  static const String baseUrl = 'https://api.jikan.moe/v4';

  // Busca top anime (pode adaptar para endpoint de "news" se encontrar um)
  static Future<List<AnimeModel>> fetchTopAnime({int page = 1}) async {
    final uri = Uri.parse('$baseUrl/top/anime?page=$page');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      final List<dynamic> data = decoded['data'] ?? [];

      return data.map((item) => AnimeModel.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Erro ao buscar dados: ${response.statusCode}');
    }
  }
}
