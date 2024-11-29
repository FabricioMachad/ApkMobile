import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimeDetailScreen extends StatefulWidget {
  final Map<String, dynamic> anime;

  AnimeDetailScreen({required this.anime});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<AnimeDetailScreen> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAnimes = prefs.getStringList('savedAnimes') ?? [];
    setState(() {
      isSaved = savedAnimes.contains(jsonEncode(widget.anime));
    });
  }

  Future<void> _toggleSaveAnime() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAnimes = prefs.getStringList('savedAnimes') ?? [];

    setState(() {
      if (isSaved) {
        savedAnimes.remove(jsonEncode(widget.anime));
        isSaved = false;
      } else {
        savedAnimes.add(jsonEncode(widget.anime));
        isSaved = true;
      }
    });

    await prefs.setStringList('savedAnimes', savedAnimes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.anime['title']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do anime
            Center(
              child: Image.network(
                widget.anime['images']['jpg']['large_image_url'],
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Título
            Text(
              widget.anime['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Sinopse
            Text(
              "Sinopse:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.anime['synopsis'] ?? 'Sinopse não disponível',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Gêneros
            Text(
              "Gêneros:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.anime['genres'] != null
                  ? widget.anime['genres']
                      .map((genre) => genre['name'])
                      .join(', ')
                  : 'Não disponível',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Episódios
            Text(
              "Episódios:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.anime['episodes']?.toString() ?? 'Não disponível',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Pontuação
            Text(
              "Pontuação:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.anime['score']?.toString() ?? 'Sem pontuação',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Classificação Indicativa
            Text(
              "Classificação:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.anime['rating'] ?? 'Não disponível',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Estúdios
            Text(
              "Estúdio:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.anime['studios'] != null && widget.anime['studios'].isNotEmpty
                  ? widget.anime['studios'][0]['name']
                  : 'Não disponível',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Botão para salvar
            ElevatedButton.icon(
              onPressed: _toggleSaveAnime,
              icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
              label: Text(isSaved ? "Remover dos Salvos" : "Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
