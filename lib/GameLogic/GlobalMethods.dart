import 'dart:math';

import 'package:betrayalcompanionapp/Screens/NewGame_Screen.dart';
import 'package:flutter/material.dart';
import 'package:betrayalcompanionapp/GameLogic/Stats.dart';
import 'package:betrayalcompanionapp/GameLogic/Database.dart';
import 'package:betrayalcompanionapp/GameLogic/Character.dart';
import 'package:betrayalcompanionapp/GameLogic/HauntInformation.dart';

class Logic {
  static List<Character> characters;
  static List<Character> players = new List<Character>(); //Characters the players chose

  static int omenInPlay = 0;

  static bool isHauntRevealed = false;
  static bool useExpansion = false;

  static HauntInformation revealedHauntInformation;


  static Character GetCharacterByName(String name) {
    for(Character c in characters) {
      if(c.name == name)
        return c;
    }

    throw new Exception("No Character with the name \"$name\"");
  }

  static Character RemoveCharacterPairFromList(CharacterColor color) {
    switch(color) {
      case CharacterColor.White:
        characters.remove(Logic.GetCharacterByName("Professor Longfellow"));
        characters.remove(Logic.GetCharacterByName("Father Rhinehardt"));
        break;
      case CharacterColor.Red:
        characters.remove(Logic.GetCharacterByName("Ox Bellows"));
        characters.remove(Logic.GetCharacterByName("Darrin \"Flash\" Williams"));
        break;
      case CharacterColor.Yellow:
        characters.remove(Logic.GetCharacterByName("Zoe Ingstrom"));
        characters.remove(Logic.GetCharacterByName("Missy Dubourde"));
        break;
      case CharacterColor.Green:
        characters.remove(Logic.GetCharacterByName("Peter Akimoto"));
        characters.remove(Logic.GetCharacterByName("Brandon Jaspers"));
        break;
      case CharacterColor.Purple:
        characters.remove(Logic.GetCharacterByName("Heather Granville"));
        characters.remove(Logic.GetCharacterByName("Jenny LeClerc"));
        break;
      case CharacterColor.Blue:
        characters.remove(Logic.GetCharacterByName("Vivian Lopez"));
        characters.remove(Logic.GetCharacterByName("Madame Zostra"));
        break;
    }
  }

  static void InitializeCharacterLists(){
    players = new List<Character>();

    Stats stats_Rheinhardt = new Stats([2, 3, 3, 4, 5, 6, 7, 7], 2,
        [1, 2, 2, 4, 4, 5, 5, 7], 2,
        [3, 4, 5, 5, 6, 7, 7, 8], 4,
        [1, 3, 3, 4, 5, 6, 6, 8], 3);
    String hobbies_Rheinhardt = "Fencing, Gardening";

    Stats stats_Longfellow = new Stats([2, 3, 3, 4, 5, 6, 7, 7], 2,
        [1, 2, 2, 4, 4, 5, 5, 7], 2,
        [3, 4, 5, 5, 6, 7, 7, 8], 4,
        [1, 3, 3, 4, 5, 6, 6, 8], 3);
    String hobbies_Longfellow = "Gaelic Music, Drama, Fine Wines";

    Stats stats_Granville = new Stats([3, 3, 4, 5, 6, 6, 7, 8], 2,
        [3, 3, 3, 4, 5, 6, 7, 8], 2,
        [3, 3, 3, 4, 5, 6, 6, 6], 2,
        [2, 3, 3, 4, 5, 6, 7, 8], 4);
    String hobbies_Granville = "Television, Shopping";

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
    String hobbies_Zostra = "Astrology, Cooking, Baseball";

    Stats stats_Akimoto = new Stats([3, 3, 3, 4, 6, 6, 7, 7], 3,
        [2, 3, 3, 4, 5, 5, 6, 8], 2,
        [3, 4, 4, 4, 5, 6, 6, 7], 3,
        [3, 4, 4, 5, 6, 7, 7, 8], 2);
    String hobbies_Akimoto = "Bugs, Basketball";

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
    String hobbies_Dubourde = "Swimming, Medicine";

    Stats stats_Williams = new Stats([4, 4, 4, 5, 6, 7, 7, 8], 4,
        [2, 3, 3, 4, 5, 6, 6, 7], 2,
        [1, 2, 3, 4, 5, 5, 5, 7], 2,
        [2, 3, 3, 4, 5, 5, 5, 7], 2);
    String hobbies_Williams = "Track, Music, Shakespearean Literature";

    Stats stats_Bellows = new Stats([2, 2, 2, 3, 4, 5, 5, 6], 4,
        [4, 5, 5, 6, 6, 7, 8, 8], 2,
        [2, 2, 3, 4, 5, 5, 6, 7], 2,
        [2, 2, 3, 3, 5, 5, 6, 6], 2);
    String hobbies_Bellows = "Football, Shiny Objects";


    int currentYear = DateTime.now().year;
    Logic.characters = [
      new Character("Father Rhinehardt", hobbies_Rheinhardt, 52, 60, 5.9, new DateTime.utc(currentYear, DateTime.april, 29), stats_Rheinhardt, CharacterColor.White),
      new Character("Professor Longfellow", hobbies_Longfellow, 52, 153, 5.11, new DateTime.utc(currentYear, DateTime.july, 27), stats_Longfellow, CharacterColor.White),
      new Character("Heather Granville", hobbies_Granville, 18, 153, 5.2, new DateTime.utc(currentYear, DateTime.august, 2), stats_Granville, CharacterColor.Purple),
      new Character("Jenny LeClerc", hobbies_LeClerc, 21, 142, 5.7, new DateTime.utc(currentYear, DateTime.march, 4), stats_LeClerc, CharacterColor.Purple),
      new Character("Vivian Lopez", hobbies_Lopez, 42, 142, 5.5, new DateTime.utc(currentYear, DateTime.january, 11), stats_Lopez, CharacterColor.Blue),
      new Character("Madame Zostra", hobbies_Zostra, 37, 150, 5.0, new DateTime.utc(currentYear, DateTime.december, 10), stats_Zostra, CharacterColor.Blue),
      new Character("Brandon Jaspers", hobbies_Jaspers, 12, 109, 5.1, new DateTime.utc(currentYear, DateTime.may, 21), stats_Jaspers, CharacterColor.Green),
      new Character("Peter Akimoto", hobbies_Akimoto, 13, 80, 4.11, new DateTime.utc(currentYear, DateTime.september, 3), stats_Akimoto, CharacterColor.Green),
      new Character("Zoe Ingstrom", hobbies_Ingstrom, 8, 49, 3.9, new DateTime.utc(currentYear, DateTime.november, 5), stats_Ingstrom, CharacterColor.Yellow),
      new Character("Missy Dubourde", hobbies_Dubourde, 9, 62, 4.2, new DateTime.utc(currentYear, DateTime.february, 14), stats_Dubourde, CharacterColor.Yellow),
      new Character("Darrin \"Flash\" Williams", hobbies_Williams, 20, 188, 5.11, new DateTime.utc(currentYear, DateTime.june, 6), stats_Williams, CharacterColor.Red),
      new Character("Ox Bellows", hobbies_Bellows, 23, 288, 6.4, new DateTime.utc(currentYear, DateTime.october, 18), stats_Bellows, CharacterColor.Red),
    ];
  }

