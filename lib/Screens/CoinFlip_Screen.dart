import 'dart:math';

import 'package:betrayalcompanionapp/GlobalWidgets/Header.dart';
import 'package:betrayalcompanionapp/Screens/CharacterSelection_Screen.dart';
import 'package:betrayalcompanionapp/Screens/Game_Screen.dart';
import 'package:betrayalcompanionapp/GameLogic/GlobalMethods.dart';
import 'package:flutter/material.dart';
import 'package:betrayalcompanionapp/GlobalWidgets/Constants.dart';

class CoinFlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CoinFlipWidget(),
      ),
    );
  }
}

class CoinFlipWidget extends StatefulWidget {
  @override
  _CoinFlipWidgetState createState() => _CoinFlipWidgetState();
}

class _CoinFlipWidgetState extends State<CoinFlipWidget> {
  List<String> choices = ["Heads", "Tails"];
  String playerOneChoice = "Heads";
  String playerTwoChoice = "Tails";
  String result = "Heads";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover
              ),
            ),
            child: Column(
              children: [
                Header("FLIP A COIN"),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Determine which player plays as two",
                    style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.underline),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      CoinContainer(),
                      SizedBox(height: 30,),
                      PlayerChoicesContainer(),
                      RaisedButton(
                        child: Text("Flip", style: TextStyle(fontSize: 26, color: Colors.black),),
                        onPressed: () {
                          setState(() {
                            FlipCoin();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      )
    );
  }

  void FlipCoin() {
    Random random = new Random();
    int randNumber = random.nextInt(100);

    result = (randNumber %2 == 0) ? "Heads" : "Tails";

    CreateResultDialog(playerOneChoice == result ? 1 : 2);
  }

  Container CoinContainer() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            child: (result == "Heads") ? Image(image: AssetImage("assets/images/coin_heads.png"),) : Image(image: AssetImage("assets/images/coin_tails.png"),),
          )
        ],
      ),
    );
  }

  Container PlayerChoicesContainer() {
    return Container(
      width: 300,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Row(
              children: [
                Text("Player 1: ", style: TextStyle(fontSize: 24, color: Colors.white),),
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: darkGreyColor,
                  ),
                  child: DropdownButton(
                    value: playerOneChoice,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    onChanged: (String newChoice) {
                      setState(() {
                        playerOneChoice = newChoice;
                        //Reverse what player one has
                        if(newChoice == "Heads") {
                          playerTwoChoice = "Tails";
                        }
                        else {
                          playerTwoChoice = "Heads";
                        }
                      });
                    },
                    items: choices.map<DropdownMenuItem<String>>((choice) => DropdownMenuItem<String>(
                      value: choice,
                      child: Text(
                        choice,
                        style: coinflipChoiceTextStyle,
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text("Player 2: ", style: TextStyle(fontSize: 24, color: Colors.white),),
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: darkGreyColor,
                  ),
                  child: DropdownButton(
                    value: playerTwoChoice,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white,),
                    onChanged: (String newChoice) {
                      setState(() {
                        playerTwoChoice = newChoice;
                        //Reverse what player one has
                        if(newChoice == "Heads") {
                          playerOneChoice = "Tails";
                        }
                        else {
                          playerOneChoice = "Heads";
                        }
                      });
                    },
                    items: choices.map<DropdownMenuItem<String>>((choice) => DropdownMenuItem<String>(
                      value: choice,
                      child: Text(
                        choice,
                        style: coinflipChoiceTextStyle,
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CreateResultDialog(int number) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Result", style: TextStyle(fontSize: 16, color: Colors.black), textAlign: TextAlign.center,),
          content: Container(
            height: 250,
            child: Column(
              children: [
                Text(
                  "Player #$number gets to play two characters.",
                  style: TextStyle(fontSize: 28, decoration: TextDecoration.underline),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  child: Text("Give me a random Character", style: coinflipButtonTextStyle,),
                  onPressed: () {
                    Logic.RandomizePlayers(1);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Game()));
                  },
                ),
                SizedBox(height: 30,),
                RaisedButton(
                  child: Text("I want to choose myself", style: coinflipButtonTextStyle,),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CharacterSelection_Screen(1))),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

