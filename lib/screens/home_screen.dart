import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/team_list.dart';
import 'favourite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curentTab = 0;
  int selectedIndex = 0;
  String idLeague = "";

  List<IconData> icons = [
    FontAwesomeIcons.iceCream,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.plane,
    FontAwesomeIcons.mugHot
  ];

  List<String> league = [
    "English Premiere League",
  ];

  Widget listIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          if (index == 0) {
            idLeague = "4328";
          } else if (index == 1) {
            idLeague = "4329";
          } else if (index == 2) {
            idLeague = "4335";
          } else {
            idLeague = "4331";
          }
        });
      },
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? Theme.of(context).primaryColor
              : const Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(
          icons[index],
          color: selectedIndex == index
              ? Theme.of(context).colorScheme.secondary
              : const Color(0xFFB4C1C4),
        ),
      ),
    );
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
                    'Team Info Apps',
                    style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.star),
                    iconSize: 25.0,
                    color: Colors.white,
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FavoriteScreen()),
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
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40.0,
                              //color: Theme.of(context).primaryColor,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: league.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          if (index == 0) {
                                            idLeague = "4328";
                                          } else if (index == 1) {
                                            idLeague = "4331";
                                          } else if (index == 2) {
                                            idLeague = "4332";
                                          } else {
                                            idLeague = "4335";
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Container(
                                          width: 250.0,
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: selectedIndex == index
                                                ? Theme.of(context).primaryColor
                                                : const Color(0xFFFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                league[index],
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: selectedIndex == index
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .secondary
                                                      : const Color(0xFFB4C1C4),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),

                            //listLeague(0)
                          ],
                        ),
                      ),
                      TeamList(idLeague),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
