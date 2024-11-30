import 'package:flutter/material.dart';

import 'database_helper.dart';

class Animeacompanhando extends StatefulWidget {
  @override
  _Animeacompanhando createState() => _Animeacompanhando();
}

class _Animeacompanhando extends State<Animeacompanhando> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> savedAnimes = [];

  @override
  void initState() {
    super.initState();
    _loadSavedAnimes();
  }

  Future<void> _loadSavedAnimes() async {
    final animes = await _dbHelper.getSavedAnimes();
    setState(() {
      savedAnimes = animes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animes Salvos"),
      ),
      body: savedAnimes.isEmpty
          ? Center(child: Text("Nenhum anime salvo"))
          : ListView.builder(
              itemCount: savedAnimes.length,
              itemBuilder: (context, index) {
                final anime = savedAnimes[index];
                return ListTile(
                  leading: Image.network(anime['imageUrl']),
                  title: Text(anime['title']),
                  subtitle: Text(anime['synopsis']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await _dbHelper.deleteAnime(anime['animeId']);
                      _loadSavedAnimes();
                    },
                  ),
                );
              },
            ),
    );
  }
}
