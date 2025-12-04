import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/article.dart';

class DetailScreen extends StatefulWidget {
  final Article article;
  const DetailScreen({required this.article, super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // 👉 ID LOCAL (substitui FirebaseAuth.instance.currentUser)
  final String _userId = "user_demo"; // você pode trocar isso depois

  bool _isFav = false;

  @override
  void initState() {
    super.initState();
    _loadFav();
  }

  Future<void> _loadFav() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_userId)
        .get();

    final favs = List<String>.from(doc.data()?['favorites'] ?? []);

    setState(() => _isFav = favs.contains(widget.article.id));
  }

  Future<void> _toggleFav() async {
    final ref =
        FirebaseFirestore.instance.collection('users').doc(_userId);

    await FirebaseFirestore.instance.runTransaction((tx) async {
      final snap = await tx.get(ref);
      final favs = List<String>.from(snap.data()?['favorites'] ?? []);

      if (favs.contains(widget.article.id)) {
        favs.remove(widget.article.id);
      } else {
        favs.add(widget.article.id);
      }

      tx.set(ref, {'favorites': favs}, SetOptions(merge: true));
    });

    setState(() => _isFav = !_isFav);
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.article;

    return Scaffold(
      appBar: AppBar(
        title: Text(a.title),
        actions: [
          IconButton(
            icon: Icon(
              _isFav ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: _toggleFav,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (a.imageUrl != null)
              Image.network(a.imageUrl!),
            const SizedBox(height: 16),
            Text(
              a.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text("texto"),
          ],
        ),
      ),
    );
  }
}
