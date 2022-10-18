class Team {
  String idTeam;
  String strTeamBadge;
  String strTeam;
  String intFormedYear;
  String strStadium;
  String strDescriptionEN;

  Team(
      {required this.idTeam,
      required this.strTeamBadge,
      required this.strTeam,
      required this.intFormedYear,
      required this.strStadium,
      required this.strDescriptionEN});

  Map<String, dynamic> toMap() {
    return {
      'idTeam': idTeam,
      'strTeamBadge': strTeamBadge,
      'strTeam': strTeam,
      'intFormedYear': intFormedYear,
      'strStadium': strStadium,
      'strDescriptionEN': strDescriptionEN
    };
  }
}
