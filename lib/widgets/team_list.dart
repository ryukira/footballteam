import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:footballteam/models/team_models.dart';

import '../screens/detail_screen.dart';

class TeamList extends StatelessWidget {
  final String idLeague;
  const TeamList(this.idLeague, {super.key});

  Future<List<Team>> getTeam() async {
    var url = Uri.parse(
        "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=English%20Premier%20League");
    var data = await http.get(url);

    var jsonData = jsonDecode(data.body)["teams"] as List;
    final List<Team> teams = [];

    for (var t in jsonData) {
      Team team = Team(
        idTeam: t["idTeam"],
        strTeamBadge: t["strTeamBadge"],
        strTeam: t["strTeam"],
        intFormedYear: t["intFormedYear"],
        strStadium: t["strStadium"],
        strDescriptionEN: t["strDescriptionEN"],
      );
      teams.add(team);
    }
    return teams;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Team List',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 400.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: FutureBuilder(
              future: getTeam(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text("Loading..."),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(snapshot.data[index])),
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
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Image.network(
                                snapshot.data[index].strTeamBadge),
                            title: Text(
                              snapshot.data[index].strTeam,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(snapshot.data[index].strStadium),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
      ],
    );
  }
}
