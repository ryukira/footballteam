// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/team_models.dart';

class DetailScreen extends StatefulWidget {
  final Team team;
  const DetailScreen(this.team, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var database;

  @override
  void initState() {
    super.initState();

    initDb();
  }

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
  }

  Future<void> insertTeam(Team team) async {
    final Database db = await database;
    await db.insert(
      'teams',
      team.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(100.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(100.0),
                    ),
                    child: Container(color: Theme.of(context).primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 25.0,
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.star_half),
                            iconSize: 25.0,
                            color: Colors.white,
                            onPressed: () => {
                              insertTeam(widget.team),
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Added to Favorite"),
                              )),
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                    bottom: 60.0,
                    left: 55.0,
                    child: SizedBox(
                      height: 250.0,
                      width: 250.0,
                      child: Image(
                        image: NetworkImage(widget.team.strTeamBadge),
                      ),
                    )),
                Positioned(
                  bottom: 20.0,
                  left: 20.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.team.strTeam,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.mapMarked,
                            size: 15.0,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            widget.team.strStadium,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 5.0, 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0, 12.0),
                          child: Container(
                            width: 160.0,
                            height: 35.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Team Overview',
                              style: TextStyle(
                                fontSize: 23.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          widget.team.strDescriptionEN,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
