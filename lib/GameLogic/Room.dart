class Room {
  int id;
  String name;
  bool isExpansion;
  static final columns = ["id", "name", "isExpansion"];

  Room(this.id, this.name, this.isExpansion);

  Room.custom(name) {
    this.name = name;

    switch(name) {
      case "Dungeon":
      case "Nursery":
      case "Rookery":
      case "Study":
      case "Theater":
        this.isExpansion = true;
        break;
      default:
        this.isExpansion = false;
        break;
    }
  }

  factory Room.fromMap(Map<String, dynamic> data) {
    return Room(
      data['id'],
      data["name"],
      data["isExpansion"] == 1 ? true : false
    );
  }
  
  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "isExpansion": isExpansion ? 1 : 0
  };
}