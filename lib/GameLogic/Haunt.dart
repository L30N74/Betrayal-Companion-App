class Haunt {
  final int id;
  final String room;
  final String omen;
  final int hauntNumber;
  final String traitorProperties;
  final String hauntName;
  static final columns = ["id", "room", "omen", "number", "traitorProperties", "hauntName"];

  Haunt(this.id, this.room, this.omen, this.hauntNumber, this.traitorProperties, this.hauntName);

  factory Haunt.fromMap(Map<String, dynamic> data) {
    return Haunt(
      data['id'],
      data['room'],
      data['omen'],
      data['hauntNumber'],
      data['traitorProperties'],
      data['hauntName']
    );
  }
  Map<String, dynamic> toMap() => {
    "id": id,
    "room": room,
    "omen": omen,
    "hauntNumber": hauntNumber,
    "traitorProperties": traitorProperties,
    "hauntName": hauntName
  };
}