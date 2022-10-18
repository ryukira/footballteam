// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/team_models.dart';
import 'detail_screen.dart';
import 'home_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var database;

  List<Team> teams = <Team>[];

  Future initDb() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'fav_team.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE teams(idTeam TEXT PRIMARY KEY, strTeamBadge TEXT, strTeam TEXT, intFormedYear TEXT, strStadium TEXT, strDescriptionEN TEXT)",
        );
      },
      version: 1,
    );

    getTeams().then((value) {
      setState(() {
        teams = value;
      });
    });
  }

  Future<List<Team>> getTeams() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('teams');

    return List.generate(maps.length, (i) {
      return Team(
        idTeam: maps[i]['idTeam'],
        strTeamBadge: maps[i]['strTeamBadge'],
        strTeam: maps[i]['strTeam'],
        intFormedYear: maps[i]['intFormedYear'],
        strStadium: maps[i]['strStadium'],
        strDescriptionEN: maps[i]['strDescriptionEN'],
      );
    });

    //prin
  }

  Future<void> deleteTeam(String idTeam) async {
    final db = await database;
    await db.delete(
      'teams',
      where: "idTeam = ?",
      whereArgs: [idTeam],
    );
  }

  @override
  void initState() {
    super.initState();

    initDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Favorite Teams',
                    style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.home),
                    iconSize: 26.0,
                    color: Colors.white,
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      ),
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: teams.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(teams[index])),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(6.0),
                          height: 70.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 2.0),
                            ],
                          ),
                          child: ListTile(
                            leading: Image.network(teams[index].strTeamBadge),
                            title: Text(
                              teams[index].strTeam,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(teams[index].strStadium),
                            trailing: IconButton(
                              // ignore: deprecated_member_use
                              icon: const Icon(FontAwesomeIcons.trashAlt),
                              color: Colors.grey,
                              iconSize: 22.0,
                              onPressed: () {
                                deleteTeam(teams[index].idTeam).then((value) {
                                  getTeams().then((value) {
                                    setState(() {
                                      teams = value;
                                    });
                                  });
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Remove from Favorite"),
                                ));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
