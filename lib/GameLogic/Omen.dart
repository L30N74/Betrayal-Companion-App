class Omen {
  final int id;
  final String name;
  final bool isExpansion;
  static final columns = ["id", "name", "isExpansion"];

  Omen(this.id, this.name, this.isExpansion);

  factory Omen.fromMap(Map<String, dynamic> data) {
    return Omen(
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