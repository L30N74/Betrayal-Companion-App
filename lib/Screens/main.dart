import 'package:betrayalcompanionapp/Screens/Game_Screen.dart';
import 'package:flutter/material.dart';
import 'package:betrayalcompanionapp/GameLogic/GlobalMethods.dart';
import 'package:betrayalcompanionapp/GlobalWidgets/Header.dart';
import 'package:betrayalcompanionapp/Screens/NewGame_Screen.dart';
import 'package:betrayalcompanionapp/GameLogic/HauntInformation.dart';

void main() => runApp(MainPage());


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Logic.revealedHauntInformation = new HauntInformation();

    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Color.fromRGBO(128, 128, 128, 100),
          body: HomeMenu(context, "Betrayal Companion App"),
        ),
      ),
    );
  }

  Widget HomeMenu(context, String title){
    return SafeArea(
      child: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: <Widget>[
              Header(title),
              Divider(),
              Column(
                children: [
                  Divider(),
                  RaisedButton(
                    child: Text(
                      "Start New Game",
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: 'Shadows',
                        fontWeight: FontWeight.bold
                      )
                    ),
                    onPressed: () {
                      if(Logic.players.length > 0)
                        Logic.CreateNewGameConfirmationAlert(context);
                      else {
                        StartNewGame(context);
                      }
                    },
                    elevation: 10,
                  ),
                  Divider(),
                  RaisedButton(
                    child: Text(
                      Logic.players.length == 0 ? "No Game yet" : "Current Game",
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: 'Shadows',
                        fontWeight: FontWeight.bold,
                        color: Logic.players.length == 0 ? Colors.white : Colors.black
                      )
                    ),
                    onPressed: Logic.players.length == 0 ? null : () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Game()));
                    },
                    elevation: 10,
                  ),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }

  static void StartNewGame(context) {
    Logic.InitializeCharacterLists();

    Logic.startingPlayerDetermined = false;

    Navigator.push(context, MaterialPageRoute(builder: (context) => NewGame_Screen()));
  }
}