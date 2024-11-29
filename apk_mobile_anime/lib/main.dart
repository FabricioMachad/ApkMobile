import 'package:flutter/material.dart';

import 'AnimeSeasonScreen.dart';
import "SavedAnimeScreen.dart";

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Animes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // Botão para animes salvos
          IconButton(
            icon: Icon(Icons.bookmark),
            tooltip: "Animes Salvos",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedAnimesScreen()),
              );
            },
          ),
        ],
      ),
      body: AnimeSeasonScreen(), // Exibe diretamente a tela de lançamentos
    );
  }
}

// Função main que inicializa o aplicativo
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),  // Define a tela inicial como a MainScreen
    ),
  );
}
