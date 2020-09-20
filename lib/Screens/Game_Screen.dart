import 'package:betrayalcompanionapp/GameLogic/Character.dart';
import 'package:betrayalcompanionapp/Globals/Globals.dart';
import 'package:betrayalcompanionapp/Globals/Header.dart';
import 'package:betrayalcompanionapp/HauntDropdowns.dart';
import 'package:betrayalcompanionapp/Screens/main.dart';
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
    _controller = TabController(vsync: this, length: 3, initialIndex: 0);
    super.initState();

    if(!MainPage.startingPlayerDetermined)
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await MainPage.CreateStartingCharacterAlert(context);
      });
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
                        HauntCountPage(),
                        HauntRevealPage()
                      ],
                    ),
                  )
                ],
              ),
            ),
          bottomNavigationBar: GetBottomNavBar(),
        ),
    );
  }

  Container HauntRevealPage() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Let the Fun Begin", style: TextStyle(fontSize: 54, color: Colors.white, decoration: TextDecoration.underline)),
          Expanded(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Text("Which Room?", style: TextStyle(fontSize: 26, color: Colors.white),),
//                      HauntRoomDropdown(),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text("Which Omen?", style: TextStyle(fontSize: 26),),
//                      HauntOmenDropdown(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container DiceRollPage() {
    return Container(
      child: Column(
        children: [
          Text("Roll The Dice", style: TextStyle(fontSize: 54, color: Colors.white, decoration: TextDecoration.underline)),
          Text("Coming Up", style: TextStyle(fontSize: 80, color: Colors.white),),
        ],
      ),
    );
  }

  Container HauntCountPage() {
    return Container(
      child: Column(
        children: [
          Text("Omen In Play", style: TextStyle(fontSize: 54, color: Colors.white, decoration: TextDecoration.underline)),
          Text(MainPage.omenInPlay.toString(), style: TextStyle(fontSize: 48),),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              height: 80,
              width: 200,
              child: RaisedButton(
                child: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    MainPage.omenInPlay++;
                  });
                  },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container PlayerGamePage() {
    return Container(
      child: Column(
        children: [
          Text("Players", style: TextStyle(fontSize: 54, color: Colors.white, decoration: TextDecoration.underline)),
          CreatePlayerBanners(),
        ]
      ),
    );
  }

  Expanded CreatePlayerBanners() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 20, bottom: 80),
        itemCount: MainPage.players.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => {
              // TODO: Redirect to Character Details Page
              print(MainPage.players[index].name + " was tapped")
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: darkGreyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(50)
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child:  Text(("\t")*5 + (index+1).toString(), style: TextStyle(fontSize: 26, color: Colors.white), textAlign: TextAlign.center)
                  ),
                  Container(
                      child:  Text(MainPage.players[index].name, style: TextStyle(fontSize: 26, color: Colors.white), textAlign: TextAlign.center)
                  ),
                  Container(
                      child:  Image(image: AssetImage(MainPage.players[index].imagePath), width: 100, height: 100)
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  BottomAppBar GetBottomNavBar() {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: darkGreyColor,
        child: TabBar(
          controller: _controller,
          tabs: [
            Tab(icon: Icon(Icons.account_box)),
            Tab(icon: Icon(Icons.print)),
            Tab(icon: Icon(Icons.close)),
//            Tab(icon: Icon(Icons.menu)),
          ],
        )
    );
  }
}

