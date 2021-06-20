import 'package:betrayalcompanionapp/GlobalWidgets/Constants.dart';
import 'package:betrayalcompanionapp/GameLogic/GlobalMethods.dart';
import 'package:betrayalcompanionapp/GameLogic/Database.dart';
import 'package:betrayalcompanionapp/GameLogic/Room.dart';
import 'package:betrayalcompanionapp/GameLogic/Omen.dart';
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
    List<String> omen = new List<String>();
    GetOmenList().then(
            (onValue) => onValue.forEach((e) => omen.add(e))).catchError((onError) {
      throw new Exception(onError);
    });


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

    List<String> rooms = new List<String>();
    GetRoomsList().then(
            (onValue) => onValue.forEach((e) => rooms.add(e))).catchError((onError) {
      throw new Exception(onError);
    });


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
