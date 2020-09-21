import 'package:betrayalcompanionapp/Screens/CoinFlip_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:betrayalcompanionapp/Screens/main.dart';
import 'package:betrayalcompanionapp/Globals/Header.dart';
import 'package:betrayalcompanionapp/Globals/Globals.dart';
import 'file:///D:/Anderes/Projekte/betrayal_companion_app/lib/Screens/Game_Screen.dart';
import 'file:///D:/Anderes/Projekte/betrayal_companion_app/lib/Screens/CharacterSelection_Screen.dart';


class NewGame_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(128, 128, 128, 100),
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
  PageController _controller;

  int playerCount = 2;

  double screenHeight;
  double screenWidth;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0, viewportFraction: 0.5);
  }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(128, 128, 128, 100),
        body: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover
          ),
        ),
          child: Column(
            children: [
              Header("NEW GAME"),
              MainContent()
            ],
          ),
        ),
      ),
    );
  }

  MainContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                "How many Players?",
                style: TextStyle(fontSize: 26),
              ),
            )
          ),
          PlayerAmountBox(),
          RandomizePlayerButton(),
          ChoosePlayersButton(),
          SizedBox(height: screenHeight/10),
        ],
      ),
    );
  }

  PlayerAmountBox() {
    return Center(
      child: Container(
        height: 200,
        child: new PageView.builder(
          itemCount: 5,
          scrollDirection: Axis.vertical,
          controller: _controller,
          onPageChanged: (value) {
            setState(() {
              playerCount = value+2;
            });
          },
          itemBuilder: (context, index) => builder(index),
        ),
      ),
    );
  }

  builder(index) {
    return new AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double value = 1.0;
          if(_controller.position.haveDimensions) {
            value = _controller.page - index;
            value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
          }

          return new Center(
            child: new SizedBox(
              height: Curves.easeOut.transform(value) * 50,
              width: Curves.easeOut.transform(value) * 200,
              child: child,
            ),
          );
        },
      child: new Container(
        decoration: BoxDecoration(
            color: darkGreyColor,
            borderRadius: BorderRadius.all(Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 15
              )
            ]
        ),
        margin: const EdgeInsets.all(0.2),
        child: Center(child: Text((index+2).toString() + " Spieler", style: TextStyle(fontSize: 24, color: Colors.white))),
      ),
    );
  }

  ChoosePlayersButton() {
    return RaisedButton(
      child: Text("I want to choose", style: TextStyle(fontSize: 40)),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterSelection_Screen(playerCount)));
      },
    );
  }

  RandomizePlayerButton() {
    return RaisedButton(
      child: Text("Randomize", style: TextStyle(fontSize: 40)),
      onPressed: (){
        MainPage.RandomizePlayers(playerCount);

        // Check if 2 Players was selected
        if(playerCount == 2){
          //Choose a third player
          //TODO: Redirect to coin flipping to determine which player plays two characters
          Navigator.push(context, MaterialPageRoute(builder: (context) => CoinFlip()));
        }
        else
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Game()));
      }
    );
  }

//  Widget get _randomizePlayerButton(context) => RaisedButton(
//    child: Text("Randomize Players", style: TextStyle(fontSize: 40)),
//    onPressed: (){
//      playerCount  = int.parse(selectedPlayerCount.split(" ")[0]);
//
//      RandomizePlayers();
//
//      // Check if 2 Players was selected
//      if(playerCount == 2){
//        // TODO: Choose a third player
//      }
//      else {
//        //                    MainPage.CreateAlertDialog(context);
//      }
//
//      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Game()));
//    },
//  );
}
