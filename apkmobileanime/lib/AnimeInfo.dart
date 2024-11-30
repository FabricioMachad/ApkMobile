import 'package:flutter/material.dart';

import 'database_helper.dart';

class Animeinfo extends StatefulWidget {
  final Map<String, dynamic> anime;

  Animeinfo({required this.anime});

  @override
  _Animeinfo createState() => _Animeinfo();
}

class _Animeinfo extends State<Animeinfo> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  // Verifica se o anime está salvo no banco de dados
  Future<void> _checkIfSaved() async {
    final savedAnimes = await _dbHelper.getSavedAnimes();
    setState(() {
      isSaved = savedAnimes.any((anime) => anime['animeId'] == widget.anime['mal_id']);
    });
  }

  Future<void> _toggleSaveAnime() async {
    if (isSaved) {
      await _dbHelper.deleteAnime(widget.anime['mal_id']);
    } else {
      await _dbHelper.saveAnime(widget.anime);
    }
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text(
          widget.anime['title'],
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do anime
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.anime['images']['jpg']['large_image_url'],
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Título
            Text(
              widget.anime['title'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texto branco
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Sinopse
            Text(
              "Sinopse:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texto branco
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.anime['synopsis'] ?? 'Sinopse não disponível',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            // Gêneros
            Text(
              "Gêneros:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texto branco
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.anime['genres'] != null
                  ? widget.anime['genres']
                      .map((genre) => genre['name'])
                      .join(', ')
                  : 'Não disponível',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            // Episódios
            Text(
              "Episódios:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texto branco
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.anime['episodes']?.toString() ?? 'Não disponível',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            // Pontuação
            Text(
              "Qualificação:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texto branco
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.anime['score']?.toString() ?? 'Sem pontuação',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            // Botão para salvar
            ElevatedButton.icon(
              onPressed: _toggleSaveAnime,
              icon: Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: Colors.white, // Cor do ícone branco
              ),
              label: Text(
                isSaved ? "Remover dos Salvos" : "Salvar",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
