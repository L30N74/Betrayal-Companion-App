import 'package:betrayalcompanionapp/GameLogic/Character.dart';
import 'package:betrayalcompanionapp/Globals/Header.dart';
import 'package:betrayalcompanionapp/Globals/Globals.dart';
import 'file:///D:/Anderes/Projekte/betrayal_companion_app/lib/Screens/Game_Screen.dart';
import 'package:betrayalcompanionapp/Screens/main.dart';
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
  var controller = PageController(initialPage: 0);

  _CharacterSelection_ScreenState(this.playerCount);

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
            child: Column(
              children: [
                Header("CHARACTER SELECTION"),
                SizedBox(height: 10),
                Expanded(
                  child: PageView(
                    controller: controller,
                    children: MainPage.characters.map((player) => CreateCharacterPage(player)).toList()
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container CreateCharacterPage(Character character) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Image(image: AssetImage(character.imagePath), height: 200, width: 200),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CreateStatField("Might", character.stats.speed, character.stats.speedDefaultIndex),
              CreateStatField("Speed", character.stats.might, character.stats.mightDefaultIndex),
              CreateStatField("Knowledge", character.stats.knowledge, character.stats.knowledgeDefaultIndex),
              CreateStatField("Sanity", character.stats.sanity, character.stats.sanityDefaultIndex)
            ],
          ),
          SizedBox(height: 10),
          Text(character.name, style: characterStatsTextStyle,),
          SizedBox(height: 10),
          Text("Hobbies: " + character.hobbies, style: characterStatsTextStyle,),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Birthday: " + character.birthday.day.toString() + "." + character.birthday.month.toString(),
                  style: characterStatsTextStyle),
              Text("Weight: " + character.weight.toString() +  "lbs",
                  style: characterStatsTextStyle),
            ],
          ),
          SizedBox(height: 20),
          Text("Age: " + character.age.toString(), style: characterStatsTextStyle),
          SizedBox(height: 20),
          RaisedButton(
            child: Text("Pick", style: TextStyle(fontSize: 24, color: Colors.black)),
            onPressed: () {
              MainPage.players.add(character);

              setState(() {
                MainPage.RemoveCharacterPairFromList(character.color);
                controller = PageController(initialPage: 0);
              });

              if(MainPage.players.length == playerCount) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Game()));
//                MainPage.CreateAlertDialog(context);
              }
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