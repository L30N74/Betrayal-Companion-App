import 'package:betrayalcompanionapp/CoinFlip.dart';
import 'package:betrayalcompanionapp/Game.dart';
import 'package:betrayalcompanionapp/GameLogic/Character.dart';
import 'package:betrayalcompanionapp/Globals/MyNavButton.dart';
import 'package:betrayalcompanionapp/GameLogic/Stats.dart';
import 'package:betrayalcompanionapp/Globals/Header.dart';
import 'package:betrayalcompanionapp/NewGame_Screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MainPage());


class MainPage extends StatelessWidget {
  static const String _title = "Betrayal Companion App";

  static List<Character> characters;
  static List<Character> players = new List<Character>(); //Characters the players chose

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(128, 128, 128, 100),
        body: HomeMenu(context, _title),
      ),
    );
  }

  Widget HomeMenu(context, String title){
    return SafeArea(
      child: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: <Widget>[
              Header(title),
              Divider(),
              Column(
                children: [
                  Divider(),
                  RaisedButton(
                    child: Text("Start New Game", style: TextStyle(fontSize: 36)),
                    onPressed: () {
                      InitializeCharacterLists();
                      players = new List<Character>();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewGame_Screen()));
                    },
                  ),
                  Divider(),
                  RaisedButton(
                    child: Text("Current Game", style: TextStyle(fontSize: 36)),
                    onPressed: () {
                      InitializeCharacterLists();
                      players = [ characters[0], characters[1], characters[2], characters[4], characters[5], characters[6] ];
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Game()));
                    },
                  ),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }

  static Character GetCharacterByName(String name) {
    for(Character c in characters) {
      if(c.name == name)
        return c;
    }

    throw new Exception("No Character with the name \"$name\"");
  }

  static Character RemoveCharacterPairFromList(Character character) {
    switch(character.color) {
      case CharacterColor.White:
        characters.remove(MainPage.GetCharacterByName("Professor Longfellow"));
        characters.remove(MainPage.GetCharacterByName("Father Rheinhardt"));
        break;
      case CharacterColor.Red:
        characters.remove(MainPage.GetCharacterByName("Ox Bellows"));
        characters.remove(MainPage.GetCharacterByName("Darrin \"Flash\" Williams"));
        break;
      case CharacterColor.Yellow:
        characters.remove(MainPage.GetCharacterByName("Zoe Ingstrom"));
        characters.remove(MainPage.GetCharacterByName("Brandon Jaspers"));
        break;
      case CharacterColor.Green:
        characters.remove(MainPage.GetCharacterByName("Peter Akimoto"));
        characters.remove(MainPage.GetCharacterByName("Missy Dubourde"));
        break;
      case CharacterColor.Purple:
        characters.remove(MainPage.GetCharacterByName("Heather Granville"));
        characters.remove(MainPage.GetCharacterByName("Vivian Lopez"));
        break;
      case CharacterColor.Blue:
        characters.remove(MainPage.GetCharacterByName("Jenny LeClerc"));
        characters.remove(MainPage.GetCharacterByName("Madame Zostra"));
        break;
    }
  }

  void InitializeCharacterLists(){

    Stats stats_Rheinhardt = new Stats([2, 3, 3, 4, 5, 6, 7, 7], 2,
        [1, 2, 2, 4, 4, 5, 5, 7], 2,
        [3, 4, 5, 5, 6, 7, 7, 8], 4,
        [1, 3, 3, 4, 5, 6, 6, 8], 3);

    String hobbies_Rheinhardt = "Hobby 1, Hobby 2";

    Stats stats_Longfellow = new Stats([2, 3, 3, 4, 5, 6, 7, 7], 2,
        [1, 2, 2, 4, 4, 5, 5, 7], 2,
        [3, 4, 5, 5, 6, 7, 7, 8], 4,
        [1, 3, 3, 4, 5, 6, 6, 8], 3);

    String hobbies_Longfellow = "Gaelic Music, Drama, Fine Wines";

    Stats stats_Granville = new Stats([3, 3, 4, 5, 6, 6, 7, 8], 2,
        [3, 3, 3, 4, 5, 6, 7, 8], 2,
        [3, 3, 3, 4, 5, 6, 6, 6], 2,
        [2, 3, 3, 4, 5, 6, 7, 8], 4);

    String hobbies_Granville = "Hobby 1, Hobby 2";

    Stats stats_LeClerc = new Stats([2, 3, 4, 4, 4, 5, 6, 8], 3,
        [3, 4, 4, 4, 4, 5, 6, 8], 2,
        [1, 1, 2, 4, 4, 4, 5, 6], 4,
        [2, 3, 3, 4, 4, 5, 6, 8], 2);

    String hobbies_LeClerc = "Reading, Soccer";

    Stats stats_Lopez = new Stats([3, 4, 4, 4, 4, 6, 7, 8], 3,
        [2, 2, 2, 4, 4, 5, 6, 6], 2,
        [4, 4, 4, 5, 6, 7, 8, 8], 2,
        [4, 5, 5, 5, 5, 6, 6, 7], 3);

    String hobbies_Lopez = "Old Movies, Horses";

    Stats stats_Zostra = new Stats([2, 3, 3, 5, 5, 6, 6, 7], 2,
        [2, 3, 3, 4, 5, 5, 5, 6], 3,
        [4, 4, 4, 5, 6, 7, 8, 8], 2,
        [1, 3, 4, 4, 4, 5, 6, 6], 3);

    String hobbies_Zostra = "Hobby 1, Hobby 2";

    Stats stats_Akimoto = new Stats([3, 3, 3, 4, 6, 6, 7, 7], 3,
        [2, 3, 3, 4, 5, 5, 6, 8], 2,
        [3, 4, 4, 4, 5, 6, 6, 7], 3,
        [3, 4, 4, 5, 6, 7, 7, 8], 2);

    String hobbies_Akimoto = "Hobby 1, Hobby 2";

    Stats stats_Jaspers = new Stats([3, 4, 4, 4, 5, 6, 7, 8], 2,
        [2, 3, 3, 4, 5, 6, 6, 7], 3,
        [3, 3, 3, 4, 5, 6, 7, 8], 3,
        [1, 3, 3, 5, 5, 6, 6, 7], 2);

    String hobbies_Jaspers = "Computers, Camping, Hockey";

    Stats stats_Ingstrom = new Stats([4, 4, 4, 4, 5, 6, 8, 8], 3,
        [2, 2, 3, 3, 4, 4, 6, 7], 3,
        [3, 4, 5, 5, 6, 6, 7, 8], 2,
        [1, 2, 3, 4, 4, 5, 5, 5], 2);

    String hobbies_Ingstrom = "Dolls, Music";

    Stats stats_Dubourde = new Stats([3, 4, 5, 6, 6, 6, 7, 7], 2,
        [2, 3, 3, 3, 4, 5, 6, 7], 3,
        [1, 2, 3, 4, 5, 5, 6, 7], 2,
        [2, 3, 4, 4, 5, 6, 6, 6], 3);

    String hobbies_Dubourde = "Hobby 1, Hobby 2";

    Stats stats_Williams = new Stats([4, 4, 4, 5, 6, 7, 7, 8], 4,
        [2, 3, 3, 4, 5, 6, 6, 7], 2,
        [1, 2, 3, 4, 5, 5, 5, 7], 2,
        [2, 3, 3, 4, 5, 5, 5, 7], 2);

    String hobbies_Williams = "Hobby 1, Hobby 2";

    Stats stats_Bellows = new Stats([2, 2, 2, 3, 4, 5, 5, 6], 4,
        [4, 5, 5, 6, 6, 7, 8, 8], 2,
        [2, 2, 3, 4, 5, 5, 6, 7], 2,
        [2, 2, 3, 3, 5, 5, 6, 6], 2);

    String hobbies_Bellows = "Football, Shiny Objects";

    characters = [
      new Character("Father Rheinhardt", hobbies_Rheinhardt, 52, 60, 5.9, new DateTime(DateTime.april, 29), stats_Rheinhardt, CharacterColor.White),
      new Character("Professor Longfellow", hobbies_Longfellow, 52, 153, 5.11, new DateTime(DateTime.july, 27), stats_Longfellow, CharacterColor.White),
      new Character("Heather Granville", hobbies_Granville, 18, 153, 5.2, new DateTime(DateTime.july, 27), stats_Granville, CharacterColor.Purple),
      new Character("Vivian Lopez", hobbies_Lopez, 42, 142, 5.5, new DateTime(DateTime.january, 11), stats_Lopez, CharacterColor.Purple),
      new Character("Jenny LeClerc", hobbies_LeClerc, 21, 142, 5.7, new DateTime(DateTime.march, 4), stats_LeClerc, CharacterColor.Blue),
      new Character("Madame Zostra", hobbies_Zostra, 37, 150, 5.0, new DateTime(DateTime.december, 10), stats_Zostra, CharacterColor.Blue),
      new Character("Brandon Jaspers", hobbies_Jaspers, 12, 109, 5.1, new DateTime(DateTime.may, 21), stats_Jaspers, CharacterColor.Yellow),
      new Character("Zoe Ingstrom", hobbies_Ingstrom, 8, 49, 3.9, new DateTime(DateTime.november, 5), stats_Ingstrom, CharacterColor.Yellow),
      new Character("Peter Akimoto", hobbies_Akimoto, 13, 80, 4.11, new DateTime(DateTime.september, 3), stats_Akimoto, CharacterColor.Green),
      new Character("Missy Dubourde", hobbies_Dubourde, 9, 62, 4.2, new DateTime(DateTime.february, 14), stats_Dubourde, CharacterColor.Green),
      new Character("Darrin \"Flash\" Williams", hobbies_Williams, 20, 188, 5.11, new DateTime(DateTime.june, 6), stats_Williams, CharacterColor.Red),
      new Character("Ox Bellows", hobbies_Bellows, 23, 288, 6.4, new DateTime(DateTime.october, 18), stats_Bellows, CharacterColor.Red),
    ];
  }
}