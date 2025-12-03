import 'package:flutter/material.dart';
import '../models/anime_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimeDetailPage extends StatelessWidget {
  final AnimeModel anime;
  const AnimeDetailPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(anime.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  anime.imageUrl,
                  height: 240,
                  fit: BoxFit.cover,
                  errorBuilder: (c,e,s)=>Container(
                    height:240,
                    color:Colors.grey[800],
                    child: const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              anime.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(anime.synopsis ?? 'Sem descrição disponível.', style: const TextStyle(height: 1.5)),
            const SizedBox(height: 20),
            if (anime.url != null)
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final uri = Uri.tryParse(anime.url!);
                    if (uri != null) {
                      // tenta abrir no navegador
                      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Não foi possível abrir o link')));
                      }
                    }
                  },
                  child: const Text('Abrir no site'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
