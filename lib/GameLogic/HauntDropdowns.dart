import 'package:betrayalcompanionapp/Globals/Globals.dart';
import 'package:betrayalcompanionapp/Screens/main.dart';
import 'package:flutter/material.dart';

class HauntOmenSelection extends StatefulWidget {
  @override
  _HauntOmenSelectionState createState() => _HauntOmenSelectionState();
}

class _HauntOmenSelectionState extends State<HauntOmenSelection> {
  PageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return new HauntListView(
      listName: "Omen",
      list: Omen,
      controller: _controller,
      width: 100,
      height: 80,
    );
  }
}

class HauntRoomSelection extends StatefulWidget {
  @override
  _HauntRoomSelectionState createState() => _HauntRoomSelectionState();
}

class _HauntRoomSelectionState extends State<HauntRoomSelection> {
  PageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return new HauntListView(
      listName: "Rooms",
      list: Rooms,
      controller: _controller,
      width: 100,
      height: 80,
    );
  }
}

class HauntListView extends StatefulWidget {
  final String listName;
  final List<String> list;
  final PageController controller;
  final double height;
  final double width;

  HauntListView({this.listName, this.list, this.controller, this.height, this.width});

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

  _HauntListViewState({this.listName, this.list, this.controller, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: PageView.builder(
        controller: controller,
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        onPageChanged: (value) {
          setState(() {
            switch(listName) {
              case "Omen":
                setState(() {
                  MainPage.revealedHauntInformation.omen = Omen[value];
                });
                break;
              case "Rooms":
                setState(() {
                  MainPage.revealedHauntInformation.room = Rooms[value];
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
                  height: Curves.easeOut.transform(value) * 40,
                  width: Curves.easeOut.transform(value) * 200,
                  child: child,
                ),
              );
            },
            child: new Container(
              decoration: BoxDecoration(
                color: darkGreyColor,
              ),
              margin: const EdgeInsets.all(0.2),
              child: Center(
                  child: Text(
                    list[index],
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    textAlign: TextAlign.center,
                  )
              ),
            ),
          );
        },
      ),
    );
  }
}

const List<String> Rooms = [
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

const List<String> ExpansionRooms = [
  "Dungeon",
  "Nursery",
  "Rookery",
  "Study",
  "Theater",
];

const List<String> Omen = [
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
  "Spitit Board",
];

const List<String> ExpansionOmen = [
  "Bloodstone",
  "Box",
  "Cat",
  "Key",
  "Letter",
  "Photograph",
  "Rope",
  "Vial"
];
