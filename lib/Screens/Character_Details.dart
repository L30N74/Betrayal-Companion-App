import 'dart:ffi';

import 'package:betrayalcompanionapp/GameLogic/Character.dart';
import 'package:betrayalcompanionapp/GlobalWidgets/Constants.dart';
import 'package:betrayalcompanionapp/GlobalWidgets/Header.dart';
import 'package:betrayalcompanionapp/Screens/Game_Screen.dart';
import 'package:flutter/material.dart';

class CharacterDetails extends StatefulWidget {
  Character character;

  CharacterDetails(this.character);

  @override
  _CharacterDetailsState createState() => _CharacterDetailsState(character);
}

class _CharacterDetailsState extends State<CharacterDetails> {
  Character character;

  _CharacterDetailsState(this.character);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
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
                Header("Who Am I"),
                Stack(
                  children: [
                    Image(image: AssetImage(character.imagePath), height: 150, width: 150),
                    if(character.isDead) Image(image: AssetImage("assets/images/dead_border.png"), height: 150, width: 150,),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      StatsBox(),
                      InformationBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container InformationBox() {
    return Container(
      child: Column(
        children: [
          Text(character.name, style: characterStatsTextStyle),
          Text("Hobbies: " + character.hobbies, style: characterStatsTextStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Birthday: " + character.birthday.day.toString() + "." + character.birthday.month.toString(), style: characterStatsTextStyle,),
              Text("Age: " + character.age.toString(), style: characterStatsTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Height: " + character.height.toString(), style: characterStatsTextStyle),
              Text("Weight: " + character.weight.toString() + "lbs", style: characterStatsTextStyle,),
            ],
          ),
          SizedBox(height: 30,),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              height: 60,
              width: 200,
              child: RaisedButton(
                child: Text("Take me back", style: TextStyle(),),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Game())),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container StatsBox() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    child: Text(
                      "Might",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                  ),
                  Container(
                    child: GetStatButtonRow("Might"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                      width: 60,
                      child: Text(
                        "Speed",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                  ),
                  Container(
                    child: GetStatButtonRow("Speed"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                      width: 60,
                      child: Text(
                        "Sanity",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                  ),
                  Container(
                    child: GetStatButtonRow("Sanity"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                      width: 60,
                      child: Text(
                        "Knowledge",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                  ),
                  Container(
                    child: GetStatButtonRow("Knowledge"),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: RaisedButton(
                  child: Text("Reset", style: TextStyle(),),
                  onPressed: () {
                    setState(() {
                      character.Reset();
                    });
                  },
                ),
              ),
              SizedBox(width: 30,),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: RaisedButton(
                  child: Text("Revive", style: TextStyle(),),
                  onPressed: () {
                    setState(() {
                      character.isDead = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row GetStatButtonRow(String statListString) {
    List<int> list;
    int defaultIndex = 0;

    switch(statListString){
      case "Might":
        list = character.stats.might;
        defaultIndex = character.stats.mightDefaultIndex;
        break;
      case "Speed":
        list = character.stats.speed;
        defaultIndex = character.stats.speedDefaultIndex;
        break;
      case "Sanity":
        list = character.stats.sanity;
        defaultIndex = character.stats.sanityDefaultIndex;
        break;
      case "Knowledge":
        list = character.stats.knowledge;
        defaultIndex = character.stats.knowledgeDefaultIndex;
        break;
    }

    Map statMap = list.asMap();

    List<Container> buttons = new List<Container>();
    buttons.add(Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 30,
      height: 40,
      decoration: (character.isDead)
          ? BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey.withOpacity(0.9)),
      )
          : BoxDecoration(
          border: null
      ),
      child: IconButton(
        padding: EdgeInsets.all(0),
        icon: Icon(
          Icons.close,
          size: 16,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            character.DieFromStat(statListString);
          });
        },
      ),
    ));

    statMap.forEach((key, value) {
      Color color = (key == defaultIndex) ? Color(0xff57C138) : Colors.white;
      buttons.add(Container(
        margin: EdgeInsets.only(bottom: 10),
        width: 30,
        height: 40,
        decoration: (character.stats.IsCurrentIndex(statListString, key) && !character.isDead)
            ? BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey.withOpacity(0.9)),
        )
            : BoxDecoration(
          border: null
        ),
        child: MaterialButton(
          child: Text(value.toString(), style: TextStyle(fontSize: 16, color: color,), textAlign: TextAlign.center,),
          onPressed: () {
            setState(() {
              character.stats.SetStatIndex(statListString, key);
            });
          },
        ),
      ));
    });

    return Row(
      children: buttons,
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
