class Room {
  final int id;
  final String name;
  final bool isExpansion;
  static final columns = ["id", "name", "isExpansion"];

  Room(this.id, this.name, this.isExpansion);

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