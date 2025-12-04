import 'dart:convert';
import '../models/article.dart';


class ApiService {
static const _base = 'https://api.example.com/anime';

  static get http => null; // substitua


static Future<List<Article>> fetchNews() async {
final res = await http.get(Uri.parse('$_base/news'));
if (res.statusCode == 200) {
final data = json.decode(res.body) as List;
return data.map((e) => Article.fromJson(e)).toList();
} else {
throw Exception('Erro ao buscar notícias: ${res.statusCode}');
}
}
}