import 'package:betrayalcompanionapp/GameLogic/Player.dart';
import 'package:betrayalcompanionapp/Globals/Header.dart';
import 'package:betrayalcompanionapp/Globals/Globals.dart';
import 'package:betrayalcompanionapp/Globals/NavBar.dart';
import 'package:betrayalcompanionapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CharacterSelection_Screen extends StatefulWidget {
  int playerCount;

  CharacterSelection_Screen(this.playerCount);

  @override
  _CharacterSelection_ScreenState createState() => _CharacterSelection_ScreenState(playerCount);
}

class _CharacterSelection_ScreenState extends State<CharacterSelection_Screen> {
  int playerCount;
  _CharacterSelection_ScreenState(this.playerCount);

  List<Player> characters_copy = MainPage.characters;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover
              ),
            ),
            child: DefaultTabController(
              length: characters_copy.length,
              child: Column(
                children: [
                  Header("CHARACTER SELECTION"),
                  SizedBox(height: 10),
                  Container(
                    height: 650,
                    child: TabBarView(
                      children: characters_copy.map((player) => CreateCharacterPage(player)).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container CreateCharacterPage(Player player) {
    var nameSplits = player.name.split(' ');
    String imagePath = "assets/images/" + nameSplits[nameSplits.length-1]  + ".png";

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Image(image: AssetImage(imagePath), height: 200, width: 200),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CreateStatField("Might", player.stats.speed, player.stats.speedDefaultIndex),
              CreateStatField("Speed", player.stats.might, player.stats.mightDefaultIndex),
              CreateStatField("Knowledge", player.stats.knowledge, player.stats.knowledgeDefaultIndex),
              CreateStatField("Sanity", player.stats.sanity, player.stats.sanityDefaultIndex)
            ],
          ),
          SizedBox(height: 10),
          Text(player.name, style: characterStatsTextStyle,),
          Text("Hobbies: " + player.hobbies, style: characterStatsTextStyle,),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Birthday: " + player.birthday.day.toString() + "." + player.birthday.month.toString(),
                  style: characterStatsTextStyle),
              Text("Weight: " + player.weight.toString() +  "lbs",
                  style: characterStatsTextStyle),
            ],
          ),
          SizedBox(height: 20),
          Text("Age: " + player.age.toString(), style: characterStatsTextStyle),
          SizedBox(height: 20),
          RaisedButton(
            child: Text("Pick", style: TextStyle(fontSize: 24, color: Colors.black)),
            onPressed: () {
              // TODO: Implement picking of characters
            })
        ],
      ),
    );
  }

  CreateStatField(String statName, List<int> list, int statDefaultIndex) {
    return Column(
      children: [
        Text(statName, style: TextStyle(fontSize: 16, color: Colors.white)),
        Container(
          height: 180,
          width: 50,
          child: Column(
            children: CreateStatNumbers(list, statDefaultIndex).toList(),
          ),
        )
      ],
    );
  }

  List<Text> CreateStatNumbers(List<int> list, int statDefaultIndex){
    var statFields = <Text>[];

    for(int i = 0; i < list.length; i++) {
      Color color = (i == statDefaultIndex) ? Color(0xff57C138) : Colors.white;
      statFields.add(new Text(list[i].toString(), style: TextStyle(color: color, fontSize: 16, height: 1.4)));
    }

    return statFields;
  }
}
