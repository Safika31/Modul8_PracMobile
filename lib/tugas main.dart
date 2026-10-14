import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screen_arguments.dart';
import 'tujuan.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var title;
  var thumbnail;
  var short_description;
  var description;
  var genre;
  var platform;
  var release;
  var cover;
  var gameid;
  var publisher;

  Future getGame(String gameid) async {
    http.Response response = await http.get(
      Uri.parse(
        'https://www.freetogame.com/api/game?id=$gameid',
      ),
    );

    var results = jsonDecode(response.body);

    setState(() {
      this.gameid = gameid;
      title = results['title'];
      thumbnail = results['thumbnail'];
      short_description = results['short_description'];
      description = results['description'];
      genre = results['genre'];
      platform = results['platform'];
      publisher = results['publisher'];
      release = results['release_date'];
      cover = results['screenshots'][0]['image'];
    });
  }

  @override
  void initState() {
    super.initState();
    getGame('475');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      body: SafeArea(
        child: gameid == null
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 35),
                decoration: const BoxDecoration(
                  color: Color(0xFF0081C9),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🎮 FreeToGame',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Yuk, kenalan dengan game hari ini! ✨',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              // CARD GAME
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Tujuan.routeName,
                    arguments: ScreenArguments(
                      cover,
                      title,
                      description,
                      short_description,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(18, 25, 18, 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // GAMBAR
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          thumbnail,
                          width: double.infinity,
                          height: 190,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // JUDUL
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003047),
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        '⭐ Game pilihan untuk kamu',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0081C9),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // INFORMASI
                      Row(
                        children: [
                          Expanded(
                            child: _infoBox(
                              '🎯',
                              'Genre',
                              genre,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _infoBox(
                              '🕹️',
                              'Platform',
                              platform,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: _infoBox(
                              '🏢',
                              'Publisher',
                              publisher,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _infoBox(
                              '📅',
                              'Release',
                              release,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // TOMBOL
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 13,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0081C9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            '✨ Lihat Detail Game',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Tap kartu game untuk melihat detail 💙',
                style: TextStyle(
                  color: Color(0xFF527080),
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoBox(String emoji, String label, dynamic value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FAFF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$emoji  $label',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF527080),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '$value',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003047),
            ),
          ),
        ],
      ),
    );
  }
}
