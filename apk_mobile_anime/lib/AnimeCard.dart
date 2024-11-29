import 'package:flutter/material.dart';

import 'AnimeDetailScreen.dart';

class AnimeCard extends StatelessWidget {
  final Map<String, dynamic> anime;

  const AnimeCard({required this.anime});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimeDetailScreen(anime: anime),
          ),
        );
      },
      child: Card(
        color: Colors.grey[850], // Fundo do card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.redAccent, width: 2), // Borda destacada
        ),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                anime['images']['jpg']['large_image_url'],
                width: double.infinity,   // Largura total do card
                height: 200,              // Altura da imagem
                fit: BoxFit.cover,        // Ajuste a imagem sem distorção
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                anime['title'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Texto branco
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
