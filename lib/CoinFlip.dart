import 'package:betrayalcompanionapp/Globals/Header.dart';
import 'package:flutter/material.dart';

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
              ],
            ),
          )
      )
    );
  }
}

