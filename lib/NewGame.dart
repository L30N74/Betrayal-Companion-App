import 'package:flutter/material.dart';

String selectedPlayerCount;

class NewGame extends StatelessWidget {
  static const String _title = "Betrayal Companion App";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
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
  String dropdownValue = "2 Spieler";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.grey),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                  selectedPlayerCount = newValue;
                });
              },
              items: <String>["2 Spieler", "3 Spieler", "4 Spieler", "5 Spieler", "6 Spieler" ]
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 26),));
              }).toList(),
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text("Confirm", style: TextStyle(fontSize: 30)),
                  onPressed: CreateGame,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

void CreateGame() {
  int playerCount = int.parse(selectedPlayerCount.split(" ")[0]);


}