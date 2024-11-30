import 'package:aok_mobile_anime/AnimeEmDiadaSemana.dart';
import 'package:flutter/material.dart';

import "AnimeAcompanhando.dart";

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
                MaterialPageRoute(builder: (context) => Animeacompanhando()),
              );
            },
          ),
        ],
      ),
      body: Animeemdiadasemana(),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    ),
  );
}