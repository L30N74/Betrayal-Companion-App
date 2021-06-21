import 'package:betrayalcompanionapp/GameLogic/HauntDropdowns.dart';
import 'package:betrayalcompanionapp/GameLogic/HauntInformation.dart';
import 'package:betrayalcompanionapp/GlobalWidgets/Constants.dart';
import 'package:betrayalcompanionapp/GlobalWidgets/Header.dart';
import 'package:betrayalcompanionapp/Screens/Character_Details.dart';
import 'package:betrayalcompanionapp/GameLogic/GlobalMethods.dart';
import 'package:betrayalcompanionapp/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  var carouselOptions;
  var carouselIndex = 10;

  String _selectedPage = "Omen In Play";

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 3, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    carouselOptions = new CarouselOptions(height: 150, enableInfiniteScroll: true, initialPage: carouselIndex, enlargeCenterPage: true, onPageChanged: (index, _) => carouselIndex = index);

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
                        OmenAndTrackPage(),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          HauntDropdown(HauntDecisions.Room),
          Divider(),
          HauntDropdown(HauntDecisions.Omen),
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

  Container OmenAndTrackPage() {
    List<String> pages = ["Omen In Play", "Turn/Damage Track"];

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              canvasColor: darkGreyColor,
            ),
            child: DropdownButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 50,
              iconEnabledColor: Colors.white,
              value: _selectedPage,
              items: pages.map((String text) {
                return DropdownMenuItem(
                  value: text,
                  child: (text == pages.first)
                      ? Center(child: Text(text, style: TextStyle(fontSize: 40, color: Colors.white),))
                      : Center(child: Text(text, style: TextStyle(fontSize: 30, color: Colors.white),)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedPage = newValue;
                });
              },
            ),
          ),
          Container(
            child: (_selectedPage == pages.first)
                ? OmenPage()
                : TurnDamageTrackPage(),
          ),
          Divider(),
        ],
      ),
    );
  }

  Container OmenPage() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              height: 50,
              width: 60,
              child: RaisedButton(
                child: Text("-", style: TextStyle(fontSize: 25, color: Colors.black),),
                onPressed: () {
                  setState(() {
                    Logic.omenInPlay--;

                    if(Logic.omenInPlay < 0) Logic.omenInPlay = 0;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: Center(
              child: Text(
                Logic.omenInPlay.toString(),
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              height: 50,
              width: 60,
              child: RaisedButton(
                child: Text("+", style: TextStyle(fontSize: 25, color: Colors.black),),
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

  Container TurnDamageTrackPage() {
    final items = List<String>.generate(13, (i) => "$i");

    return Container(
      height: 150,
      child: SingleChildScrollView(
        child: new CarouselSlider(
          options: carouselOptions,
          items: items.map((item) => Container(
            decoration: BoxDecoration(
                color: darkGreyColor,
                borderRadius: BorderRadius.all(Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15
                  )
                ]
            ),
            child: Center(
              child: Text(
                item,
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
          )).toList(),
        ),
      ),
    );
  }

  Container PlayerGamePage() {
    return Container(
      child: Column(
        children: [
          Text("Players", style: TextStyle(fontSize: 54, color: Colors.white, decoration: TextDecoration.underline)),
          CreatePlayerBanners(),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 50,
              width: 200,
              color: Colors.black,
              child: RaisedButton(
                child: Text("Starting Player", style: TextStyle(fontSize: 20, color: Colors.black), textAlign: TextAlign.center,),
                onPressed: () => ShowStartingPlayer(),
              ),
            ),
          ),
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
                      child: Stack(
                        children: [
                          Image(image: AssetImage(Logic.players[index].imagePath), height: 90, width: 90),
                          if(Logic.players[index].isDead) Image(image: AssetImage("assets/images/dead_border.png"), height: 90, width: 90,),
                        ],
                      ),
                        /*child:  Image(
                          image: AssetImage(Logic.players[index].imagePath),
                          width: 90,
                          height: 90
                        )*/
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
            Tab(icon: Icon(Icons.account_box, color: Colors.white,)),
            Tab(icon: Image.asset("assets/images/raven.png", color: Colors.white, height: 25,)),
            Tab(icon: Image.asset("assets/images/haunt.png", color: Colors.white, height: 25,)),
//            Tab(icon: Icon(Icons.menu)),
          ],
        )
    );
  }

  ShowStartingPlayer() {
    Logic.CreateStartingCharacterAlert(context);
  }
}

