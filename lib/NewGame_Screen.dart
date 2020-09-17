import 'package:betrayalcompanionapp/CharacterSelection_Screen.dart';
import 'package:betrayalcompanionapp/Game.dart';
import 'package:betrayalcompanionapp/GameLogic/Character.dart';
import 'package:betrayalcompanionapp/Globals/Header.dart';
import 'package:betrayalcompanionapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

String selectedPlayerCount = "2 Spieler";
int playerCount = 2;


class NewGame_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(128, 128, 128, 100),
        body: NewGameWidget(),
      ),
    );
  }
}

class NewGameWidget extends StatefulWidget {
  NewGameWidget({Key key}) : super(key: key);

  @override
  NewGameWidgetState createState() => NewGameWidgetState();
}

class NewGameWidgetState extends State<NewGameWidget> {
  String dropdownValue = "2 Players";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(128, 128, 128, 100),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header("NEW GAME"),
              SizedBox(height: 30),
              Text("How many Players?", style: TextStyle(fontSize: 26)),
              SizedBox(height: 50),
              DropdownButton(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  underline: Container(
                    height: 3,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      selectedPlayerCount = newValue;
                    });
                  },
                  items: listEntries
              ),
              SizedBox(height: 50,),
              RaisedButton(
                child: Text("Randomize Players", style: TextStyle(fontSize: 40)),
                onPressed: (){
                  playerCount  = int.parse(selectedPlayerCount.split(" ")[0]);

                  RandomizePlayers();

                  // Check if 2 Players was selected
                  if(playerCount == 2){
                    // TODO: Choose a third player
                  }
                  else {
//                    MainPage.CreateAlertDialog(context);
                  }

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Game()));
                },
              ),
              RaisedButton(
                child: Text("Choose Players", style: TextStyle(fontSize: 40)),
                onPressed: (){
                  playerCount  = int.parse(selectedPlayerCount.split(" ")[0]);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterSelection_Screen(playerCount)));
                },
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}

var listEntries = ["2 Players", "3 Players", "4 Players", "5 Players", "6 Players"]
    .map<DropdownMenuItem<String>>((String value) {
  return DropdownMenuItem<String>(
      value: value,
      child: Text(value, style: TextStyle(fontSize: 26, color: Colors.black)));
}).toList();

void RandomizePlayers() {
  //Select x amount of characters
    for(int i = 0; i < playerCount; i++) {
      // Choose character
      Random rand = new Random();
      Character character = MainPage.characters[rand.nextInt(MainPage.characters.length)];
      MainPage.players.add(character);

      // Remove characters from list
      MainPage.RemoveCharacterPairFromList(character);
    }
}
