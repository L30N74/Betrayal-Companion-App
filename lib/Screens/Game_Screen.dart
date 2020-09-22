import 'package:betrayalcompanionapp/GameLogic/HauntDropdowns.dart';
import 'package:betrayalcompanionapp/Globals/Globals.dart';
import 'package:betrayalcompanionapp/Globals/Header.dart';
import 'package:betrayalcompanionapp/Screens/Character_Details.dart';
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
          bottomNavigationBar: GetBottomNavBar(),
        ),
    );
  }

  Container HauntRevealPage() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Reveal the Haunt", style: TextStyle(fontSize: 54, color: Colors.white, decoration: TextDecoration.underline)),
          Expanded(
            child: (MainPage.isHauntRevealed)
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
          HauntPropertiesContainer()
        ],
      ),
    );
  }

  Container HauntDormentPage() {
    bool _checked = false;
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              Column(
                children: [
                  Text("Which Omen?", style: hauntTextTextStyle,),
                  HauntOmenSelection(
                    width: 200,
                    height: 60,
                  ),
                ],
              ),
            ],
          ),
//          CheckboxListTile(
//            title: Text("Use Widows's Walk Expansion", style: useExpansionCheckboxTextStyle,),
//
//          ),
        ],
      ),
    );
  }

  Container HauntNameContainer() {
    return Container(
      height: MainPage.isHauntRevealed ? 150 : 120,
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
                MainPage.revealedHauntInformation.hauntName,
                style: hauntNameTextStyle,
              ),
              Text(
                "Number " + MainPage.revealedHauntInformation.hauntNumber.toString(),
                style: hauntInformationTextStyle,
              ),
              Text(
                "Page " + MainPage.revealedHauntInformation.pageNumber.toString(),
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
      height: MainPage.isHauntRevealed ? 150 : 120,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
            children: [
              Text(
                MainPage.revealedHauntInformation.traitorProperties,
                style: hauntTraitorPropertiesTextStyle,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      MainPage.isHauntRevealed = false;
                      MainPage.revealedHauntInformation = null;
                    });
                  },
                  child: Text("Reset"),
                ),
              ),
            ]
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
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CharacterDetails(MainPage.players[index]))),
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
//                  Container(
//                      child:  Text(("\t")*5 + (index+1).toString(), style: TextStyle(fontSize: 26, color: Colors.white), textAlign: TextAlign.center)
//                  ),
                  Center(
                    child: Text(("\t")*7 + MainPage.players[index].name, style: TextStyle(fontSize: 26, color: Colors.white), textAlign: TextAlign.center),
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

