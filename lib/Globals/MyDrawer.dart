import 'package:betrayalcompanionapp/Globals/MyNavButton.dart';
import 'package:betrayalcompanionapp/main.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget> [
          DrawerHeader(
            child: Center(
              child: Text("Navigation", style: TextStyle(fontSize: 36, decoration: TextDecoration.underline)),
            ),
            decoration: BoxDecoration(
              color: Colors.grey
            ),
          ),
          MyNavButton(
            Text("Main Menu", ),
            MainPage()
          ),
        ],
      ),
    );
  }
}