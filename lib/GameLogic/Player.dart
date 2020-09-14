import "Stats.dart";

class Player {
  String name;
  String hobbies;
  int age;
  int weight;
  double height;
  DateTime birthday;
  Stats stats;

  Player(String _name, String _hobbies, int _age, int _weight, double _height, DateTime _birthday, Stats _stats) {
    this.name = _name;
    this.hobbies = _hobbies;
    this.age = _age;
    this.weight = _weight;
    this.height = _height;
    this.birthday = _birthday;
    this.stats = _stats;
  }
}
