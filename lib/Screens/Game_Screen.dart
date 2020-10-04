import 'package:betrayalcompanionapp/GameLogic/HauntDropdowns.dart';
import 'package:betrayalcompanionapp/GameLogic/HauntInformation.dart';
import 'package:betrayalcompanionapp/GlobalWidgets/Constants.dart';
import 'package:betrayalcompanionapp/GlobalWidgets/Header.dart';
import 'package:betrayalcompanionapp/Screens/Character_Details.dart';
import 'package:betrayalcompanionapp/GameLogic/GlobalMethods.dart';
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
    _controller = TabController(vsync: this, length: 3, initialIndex: 0);
    super.initState();

    if(!Logic.startingPlayerDetermined)
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Logic.CreateStartingCharacterAlert(context);
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
                  Header("Betrayal At House\nOn The Hill"),
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
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.home),
            backgroundColor: darkGreyColor,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPage())),
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
          Text(
              "Reveal the Haunt",
              style: TextStyle(
                  fontSize: 54,
                  color: Colors.white,
                  decoration: TextDecoration.underline
              ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: (Logic.isHauntRevealed)
                ? HauntRevealedPage()
                : HauntDormentPage()
          ),
        ],
      ),
    );
  }

  Container HauntRevealedPage() {
    return Container(
      child: Column(
        children: [
          HauntNameContainer(),
          HauntPropertiesContainer(),
        ],
      ),
    );
  }

  Container HauntDormentPage() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Column(
            children: [
              Text("Which room?", style: hauntTextTextStyle,),
              HauntRoomSelection(
                width: 200,
                height: 60,
              ),
            ],
          ),
          Divider(),
          Column(
            children: [
              Text("Which Omen?", style: hauntTextTextStyle,),
              HauntOmenSelection(
                width: 200,
                height: 60,
              ),
            ],
          ),
          CheckboxListTile(
            title: Text("Use Widow's Walk Expansion", style: useExpansionCheckboxTextStyle, textAlign: TextAlign.right,),
            value: Logic.useExpansion,
            onChanged: (bool value) {
              setState(() {
                Logic.useExpansion = value;
              });
            },
          ),
          SizedBox(height: 20,),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 50,
              width: 160,
              child: RaisedButton(
                child: Text("Reveal", style: TextStyle(fontSize: 20),),
                onPressed: () {
                  setState(() {
                    Logic.DetermineHaunt();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container HauntNameContainer() {
    return Container(
      height: 120,
      width: double.infinity,
      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
      color: darkGreyColor,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Haunt",
              style: TextStyle(fontSize: 24, color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          Column(
            children: [
              Text(
                Logic.revealedHauntInformation.hauntName,
                style: hauntNameTextStyle,
              ),
              Text(
                "Number " + Logic.revealedHauntInformation.hauntNumber.toString(),
                style: hauntInformationTextStyle,
              ),
            ]
          )
        ],
      ),
    );
  }

  Container HauntPropertiesContainer() {
    return Container(
      height: 150,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      color: darkGreyColor,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Traitor",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Logic.revealedHauntInformation.traitorProperties,
                style: (Logic.revealedHauntInformation.hauntNumber != "★")
                    ? hauntTraitorPropertiesTextStyle
                    : hauntTraitorPropertiesTextStyle_Small,
                textAlign: TextAlign.center,
              ),
              Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          Logic.isHauntRevealed = false;
                          Logic.revealedHauntInformation = new HauntInformation.empty();
                        });
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        "Tie?",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () => Logic.CreateTraitorTieAlert(context),
                    ),
                  ],
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }

//  Container DiceRollPage() {
//    return Container(
//      child: Column(
//        children: [
//          Text("Roll The Dice", style: TextStyle(fontSize: 54, color: Colors.white, decoration: TextDecoration.underline)),
//          Text("Coming Up", style: TextStyle(fontSize: 80, color: Colors.white),),
//        ],
//      ),
//    );
//  }

  Container HauntCountPage() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Omen In Play",
            style: TextStyle(fontSize: 54, color: Colors.white, decoration: TextDecoration.underline),
          ),
          Text(
            Logic.omenInPlay.toString(),
            style: TextStyle(fontSize: 48, color: Colors.white),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              height: 80,
              width: 200,
              child: RaisedButton(
                child: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    Logic.omenInPlay++;
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
        itemCount: Logic.players.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery.of(context).size.width - 20,
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CharacterDetails(Logic.players[index]))),
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
                    Text(
                      ("\t")*5 + (index+1).toString() + ":\t",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Center(
                      child: Text(
                        Logic.players[index].name,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center),
                    ),
                    Container(
                        child:  Image(
                          image: AssetImage(Logic.players[index].imagePath),
                          width: 90,
                          height: 90
                        )
                    ),
                  ],
                ),
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

