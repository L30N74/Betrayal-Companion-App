class Omen {
  int id;
  String name;
  bool isExpansion;
  static final columns = ["id", "name", "isExpansion"];

  Omen(this.id, this.name, this.isExpansion);

  Omen.custom(name) {
    this.name = name;

    switch(name) {
      case "Bloodstone":
      case "Box":
      case "Cat":
      case "Key":
      case "Letter":
      case "Photograph":
      case "Rope":
      case "Vial":
        this.isExpansion = true;
        break;
      default:
        this.isExpansion = false;
        break;
    }
  }

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