
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedAnimesScreen extends StatefulWidget {
  @override
  _SavedAnimesScreenState createState() => _SavedAnimesScreenState();
}

class _SavedAnimesScreenState extends State<SavedAnimesScreen> {
  List<Map<String, dynamic>> savedAnimes = [];

  @override
  void initState() {
    super.initState();
    _loadSavedAnimes();
  }

  Future<void> _loadSavedAnimes() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('savedAnimes') ?? [];

    // Converte os itens salvos para o tipo correto
    setState(() {
      savedAnimes = saved.map((anime) => Map<String, dynamic>.from(jsonDecode(anime))).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animes Salvos"),
      ),
      body: savedAnimes.isEmpty
          ? Center(child: Text("Nenhum anime salvo!"))
          : ListView.builder(
              itemCount: savedAnimes.length,
              itemBuilder: (context, index) {
                final anime = savedAnimes[index];
                return ListTile(
                  leading: Image.network(anime['images']['jpg']['image_url']),
                  title: Text(anime['title']),
                  subtitle: Text(anime['type'] ?? ""),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final saved = prefs.getStringList('savedAnimes') ?? [];
                      saved.remove(jsonEncode(anime));
                      await prefs.setStringList('savedAnimes', saved);
                      _loadSavedAnimes();
                    },
                  ),
                );
              },
            ),
    );
  }
}
