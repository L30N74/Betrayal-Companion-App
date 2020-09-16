import 'package:betrayalcompanionapp/GameLogic/Character.dart';
import 'package:betrayalcompanionapp/Globals/Globals.dart';
import 'package:betrayalcompanionapp/Globals/Header.dart';
import 'package:betrayalcompanionapp/main.dart';
import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GameWidget(),
      ),
    );
  }
}

class GameWidget extends StatefulWidget {
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> with SingleTickerProviderStateMixin{
  var _controller;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 2);
  }

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
                  Header("Betrayal At House On The Hill"),
                  SizedBox(height: 20),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        PlayerGamePage(),
                        HauntCountPage()
                      ],
                    ),
                  )
                ],
              ),
            ),
          bottomNavigationBar: BottomAppBar(
            color: BACKGROUND_COLOR,
            child: TabBar(
              controller: _controller,
              tabs: [
                Tab(icon: Icon(Icons.account_box)),
                Tab(icon: Icon(Icons.print))
              ],
            ),
          ),
        ),
    );
  }

  Container HauntCountPage() {
    return Container(
      child: Column(

      ),
    );
  }

  Container PlayerGamePage() {
    return Container(
      child: Column(
        children: CreatePlayerBanners()
      ),
    );
  }

  List<Row> CreatePlayerBanners() {
    List<Row> banners = [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Players", style: TextStyle(fontSize: 54, color: Colors.white, decoration: TextDecoration.underline))],
      )
    ];

    for(int i = 0; i < MainPage.players.length; i++) {
        Character player = MainPage.players[i];

        banners.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text((i+1).toString(), style: TextStyle(fontSize: 26, color: Colors.white)),
            Text(player.name, style: TextStyle(fontSize: 26, color: Colors.white)),
            Image(image: AssetImage(player.imagePath), width: 100, height: 100),
          ],
        ));
    }

    return banners;
  }
}

