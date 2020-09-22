import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'Haunt.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }

  getHauntByRoomOmen(String room, String omen) async {
    final db = await database;
    var result = await db.query("Haunts", where: "room = ? and omen = ?", whereArgs: [room, omen]);
    return result.isNotEmpty ? Haunt.fromMap(result.first) : "Nothing found";
  }

  Future<List<Haunt>> getHaunts() async {
    final db = await database;
    List<Map> results = await db.query("Haunts", columns: ["room", "omen", "traitorProperties"], orderBy: "id ASC");

    List<Haunt> haunts = new List();
    results.forEach((element) {
      Haunt haunt = Haunt.fromMap(element);
      haunts.add(haunt);
    });

    return haunts;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "HauntsDB.db");

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("DROP TABLE IF EXISTS Haunts;");

        await db.execute(
          "CREATE TABLE Haunts("
          "id INTEGER PRIMARY KEY,"
          "room TEXT,"
          "omen TEXT,"
          "hauntNumber INTEGER,"
          "traitorProperties TEXT,"
          "hauntName TEXT);"
        );

        await CreateAbandonedRoomEntries(db);
        await CreateBalconyEntries(db);
        await CreateCatacombsEntries(db);
        await CreateCharredRoomEntries(db);
        await CreateDiningRoomEntries(db);
        await CreateDungeonEntries(db);
        await CreateFurnaceRoomEntries(db);
        await CreateGalleryEntries(db);
        await CreateGymnasiumEntries(db);
        await CreateJunkRoomEntries(db);
        await CreateJunkRoomEntries(db);
        await CreateKitchenEntries(db);
        await CreateMasterBedroomEntries(db);
        await CreateNurseryEntries(db);
        await CreatePentagramChamberEntries(db);
        await CreateRookeryEntries(db);
        await CreateServantsQuartersEntries(db);
        await CreateStudyEntries(db);
        await CreateTheaterEntries(db);
      }
    );
  }

  //Helpers
  CreateAbandonedRoomEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Bite", 18, "Left of the haunt revealer", "Offspring"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Bloodstone", 96, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Book", 7, "Father Rhinehardt gardening expert) or highest Sanity", "Carnivorous Ivy"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Box", 63, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Cat",88, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Crystal Ball", 11, "None", "Fleshwalkers"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Dog", 38, "Lowest Knowledge (except for the haunt revealer)", "Hellbeasts"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Girl", 1, "The Mummy Walks"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Holy Symbol", 9, "None (at first)", "The Dance of Death"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Key", 96, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Letter", 100, "None (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Madman", 45, "Highest Knowledge (except for the haunt revealer)", "Tick, Tick, Tick"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Mask", 42, "Highest Might", "Comes the Hero"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Medallion", 49, "Heather Granville or highest Knowledge", "You Wear It Well"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Photograph", 96, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Ring", 28, "Highest Knowledge (except for the haunt revealer)", "Ring of King Solomon"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Rope",86, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Skull", 34, "Professor Longfellow drama) or highest Speed", "Mad, Mad World"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Spear", 43, "Haunt revealer", "A Gathering of Shadows"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Spirit Board", 48, "Left of the haunt revealer", "Stacked Like Cordwood"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Abandoned Room", "Vial", 96, "Left of the haunt revealer", "[Hauntname missing]"]
    );
  }
  CreateBalconyEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Bite", 24, " Brandon Jaspers (camping) or lowest Speed", "Fly Away Home"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Bloodstone", 67, "Peter Akimoto (Basketball) or highest Speed", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Book", 7, "Father Rhinehardt gardening expert) or highest Sanity", "Carnivorous Ivy"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Box", 63, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Cat",88, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Crystal Ball", 32, "Highest Sanity", "Lost"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Dog", 5, "Haunt revealer", "I Was a Teenage Lycanthrope"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Girl", 16, "Left of the haunt revealer", "The Phantom’s Embrace"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Holy Symbol", 6, "Lowest Sanity", "The Floating Eye"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Key",90, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Letter", 87, "Youngest explorer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Madman", 11, "Haunt revealer", "Let Them In"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Mask", 25, "Zoe Ingstrom (dolls) or highest Knowledge", "Voodoo"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Medallion", 49, "Heather Granville or highest Knowledge", "You Wear It Well"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Photograph", 89, "Lowest Sanity", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Ring", 20, "Vivian Lopez (old movies) or highest Knowledge", "Ghost Bride"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Rope", 71, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Skull", 47, "Haunt revealer", "Worm Ouroboros"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Spear", 39, " Highest Speed (except for the haunt revealer)", "The Heir"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Spirit Board", 2, "Haunt Revealer", "The Séance"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Balcony", "Vial", 70, "Oldest explorer", "[Hauntname missing]"]
    );
  }
  CreateCatacombsEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Bite", 4, "Highest Might (except for the haunt revealer)", "The Web of Destiny"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Bloodstone", 59, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Book", 7, "Father Rhinehardt gardening expert) or highest Sanity", "Carnivorous Ivy"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Box", 61, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Cat",88, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Crystal Ball", 23, "Left of the haunt revealer", "Tentacled Horror"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Dog", 46, "Madame Zostra (cooking) or lowest Speed", "The Feast"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Girl", 1, "The Mummy Walks"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Holy Symbol", 13, "Lowest Sanity (except for the haunt revealer)", "Perchance to Dream"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Key", 53, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Letter", 83, "None (see Secrets of Survival)", "[Haunname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Madman", 10, "Haunt revealer", "Family Gathering"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Mask", 25, "Zoe Ingstrom (dolls) or highest Knowledge", "Voodoo"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Medallion", 49, "Heather Granville or highest Knowledge", "You Wear It Well"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Photograph", 94, "Explorer with the most items that can be stolen or traded", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Ring", 41, "Haunt revealer", "Invisible Traitor"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Rope", 69, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Skull", 37, "Lowest Might", "Checkmate"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Spear", 43, "Haunt revealer", "A Gathering of Shadows"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Spirit Board", 48, "Left of the haunt revealer", "Stacked Like Cordwood"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Catacombs", "Vial", 91, "Lowest Sanity", "[Hauntname missing]"]
    );
  }
  CreateCharredRoomEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Bite", 24, " Brandon Jaspers (camping) or lowest Speed", "Fly Away Home"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Bloodstone", 79, "Left and right of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Book", 33, "Highest Speed (except for the haunt revealer)", "Creature from the Lake"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Box", 63, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Cat", 0, "Refer to the chart after haunt 100 in Secrets of Survival. If all of your explorers have played haunts 57, 75, 86, and 93, there is no traitor in this scenario. Proceed to the next page in Secrets of Survival, If they have not, ignore the haunt roll", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Crystal Ball", 23, "Left of the haunt revealer", "Tentacled Horror"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Dog", 38, "Lowest Knowledge (except for the haunt revealer)", "Hellbeasts"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Girl", 30, "Haunt revealer", "Tomb of Dracula"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Holy Symbol", 13, "Lowest Sanity (except for the haunt revealer)", "Perchance to Dream"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Key", 0, "Refer to the chart after haunt 100 in Secrets of Survival. If all of your explorers have played haunts 57, 75, 86, and 93, there is no traitor in this scenario. Proceed to the next page in Secrets of Survival, If they have not, ignore the haunt roll", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Letter", 83, "None (see Secrets of Survival)", "[Haunname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Madman", 31, "Left of the haunt revealer", "It's Alive!"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Mask", 48, "Left of the haunt revealer", "Stacked Like Cordwood"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Medallion", 44, "Youngest explorer (except for the haunt revealer)", "Death Doth Find Us All"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Photograph", 0, "Refer to the chart after haunt 100 in Secrets of Survival. If all of your explorers have played haunts 57, 75, 86, and 93, there is no traitor in this scenario. Proceed to the next page in Secrets of Survival, If they have not, ignore the haunt roll", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Ring", 20, "Vivian Lopez (old movies) or highest Knowledge", "Ghost Bride"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Rope", 69, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Skull", 47, "Haunt revealer", "Worm Ouroboros"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Spear", 15, "Lowest Speed (except for the haunt revealer", "Here There Be Dragons"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Spirit Board", 8, "Haunt revealer", "Wail of the Banshee"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Charred Room", "Vial", 0, "Refer to the chart after haunt 100 in Secrets of Survival. If all of your explorers have played haunts 57, 75, 86, and 93, there is no traitor in this scenario. Proceed to the next page in Secrets of Survival, If they have not, ignore the haunt roll", "[Hauntname missing]"]
    );
  }
  CreateDiningRoomEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Bite", 24, " Brandon Jaspers (camping) or lowest Speed", "Fly Away Home"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Bloodstone", 67, "Peter Akimoto (Basketball) or highest Speed", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Book", 3, "Lowest Knowledge (Except for the haun revealer)", "Frog-Leg Stew"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Box", 99, "None (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Cat", 60, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Crystal Ball", 27, "Highest Knowledge (except for the haunt revealer)", "Amok Flesh"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Dog", 5, "Haunt revealer", "I Was a Teenage Lycanthrope"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Girl", 16, "Left of the haunt revealer", "The Phantom’s Embrace"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Holy Symbol", 6, "Lowest Sanity", "The Floating Eye"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Key",90, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Letter", 54, "Highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Madman", 45, "Highest Knowledge (except for the haunt revealer)", "Tick, Tick, Tick"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Mask", 42, "Highest Might", "Comes the Hero"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Medallion", 21, "Oldest explorer (except for the haunt revealer)", "House of the Living Dead"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Photograph", 89, "Lowest Sanity", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Ring", 20, "Vivian Lopez (old movies) or highest Knowledge", "Ghost Bride"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Rope",82, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Skull", 37, "Lowest Might", "Checkmate"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Spear", 39, " Highest Speed (except for the haunt revealer)", "The Heir"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Spirit Board", 40, "Left of the haunt revealer", "Buried Alive"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dining Room", "Vial", 91, "Lowest Sanity", "[Hauntname missing]"]
    );
  }
  CreateDungeonEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Bite", 97, "Hidden traitor (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Bloodstone", 55, "Female explorer closest to the right of the haunt revealer (or, if none, haunt revealer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Book", 55, "Female explorer closest to the right of the haunt revealer (or, if none, haunt revealer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Box", 61, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Cat", 55, "Female explorer closest to the right of the haunt revealer (or, if none, haunt revealer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Crystal Ball", 84, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Dog",72, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Girl", 55, "Female explorer closest to the right of the haunt revealer (or, if none, haunt revealer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Holy Symbol", 66, "Oldest male explorer or, if none, oldest explorer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Key", 53, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Letter", 100, "None (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Madman", 56, "Explorer with the most total items and omens", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Mask", 55, "Female explorer closest to the right of the haunt revealer (or, if none, haunt revealer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Medallion", 77, "Professor Longfellow (Gaelic Music) or highest Speed", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Photograph", 89, "Lowest Sanity", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Ring", 85, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Rope", 69, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Skull", 73, "Ox Bellows (Shiny Objetcs) or highest Might", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Spear", 65, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Spirit Board", 64, "Everyone except the highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Dungeon", "Vial", 80, "Highest Knowledge", "[Hauntname missing]"]
    );
  }
  CreateFurnaceRoomEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Bite", 4, "Highest Might (except for the haunt revealer)", "The Web of Destiny"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Bloodstone", 59, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Book", 33, "Highest Speed (except for the haunt revealer)", "Creature from the Lake"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Box", 61, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Cat", 75, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Crystal Ball", 32, "Highest Sanity", "Lost"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Dog", 38, "Lowest Knowledge (except for the haunt revealer)", "Hellbeasts"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Girl", 30, "Haunt revealer", "Tomb of Dracula"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Holy Symbol", 13, "Lowest Sanity (except for the haunt revealer)", "Perchance to Dream"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Key", 75, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Letter", 83, "None (see Secrets of Survival)", "[Haunname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Madman", 10, "Haunt revealer", "Family Gathering"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Mask", 42, "Highest Might", "Comes the Hero"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Medallion", 36, "Missy Dubourde swimming) or highest Speed", "Better with Friends"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Photograph", 75, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Ring", 28, "Highest Knowledge (except for the haunt revealer)", "Ring of King Solomon"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Rope", 75, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Skull", 34, "Professor Longfellow drama) or highest Speed", "Mad, Mad World"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Spear", 15, "Lowest Speed (except for the haunt revealer", "Here There Be Dragons"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Spirit Board", 2, "Haunt Revealer", "The Séance"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Furnace Room", "Vial", 91, "Lowest Sanity", "[Hauntname missing]"]
    );
  }
  CreateGalleryEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Bite", 18, " Left of the haunt revealer", "Offspring"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Bloodstone", 79, "Left and right of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Book", 3, "Lowest Knowledge (Except for the haun revealer)", "Frog-Leg Stew"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Box", 52, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Cat",88, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Crystal Ball", 19, "Haunt revealer", "The Beastmaster"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Dog", 19, "Haunt revealer", "The Beastmaster"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Girl", 19, "Haunt revealer", "The Beastmaster"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Holy Symbol", 22, "Left of the haunt revealer", "The Abyss Gazes Back"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Key", 53, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Letter", 54, "Highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Madman", 10, "Haunt revealer", "Family Gathering"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Mask", 25, "Zoe Ingstrom (dolls) or highest Knowledge", "Voodoo"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Medallion", 36, "Missy Dubourde swimming) or highest Speed", "Better with Friends"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Photograph", 76, "Oldest explorer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Ring", 41, "Haunt revealer", "Invisible Traitor"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Rope", 71, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Skull", 37, "Lowest Might", "Checkmate"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Spear", 15, "Lowest Speed (except for the haunt revealer", "Here There Be Dragons"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Spirit Board", 8, "Haunt revealer", "Wail of the Banshee"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gallery", "Vial", 70, "Oldest explorer", "[Hauntname missing]"]
    );
  }
  CreateGymnasiumEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Bite", 35, "Highest Knowledge", "Small Change"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Bloodstone", 79, "Left and right of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Book", 29, "Haunt revealer", "Frankenstein’s Legacy"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Box", 52, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Cat", 92, "None (see Secrets of Survival)", "[Haunname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Crystal Ball", 11, "None", "Fleshwalkers"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Dog", 46, "Madame Zostra (cooking) or lowest Speed", "The Feast"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Girl", 1, "The Mummy Walks"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Holy Symbol", 22, "Left of the haunt revealer", "The Abyss Gazes Back"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Key", 92, "None (see Secrets of Survival)", "[Haunname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Letter", 100, "None (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Madman", 11, "Haunt revealer", "Let Them In"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Mask", 22, "Left of the haunt revealer", "The Abyss Gazes Back"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Medallion", 21, "Oldest explorer (except for the haunt revealer)", "House of the Living Dead"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Photograph", 92, "None (see Secrets of Survival)", "[Haunname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Ring", 41, "Haunt revealer", "Invisible Traitor"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Rope",86, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Skull", 47, "Haunt revealer", "Worm Ouroboros"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Spear", 43, "Haunt revealer", "A Gathering of Shadows"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Spirit Board", 48, "Left of the haunt revealer", "Stacked Like Cordwood"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Gymnasium", "Vial", 92, "None (see Secrets of Survival)", "[Haunname missing]"]
    );
  }
  CreateJunkRoomEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Bite", 4, "Highest Might (except for the haunt revealer)", "The Web of Destiny"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Bloodstone", 79, "Left and right of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Book", 33, "Highest Speed (except for the haunt revealer)", "Creature from the Lake"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Box", 52, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Cat",88, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Crystal Ball", 27, "Highest Knowledge (except for the haunt revealer)", "Amok Flesh"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Dog", 46, "Madame Zostra (cooking) or lowest Speed", "The Feast"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Girl", 1, "The Mummy Walks"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Holy Symbol", 9, "None (at first)", "The Dance of Death"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Key", 68, "Jenny LeClerc (Reading) or highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Letter", 100, "None (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Madman", 11, "Haunt revealer", "Let Them In"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Mask", 25, "Zoe Ingstrom (dolls) or highest Knowledge", "Voodoo"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Medallion", 44, "Youngest explorer (except for the haunt revealer)", "Death Doth Find Us All"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Photograph", 76, "Oldest explorer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Ring", 17, "Peter Akimoto (bugs) or highest Knowledge", "Bugs"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Rope", 71, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Skull", 17, "Peter Akimoto (bugs) or highest Knowledge", "Bugs"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Spear", 17, "Peter Akimoto (bugs) or highest Knowledge", "Bugs"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Spirit Board", 40, "Left of the haunt revealer", "Buried Alive"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Junk Room", "Vial", 91, "Lowest Sanity", "[Hauntname missing]"]
    );
  }
  CreateKitchenEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Bite", 18, " Left of the haunt revealer", "Offspring"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Bloodstone", 67, "Peter Akimoto (Basketball) or highest Speed", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Book", 3, "Lowest Knowledge (Except for the haun revealer)", "Frog-Leg Stew"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Box", 99, "None (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Cat", 60, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Crystal Ball", 23, "Left of the haunt revealer", "Tentacled Horror"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Dog", 46, "Madame Zostra (cooking) or lowest Speed", "The Feast"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Girl", 16, "Left of the haunt revealer", "The Phantom’s Embrace"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Holy Symbol", 22, "Left of the haunt revealer", "The Abyss Gazes Back"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Key", 53, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Letter", 87, "Youngest explorer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Madman", 31, "Left of the haunt revealer", "It's Alive!"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Mask", 32, "Highest Sanity", "Lost"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Medallion", 36, "Missy Dubourde swimming) or highest Speed", "Better with Friends"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Photograph", 89, "Lowest Sanity", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Ring", 41, "Haunt revealer", "Invisible Traitor"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Rope",82, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Skull", 37, "Lowest Might", "Checkmate"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Spear", 39, " Highest Speed (except for the haunt revealer)", "The Heir"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Spirit Board", 2, "Haunt Revealer", "The Séance"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Kitchen", "Vial", 80, "Highest Knowledge", "[Hauntname missing]"]
    );
  }
  CreateMasterBedroomEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Bite", 35, "Highest Knowledge", "Small Change"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Bloodstone",98, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Book", 29, "Haunt revealer", "Frankenstein’s Legacy"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Box",98, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Cat",98, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Crystal Ball", 27, "Highest Knowledge (except for the haunt revealer)", "Amok Flesh"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Dog", 5, "Haunt revealer", "I Was a Teenage Lycanthrope"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Girl", 16, "Left of the haunt revealer", "The Phantom’s Embrace"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Holy Symbol", 6, "Lowest Sanity", "The Floating Eye"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Key",90, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Letter", 54, "Highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Madman", 10, "Haunt revealer", "Family Gathering"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Mask", 35, "Highest Knowledge", "Small Change"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Medallion", 44, "Youngest explorer (except for the haunt revealer)", "Death Doth Find Us All"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Photograph", 76, "Oldest explorer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Ring", 20, "Vivian Lopez (old movies) or highest Knowledge", "Ghost Bride"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Rope",82, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Skull", 47, "Haunt revealer", "Worm Ouroboros"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Spear", 43, "Haunt revealer", "A Gathering of Shadows"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Spirit Board", 2, "Haunt Revealer", "The Séance"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Master Bedroom", "Vial",98, "Haunt revealer", "[Hauntname missing]"]
    );
  }
  CreateNurseryEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Bite",74, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Bloodstone", 67, "Peter Akimoto (Basketball) or highest Speed", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Book", 95, "Oldest player (not necessarily oldest explorer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Box", 99, "None (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Cat",74, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Crystal Ball", 84, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Dog",72, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Girl", 58, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Holy Symbol", 66, "Oldest male explorer or, if none, oldest explorer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Key", 68, "Jenny LeClerc (Reading) or highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Letter", 87, "Youngest explorer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Madman",74, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Mask",74, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Medallion", 95, "Oldest player (not necessarily oldest explorer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Photograph", 95, "Oldest player (not necessarily oldest explorer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Ring", 85, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Rope",86, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Skull", 73, "Ox Bellows (Shiny Objetcs) or highest Might", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Spear", 65, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Spirit Board", 95, "Oldest player (not necessarily oldest explorer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Nursery", "Vial", 80, "Highest Knowledge", "[Hauntname missing]"]
    );
  }
  CreatePentagramChamberEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Bite", 26, "Left of the haunt revealer", "Pay the Piper"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Bloodstone", 59, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Book", 50, "Haunt revealer", "A Little Night Murder"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Box", 61, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Cat",81, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Crystal Ball", 32, "Highest Sanity", "Lost"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Dog", 50, "Haunt revealer", "A Little Night Murder"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Girl", 26, "Left of the haunt revealer", "Pay the Piper"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Holy Symbol", 26, "Left of the haunt revealer", "Pay the Piper"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Key",81, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Letter", 83, "None (see Secrets of Survival)", "[Haunname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Madman", 45, "Highest Knowledge (except for the haunt revealer)", "Tick, Tick, Tick"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Mask", 14, "Haunt revealer", "The Stars Are Right"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Medallion", 14, "Haunt revealer", "The Stars Are Right"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Photograph", 94, "Explorer with the most items that can be stolen or traded", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Ring", 26, "Left of the haunt revealer", "Pay the Piper"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Rope",81, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Skull", 14, "Haunt revealer", "The Stars Are Right"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Spear", 50, "Haunt revealer", "A Little Night Murder"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Spirit Board", 40, "Left of the haunt revealer", "Buried Alive"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Pentagram Chamber", "Vial",81, "Haunt revealer", "[Hauntname missing]"]
    );
  }
  CreateRookeryEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Bite", 97, "Hidden traitor (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Bloodstone", 93, "Highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Book", 93, "Highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Box", 57, "None (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Cat", 57, "None (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Crystal Ball", 93, "Highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Dog", 57, "None (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Girl", 58, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Holy Symbol", 66, "Oldest male explorer or, if none, oldest explorer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Key", 93, "Highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Letter", 87, "Youngest explorer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Madman", 56, "Explorer with the most total items and omens", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Mask", 57, "None (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Medallion", 77, "Professor Longfellow (Gaelic Music) or highest Speed", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Photograph", 94, "Explorer with the most items that can be stolen or traded", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Ring", 85, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Rope",86, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Skull", 73, "Ox Bellows (Shiny Objetcs) or highest Might", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Spear", 65, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Spirit Board", 64, "Everyone except the highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Rookery", "Vial", 70, "Oldest explorer", "[Hauntname missing]"]
    );
  }
  CreateServantsQuartersEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Bite", 35, "Highest Knowledge", "Small Change"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Bloodstone", 59, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Book", 29, "Haunt revealer", "Frankenstein’s Legacy"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Box", 52, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Cat", 60, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Crystal Ball", 11, "None", "Fleshwalkers"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Dog", 5, "Haunt revealer", "I Was a Teenage Lycanthrope"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Girl", 30, "Haunt revealer", "Tomb of Dracula"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Holy Symbol", 9, "None (at first)", "The Dance of Death"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Key", 68, "Jenny LeClerc (Reading) or highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Letter", 54, "Highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Madman", 31, "Left of the haunt revealer", "It's Alive!"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Mask", 42, "Highest Might", "Comes the Hero"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Medallion", 21, "Oldest explorer (except for the haunt revealer)", "House of the Living Dead"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Photograph", 94, "Explorer with the most items that can be stolen or traded", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Ring", 28, "Highest Knowledge (except for the haunt revealer)", "Ring of King Solomon"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Rope", 71, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Skull", 34, "Professor Longfellow drama) or highest Speed", "Mad, Mad World"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Spear", 15, "Lowest Speed (except for the haunt revealer", "Here There Be Dragons"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Spirit Board", 8, "Haunt revealer", "Wail of the Banshee"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Servant\"s Quarters", "Vial", 80, "Highest Knowledge", "[Hauntname missing]"]
    );
  }
  CreateStudyEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Bite", 97, "Hidden traitor (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Bloodstone", 59, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Book", 78, "Lowest Sanity (except for the haunt revealer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Box", 99, "None (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Cat", 79, "Left and right of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Crystal Ball", 84, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Dog",72, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Girl", 58, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Holy Symbol", 78, "Lowest Sanity (except for the haunt revealer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Key",90, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Letter", 78, "Lowest Sanity (except for the haunt revealer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Madman", 56, "Explorer with the most total items and omens", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Mask", 78, "Lowest Sanity (except for the haunt revealer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Medallion", 77, "Professor Longfellow (Gaelic Music) or highest Speed", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Photograph", 76, "Oldest explorer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Ring", 85, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Rope",82, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Skull", 73, "Ox Bellows (Shiny Objetcs) or highest Might", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Spear", 65, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Spirit Board", 64, "Everyone except the highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Study", "Vial", 70, "Oldest explorer", "[Hauntname missing]"]
    );
  }
  CreateTheaterEntries(Database db) async {
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Bite", 97, "Hidden traitor (see Secrets of Survival)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Bloodstone", 62, "Darrin “Flash” Williams (Shakespearean Literature) or highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Book", 51, "Everyone except the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Box", 63, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Cat", 60, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Crystal Ball", 84, "Left of the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Dog",72, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Girl", 58, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Holy Symbol", 66, "Oldest male explorer or, if none, oldest explorer)", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Key", 68, "Jenny LeClerc (Reading) or highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Letter", 51, "Everyone except the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Madman", 56, "Explorer with the most total items and omens", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Mask", 62, "Darrin “Flash” Williams (Shakespearean Literature) or highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Medallion", 77, "Professor Longfellow (Gaelic Music) or highest Speed", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Photograph", 51, "Everyone except the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Ring", 51, "Everyone except the haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Rope", 69, "Haunt revealer", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Skull", 62, "Darrin “Flash” Williams (Shakespearean Literature) or highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Spear", 62, "Darrin “Flash” Williams (Shakespearean Literature) or highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Spirit Board", 64, "Everyone except the highest Knowledge", "[Hauntname missing]"]
    );
    await db.execute(
        "INSERT INTO Haunts ('room', 'omen', 'hauntNumber', 'traitorProperties', 'hauntName') values(?,?,?,?,?)",
        ["Theater", "Vial", 62, "Darrin “Flash” Williams (Shakespearean Literature) or highest Knowledge", "[Hauntname missing]"]
    );
  }
}