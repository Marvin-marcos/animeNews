import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/article.dart';
import 'detail_screen.dart';


class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});


@override
State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
late Future<List<Article>> _future;


@override
void initState() {
super.initState();
_future = ApiService.fetchNews();
}


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('animeNews')),
body: FutureBuilder<List<Article>>(
future: _future,
builder: (context, snap) {
if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
if (snap.hasError) return Center(child: Text('Erro: ${snap.error}'));
final articles = snap.data ?? [];
return ListView.builder(
itemCount: articles.length,
itemBuilder: (ctx, i) {
final a = articles[i];
return ListTile(
leading: a.imageUrl.isNotEmpty ? Image.network(a.imageUrl, width: 80, fit: BoxFit.cover) : null,
title: Text(a.title),
subtitle: Text(a.summary, maxLines: 2, overflow: TextOverflow.ellipsis),
onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailScreen(article: a))),
);
},
);
},
),
);
}
}