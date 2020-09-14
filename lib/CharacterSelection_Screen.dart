import 'package:betrayalcompanionapp/GameLogic/Player.dart';
import 'package:betrayalcompanionapp/Globals/Header.dart';
import 'package:betrayalcompanionapp/Globals/NavBar.dart';
import 'package:betrayalcompanionapp/main.dart';
import 'package:flutter/material.dart';

class CharacterSelection_Screen extends StatefulWidget {
  int playerCount;

  CharacterSelection_Screen(this.playerCount);

  @override
  _CharacterSelection_ScreenState createState() => _CharacterSelection_ScreenState(playerCount);
}

class _CharacterSelection_ScreenState extends State<CharacterSelection_Screen> {
  int playerCount;
  _CharacterSelection_ScreenState(this.playerCount);

  List<Player> characters_copy = MainPage.characters;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      color: new Color(128),
      home: SafeArea(
        child: DefaultTabController(
          length: 1,
          child: new Scaffold(
            body: Stack(
              children: <Widget> [
                Header("CHARACTER SELECTION"),
                SizedBox(height: 30),
                TabBarView(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Image(image: AssetImage("assets/images/zoe.png"), height: 200, width: 200),
                          Row(
                            children: [
                              CreateStatField("Might", characters_copy[0].stats.speed, characters_copy[0].stats.speedDefaultIndex),
                              CreateStatField("Speed", characters_copy[0].stats.might, characters_copy[0].stats.mightDefaultIndex),
                              CreateStatField("Knowledge", characters_copy[0].stats.knowledge, characters_copy[0].stats.knowledgeDefaultIndex),
                              CreateStatField("Sanity", characters_copy[0].stats.sanity, characters_copy[0].stats.sanityDefaultIndex)
                            ],
                          ),
                          Text("Hobbies: " + characters_copy[0].hobbies, style: TextStyle(color: Colors.white, fontSize: 20),),
                          Row(
                            children: [
                              Text("Birthday: " + characters_copy[0].birthday.month.toString() + " " + characters_copy[0].birthday.day.toString(),
                                  style: TextStyle(color: Colors.white, fontSize: 20)),
                              Text("Weight: " + characters_copy[0].weight.toString() +  "lbs",
                                  style: TextStyle(color: Colors.white, fontSize: 20)),
                            ],
                          ),
                          Text("Age: " + characters_copy[0].age.toString(), style: TextStyle(color: Colors.white, fontSize: 20)),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      )
      //bottomNavigationBar: NavBar(),
    );
  }

  CreateCharacterPages() {
    var characterPages = <Container>[];

    for(Player player in characters_copy) {
      String imagePath = "";

      characterPages.add(Container(
        child: Column(
          children: [
            Image(image: AssetImage(imagePath), height: 200, width: 200),
            Row(
              children: [
                CreateStatField("Might", player.stats.speed, player.stats.speedDefaultIndex),
                CreateStatField("Speed", player.stats.might, player.stats.mightDefaultIndex),
                CreateStatField("Knowledge", player.stats.knowledge, player.stats.knowledgeDefaultIndex),
                CreateStatField("Sanity", player.stats.sanity, player.stats.sanityDefaultIndex)
              ],
            ),
            Text("Hobbies: " + player.hobbies, style: TextStyle(color: Colors.white, fontSize: 20),),
            Row(
              children: [
                Text("Birthday: " + player.birthday.month.toString() + " " + player.birthday.day.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Text("Weight: " + player.weight.toString() +  "lbs",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
            Text("Age: " + player.age.toString(), style: TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ));

      return characterPages;
    }
  }

  CreateStatField(String statName, List<int> list, int statDefaultIndex) {
    var statFields = <TextField>[];

    for(int i = 0; i < list.length; i++) {
      var textEditingController = new TextEditingController(text: list[i].toString());
      Color color = (i == statDefaultIndex) ? Color.fromRGBO(96,217,104, 100) : Colors.white;
      statFields.add(new TextField(controller: textEditingController, style: TextStyle(color: color, fontSize: 16),));
    }

    statFields.add(new TextField(controller: TextEditingController(text: statName), style: TextStyle(fontSize: 16),));

    return Column(
        children: statFields
    );
  }
}
