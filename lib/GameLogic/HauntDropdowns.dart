import 'package:betrayalcompanionapp/GameLogic/GlobalMethods.dart';
import 'package:betrayalcompanionapp/GlobalWidgets/Constants.dart';
import 'package:betrayalcompanionapp/GameLogic/Database.dart';
import 'package:flutter/material.dart';

class HauntDropdown extends StatefulWidget {
  final HauntDecisions listName;

  HauntDropdown(this.listName);

  @override
  _HauntDropDownState createState() => _HauntDropDownState(this.listName);

}

class _HauntDropDownState extends State<HauntDropdown> {
  final HauntDecisions listName;

  String _selected;

  _HauntDropDownState(this.listName);

  @override
  Widget build(BuildContext context) {

    Future future = listName == HauntDecisions.Room ? GetRoomsList() : GetOmenList();
    Text hintText = new Text(listName == HauntDecisions.Room ? "Which Room?" : "Which Omen?" , style: hauntDropdownsTextStyle,);

    return Container(
      width: 300,
      height: 40,
      child: FutureBuilder<List<String>>(
        future: future,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          else if(snapshot.hasData) {
            return Theme(
              data: Theme.of(context).copyWith(
                canvasColor: darkGreyColor,
              ),
              child: DropdownButton(
                hint: Center(child: hintText),
                value: _selected,
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                onChanged: (newValue) =>
                    setState(() {
                      _selected = newValue;
                      if(listName == HauntDecisions.Room) Logic.revealedHauntInformation.room = newValue;
                      else Logic.revealedHauntInformation.omen = newValue;
                    }),
                items: snapshot.data.map<DropdownMenuItem<String>>((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Center(child: Text(item, style: hauntDropdownsTextStyle, textAlign: TextAlign.center,)),
                  );
                }).toList(),
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}


Future<List<String>> GetRoomsList() async {
  List<String> rooms = await SQLiteDbProvider.db.getAllRooms().catchError((onError) {
    throw new Exception(onError);
  });

  rooms.sort();
  return rooms;
}

Future<List<String>> GetOmenList() async {
  List<String> omen = await SQLiteDbProvider.db.getAllOmen().catchError((onError) {
    throw new Exception(onError);
  });

  omen.sort();
  return omen;
}

enum HauntDecisions {
  Room,
  Omen
}
