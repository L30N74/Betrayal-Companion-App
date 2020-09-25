import "Stats.dart";

class Character {
  String name;
  String hobbies;
  int age;
  int weight;
  double height;
  DateTime birthday;
  Stats stats;
  CharacterColor color;
  String imagePath;
  bool isDead;

  Character(this.name, this.hobbies, this.age, this.weight, this.height, this.birthday, this.stats, this.color) {
    this.isDead = false;
    var nameSplits = name.split(' ');
    this.imagePath = "assets/images/characters/" + nameSplits[nameSplits.length-1]  + ".png";
  }

  void Reset() {
    this.isDead = false;
    this.stats.Reset();
  }

  void DieFromStat(String statName) {
    stats.DieFromStat(statName);
    isDead = true;
  }
}

enum CharacterColor {
  White,
  Blue,
  Purple,
  Yellow,
  Green,
  Red
}
