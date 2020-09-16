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

  Character(String _name, String _hobbies, int _age, int _weight, double _height, DateTime _birthday, Stats _stats , CharacterColor _color) {
    this.name = _name;
    this.hobbies = _hobbies;
    this.age = _age;
    this.weight = _weight;
    this.height = _height;
    this.birthday = _birthday;
    this.stats = _stats;
    this.color = _color;

    var nameSplits = name.split(' ');
    this.imagePath = "assets/images/" + nameSplits[nameSplits.length-1]  + ".png";
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
