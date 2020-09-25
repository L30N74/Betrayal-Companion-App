import 'package:flutter/cupertino.dart';

class HauntInformation {
  String omen;
  String room;
  String hauntName;
  String traitorProperties;
  int hauntNumber;

  HauntInformation({this.hauntName, this.hauntNumber, this.traitorProperties});

  HauntInformation.empty() {
    debugPrint("New hauntionfo");
    omen = "Bite";
    room = "Abandoned Room";
    hauntName = "[Not yet defined]";
    hauntNumber = 0;
    traitorProperties = "[Not yet defined]";
  }
}