import 'package:betrayalcompanionapp/GameLogic/Player.dart';
import 'package:betrayalcompanionapp/Globals/Header.dart';
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
      home: SafeArea(
        child: DefaultTabController(
          length: characters_copy.length,
          child: Scaffold(
            backgroundColor: Color(0xff5B5B5B),
            body:
              Column(
                children: [
                  Header("CHARACTER SELECTION"),
                  SizedBox(height: 10),
                  Container(
                    height: 400,
                    child: TabBarView(
                      children: characters_copy.map((player) => CreateCharacterPage(player)).toList(),
                    ),
                  ),
                ]
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
      color: Color(0xff5B5B5B),
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
          SizedBox(height: 50),
          Text("Hobbies: " + player.hobbies, style: TextStyle(color: Colors.white, fontSize: 20),),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Birthday: " + player.birthday.month.toString() + " " + player.birthday.day.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              Text("Weight: " + player.weight.toString() +  "lbs",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
          SizedBox(height: 20),
          Text("Age: " + player.age.toString(), style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }

  CreateStatField(String statName, List<int> list, int statDefaultIndex) {
    return Column(
      children: [
        Text(statName, style: TextStyle(fontSize: 16, color: Colors.white)),
        Column(
          children: []//CreateStatNumbers(list, statDefaultIndex),
        )
      ],
    );
  }

  CreateStatNumbers(List<int> list, int statDefaultIndex){
    var statFields = <TextField>[];
    var textEditingControllers = <TextEditingController>[];

    for(int i = 0; i < list.length; i++) {
      var textEditingController = new TextEditingController(text: list[i].toString());
      textEditingControllers.add(textEditingController);
      Color color = (i == statDefaultIndex) ? Color.fromRGBO(96,217,104, 100) : Colors.white;
      statFields.add(new TextField(controller: textEditingController, style: TextStyle(color: color, fontSize: 16)));
    }

    return statFields;
  }
}
