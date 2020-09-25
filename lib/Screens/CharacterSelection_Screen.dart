import 'package:betrayalcompanionapp/GameLogic/Character.dart';
import 'package:betrayalcompanionapp/GameLogic/GlobalMethods.dart';
import 'package:betrayalcompanionapp/GlobalWidgets/Header.dart';
import 'package:betrayalcompanionapp/GlobalWidgets/Constants.dart';
import 'package:betrayalcompanionapp/Screens/CoinFlip_Screen.dart';
import 'file:///D:/Anderes/Projekte/betrayal_companion_app/lib/Screens/Game_Screen.dart';
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
                Divider(),
                Expanded(
                  child: PageView(
                    controller: controller,
                    children: Logic.characters.map((player) => CreateCharacterPage(player)).toList()
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
          Text("Age: " + character.age.toString(), style: characterStatsTextStyle),
          RaisedButton(
            child: Text("Select", style: TextStyle(fontSize: 24, color: Colors.black)),
            onPressed: () {
              Logic.players.add(character);

              setState(() {
                Logic.RemoveCharacterPairFromList(character.color);
                controller = PageController(initialPage: 0);
              });

              if(playerCount == 2 && Logic.players.length == 2){
                //Two-Player mode: Redirect to Coinflip to determine who plays as two characters
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CoinFlip()));
              }
              else if(Logic.players.length >= playerCount) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Game()));
//                Logic.CreateAlertDialog(context);
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
