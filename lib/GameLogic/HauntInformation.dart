import 'Room.dart';
import 'Omen.dart';

class HauntInformation {
  Omen omen;
  Room room;
  String hauntName;
  String traitorProperties;
  String hauntNumber;

  HauntInformation({this.hauntName, this.hauntNumber, this.traitorProperties});

  HauntInformation.empty() {
    omen = new Omen.custom("Bite");
    room = new Room.custom("Abandoned Room");
    hauntName = "[Not yet defined]";
    hauntNumber = "0";
    traitorProperties = "[Not yet defined]";
  }
}