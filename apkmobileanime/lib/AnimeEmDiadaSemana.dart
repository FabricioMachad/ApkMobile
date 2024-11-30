import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AnimeCard.dart';

class Animeemdiadasemana extends StatefulWidget {
  @override
  _Animeemdiadasemana createState() => _Animeemdiadasemana();
}

class _Animeemdiadasemana extends State<Animeemdiadasemana> {
  Map<String, List> animeByDay = {
    'Segunda-feira': [],
    'Terça-feira': [],
    'Quarta-feira': [],
    'Quinta-feira': [],
    'Sexta-feira': [],
    'Sábado': [],
    'Domingo': [],
    'Indefinido': [],
  };

  // Função para mapear dias da semana
  String _getLocalizedDay(String? day) {
    if (day == null || day.isEmpty) {
      return 'Indefinido';
    }
    final normalizedDay = day.toLowerCase().replaceAll(RegExp(r's$'), '');
    if (normalizedDay == 'monday') {
      return 'Segunda-feira';
    } else if (normalizedDay == 'tuesday') {
      return 'Terça-feira';
    } else if (normalizedDay == 'wednesday') {
      return 'Quarta-feira';
    } else if (normalizedDay == 'thursday') {
      return 'Quinta-feira';
    } else if (normalizedDay == 'friday') {
      return 'Sexta-feira';
    } else if (normalizedDay == 'saturday') {
      return 'Sábado';
    } else if (normalizedDay == 'sunday') {
      return 'Domingo';
    } else {
      return 'Indefinido';
    }
  }

  Future<void> fetchSeasonalAnimes() async {
    final response = await http.get(
      Uri.parse('https://api.jikan.moe/v4/seasons/now'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final animes = data['data'];

      setState(() {
        animes.forEach((anime) {
          final broadcastDay = _getLocalizedDay(anime['broadcast']?['day']);
          print("Título: ${anime['title']}");
          print("Broadcast: ${anime['broadcast']}");
          print("Dia traduzido: $broadcastDay");
          if (animeByDay.containsKey(broadcastDay)) {
            animeByDay[broadcastDay]?.add(anime);
          } else {
            animeByDay['Indefinido']?.add(anime);
          }
        });
      });
    } else {
      throw Exception('Falha ao carregar os lançamentos da temporada');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSeasonalAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lançamentos da Temporada"),
      ),
      backgroundColor: Colors.grey[900],
      body: ListView(
        children: animeByDay.entries.map((entry) {
          final day = entry.key;
          final animes = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ...animes.map((anime) {
                return AnimeCard(anime: anime);
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
