import 'package:flutter/material.dart';
import 'package:betrayalcompanionapp/Globals/Globals.dart';

class BottomBar extends StatelessWidget {
  Widget child;

  BottomBar({this.child});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: darkGreyColor,
      child: child,
    );
  }
}
