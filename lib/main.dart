import 'package:flutter/material.dart';

import 'NewGame.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = "Betrayal Companion App";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: MyHomeMenuWidget(),
      ),
    );
  }
}

class MyHomeMenuWidget extends StatelessWidget {
  MyHomeMenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('MAIN MENU', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
          RaisedButton(
            child: Text('Start new Game', style: TextStyle(fontSize: 20)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewGame()));
            },
          ),
          const RaisedButton(
            child: Text('Current Game', style: TextStyle(fontSize: 20)),
            onPressed: null
          ),
        ],
      ),
    );
  }
}
