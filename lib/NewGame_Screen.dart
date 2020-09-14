import 'package:betrayalcompanionapp/CharacterSelection_Screen.dart';
import 'package:betrayalcompanionapp/Globals/Header.dart';
import 'package:betrayalcompanionapp/Globals/MyDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String selectedPlayerCount = "2 Spieler";
int playerCount = 2;


class NewGame_Screen extends StatelessWidget {
  static const String _title = "New Game";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(128, 128, 128, 100),
        drawer: MyDrawer(),
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
          alignment: Alignment.bottomCenter,
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
                child: Text("Confirm", style: TextStyle(fontSize: 40)),
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
