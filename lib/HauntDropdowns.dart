import 'package:flutter/material.dart';

class HauntOmenDropdown extends StatefulWidget {
  @override
  _HauntOmenDropdownState createState() => _HauntOmenDropdownState();
}

class _HauntOmenDropdownState extends State<HauntOmenDropdown> {
  String omenValue = Omen[0];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: omenValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 32,
      elevation: 10,
      style: TextStyle(color: Colors.white),
      onChanged: (String newOmen) {
        setState(() {
          omenValue = newOmen;
        });
      },
      items: Omen.map<DropdownMenuItem<String>>(
        (omen) => DropdownMenuItem(
          value: omen,
          child: Text(omen, style: TextStyle(fontSize: 24),),
        )
      ),
    );
  }
}

class HauntRoomDropdown extends StatefulWidget {
  @override
  _HauntRoomDropdownState createState() => _HauntRoomDropdownState();
}

class _HauntRoomDropdownState extends State<HauntRoomDropdown> {
  String roomValue = Rooms[0];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: roomValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 32,
      elevation: 10,
      style: TextStyle(color: Colors.white),
      onChanged: (String newRoom) {
        setState(() {
          roomValue = newRoom;
        });
      },
      items: Rooms.map(
        (room) => DropdownMenuItem(
          value: room,
          child: Text(room, style: TextStyle(fontSize: 24),),
        )
      ),
    );
  }
}


const List<String> Rooms = [
  "Bedroom",
  "Kitchen",
  "Hallway"
];

const List<String> Omen = [
  "Dog",
  "The Madman"
];