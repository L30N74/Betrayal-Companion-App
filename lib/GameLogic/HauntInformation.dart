
import 'package:betrayalcompanionapp/GameLogic/Character.dart';

class HauntInformation {
  String omen;
  String room;
  final String hauntName;
  final String traitorProperties;
  final int hauntNumber;
  final int pageNumber;
  final Character traitor;


  HauntInformation({this.hauntName, this.hauntNumber, this.pageNumber, this.traitor, this.traitorProperties});
}