  static Character DetermineStartingPlayer() {
    DateTime today = DateTime.now().toUtc();
    Character starter = players[0];

    final timeDifference = today.difference(players[0].birthday).inDays;

    for(Character c in players) {
      var difference =  today.difference(c.birthday).inDays;

      if(difference < timeDifference)
        starter = c;
    }

    return starter;
  }

  static void DetermineHaunt() {
    String room = revealedHauntInformation.room.name;
    String omen = revealedHauntInformation.omen.name;

    SQLiteDbProvider.db.
    getHauntByRoomAndOmen(room, omen).then(
      (haunt) {
        revealedHauntInformation = new HauntInformation(
          hauntName: haunt.hauntName,
          hauntNumber: haunt.hauntNumber,
          traitorProperties: haunt.traitorProperties
        );

        isHauntRevealed = true;
      }
    )
    .catchError((onError) {
      throw new Exception("No haunt in room $room and with omen $omen\n--------------------- ${onError.toString()} + \n----------------------------");
    });
  }

  static void RandomizePlayers(int amount) {
    //Select x amount of characters
    for(int i = 0; i < amount; i++) {
      // Choose character
      Random rand = new Random();
      Character character = Logic.characters[rand.nextInt(Logic.characters.length)];
      Logic.players.add(character);

      // Remove characters from list
      RemoveCharacterPairFromList(character.color);
    }
  }

  static Future CreateStartingCharacterAlert(BuildContext context) {
    Character startingPlayer = DetermineStartingPlayer();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Starting player"),
            content: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                        "The starting player is \n ${startingPlayer.name}",
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.center
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Got it"),
                      )
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  static Future CreateNewGameConfirmationAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Creating a new Game",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Creating a new Game will erase the old one.\nAre you sure you want to do that?",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        child: Text(
                          "Yes",
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () => Logic.StartNewGame(context),
                      ),
                      RaisedButton(
                        child: Text(
                          "No",
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  static Future CreateTraitorTieAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Traitor Tie",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "If two explorers tie, and one of them is the haunt revealer, choose the haunt revealer.\n"
                          "If neither player is the haunt revealer, choose the one who's closest to the left of the haunt revealer.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      "Thanks",
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  static void StartNewGame(context) {
    InitializeCharacterLists();
    isHauntRevealed = false;
    revealedHauntInformation = new HauntInformation.empty();
    omenInPlay = 0;

    Navigator.push(context, MaterialPageRoute(builder: (context) => NewGame_Screen()));
  }
}