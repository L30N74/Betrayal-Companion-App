import 'package:flutter/material.dart';
import 'package:betrayalcompanionapp/Globals/Globals.dart';

class ScaffoldWithBottomBar extends Scaffold {
  @override
  Widget build(BuildContext context) {
    bottomNavigationBar: BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: darkGreyColor,
      child: Container(
        height: 60,
      ),
    )
  }
}
