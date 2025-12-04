import 'package:anime_news/service.dart/api_service.dart';
import 'package:flutter/material.dart';
import '../models/anime_model.dart';
import 'anime_datail_page.dart';


class AnimeNewsPage extends StatefulWidget {
  const AnimeNewsPage({super.key});

  @override
  State<AnimeNewsPage> createState() => _AnimeNewsPageState();
}

class _AnimeNewsPageState extends State<AnimeNewsPage> {
  late Future<List<AnimeModel>> _futureAnimes;

  @override
  void initState() {
    super.initState();
    _futureAnimes = ApiService.fetchTopAnime();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureAnimes = ApiService.fetchTopAnime();
    });
    await _futureAnimes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime News'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<AnimeModel>>(
          future: _futureAnimes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView( // mantém pull-to-refresh funcionando enquanto carrega
                children: const [
                  SizedBox(height: 300),
                  Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (snapshot.hasError) {
              return ListView(
                children: [
                  const SizedBox(height: 80),
                  Center(
                    child: Text(
                      'Erro: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _refresh,
                      child: const Text('Tentar novamente'),
                    ),
                  ),
                ],
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 80),
                  Center(child: Text('Nenhuma notícia encontrada')),
                ],
              );
            }

            final animes = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: animes.length,
              itemBuilder: (context, index) {
                final anime = animes[index];
                return _buildNewsCard(context, anime);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, AnimeModel anime) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF16263F),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 8, offset: const Offset(0,4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.network(
              anime.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => Container(
                height: 180,
                color: Colors.grey[800],
                child: const Center(child: Icon(Icons.broken_image)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                anime.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                anime.synopsis ?? 'Sem descrição disponível.',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[300], height: 1.3),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => AnimeDetailPage(anime: anime)));
                    },
                    child: const Text('Ler mais'),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
