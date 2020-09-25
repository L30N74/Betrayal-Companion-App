import 'package:betrayalcompanionapp/GameLogic/Database.dart';
import 'package:betrayalcompanionapp/GameLogic/HauntInformation.dart';
import 'package:betrayalcompanionapp/GlobalWidgets/Constants.dart';
import 'package:betrayalcompanionapp/GameLogic/GlobalMethods.dart';
import 'package:flutter/material.dart';

class HauntOmenSelection extends StatefulWidget {
  double width;
  double height;
  EdgeInsets margin;

  HauntOmenSelection({this.width, this.height, this.margin});

  @override
  _HauntOmenSelectionState createState() => _HauntOmenSelectionState(width, height, margin);
}

class _HauntOmenSelectionState extends State<HauntOmenSelection> {
  double width;
  double height;
  EdgeInsets margin;

  _HauntOmenSelectionState(this.width, this.height, this.margin);

  PageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    List<String> omen = Omen;

    if(Logic.useExpansion) {
      omen.addAll(ExpansionOmen);
      omen.sort();
    }

    return new HauntListView(
      listName: "Omen",
      list: omen,
      controller: _controller,
      width: width,
      height: height,
    );
  }
}

class HauntRoomSelection extends StatefulWidget {
  double width;
  double height;
  EdgeInsets margin;

  HauntRoomSelection({this.width, this.height, this.margin});

  @override
  _HauntRoomSelectionState createState() => _HauntRoomSelectionState(width, height, margin);
}

class _HauntRoomSelectionState extends State<HauntRoomSelection> {
  final double width;
  final double height;
  final EdgeInsets margin;

  _HauntRoomSelectionState(this.width, this.height, this.margin);

  PageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    List<String> rooms = Rooms;

    if(Logic.useExpansion) {
      rooms.addAll(ExpansionRooms);
      rooms.sort();
    }

    return new HauntListView(
      listName: "Rooms",
      list: rooms,
      controller: _controller,
      width: width,
      height: height,
    );
  }
}

class HauntListView extends StatefulWidget {
  final String listName;
  final List<String> list;
  final PageController controller;
  final double height;
  final double width;
  final EdgeInsets margin;

  HauntListView({this.listName, this.list, this.controller, this.height, this.width, this.margin});

  @override
  _HauntListViewState createState() => _HauntListViewState(
    listName: listName,
    list: list,
    controller: controller,
    height: height,
    width: width
  );
}

class _HauntListViewState extends State<HauntListView> {
  final String listName;
  final List<String> list;
  final PageController controller;
  final double height;
  final double width;
  final EdgeInsets margin;

  _HauntListViewState({this.listName, this.list, this.controller, this.height, this.width, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height*1.5,
      child: PageView.builder(
        controller: controller,
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        onPageChanged: (value) {
          setState(() {
            switch(listName) {
              case "Omen":
                setState(() {
                  Logic.revealedHauntInformation.omen = list[value];
                });
                break;
              case "Rooms":
                setState(() {
                  Logic.revealedHauntInformation.room = list[value];
                });
                break;
            }
          });
        },
        itemBuilder: (context, index) {
          return new AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              double value = 1.0;
              if(controller.position.haveDimensions) {
                value = controller.page - index;
                value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
              }
              return new Center(
                child: new SizedBox(
                  height: Curves.easeOut.transform(value) * 50,
                  width: Curves.easeOut.transform(value) * 200,
                  child: child,
                ),
              );
            },
            child: new Container(
              decoration: BoxDecoration(
                color: darkGreyColor,
                borderRadius: BorderRadius.all(Radius.circular(50),
                ),
              ),
              child: Center(child: Text(list[index], style: hauntDropdownsTextStyle)),
            ),
          );
        },
      ),
    );
  }
}

Future<List<String>> GetRoomsList() async {
  await SQLiteDbProvider.db.getAllHaunts().then(
      (haunts) {
    List<String> rooms = new List();
    haunts.forEach((element) => rooms.add(element.room));
    return rooms;
  }).catchError((onError) {
    throw new Exception(onError);
  });
}

Future<List<String>> GetOmenList() async {
  await SQLiteDbProvider.db.getAllHaunts().then(
    (haunts) {
      List<String> omen = new List();
      haunts.forEach((element) => omen.add(element.omen));
      return omen;
    }).catchError((onError) {
      throw new Exception(onError);
  });
}

List<String> Rooms = [
  "Abandoned Room",
  "Balcony",
  "Catacombs",
  "Charred Room",
  "Dining Room",
  "Furnace Room",
  "Gallery",
  "Gymnasium",
  "Junk Room",
  "Kitchen",
  "Master Bedroom",
  "Pentagram Chamber",
  "Servant's Quarters",
];

List<String> ExpansionRooms = [
  "Dungeon",
  "Nursery",
  "Rookery",
  "Study",
  "Theater",
];

List<String> Omen = [
  "Bite",
  "Book",
  "Crystal Ball",
  "Dog",
  "Girl",
  "Holy Symbol",
  "Madman",
  "Mask",
  "Medallion",
  "Ring",
  "Skull",
  "Spear",
  "Spirit Board",
];

List<String> ExpansionOmen = [
  "Bloodstone",
  "Box",
  "Cat",
  "Key",
  "Letter",
  "Photograph",
  "Rope",
  "Vial"
];
