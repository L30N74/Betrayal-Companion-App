import 'package:betrayalcompanionapp/main.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          MyNavBarButton(context, Icons.add, MainPage()),
          MyNavBarButton(context, Icons.access_alarms, MainPage()),
          MyNavBarButton(context, Icons.close, MainPage()),
          MyNavBarButton(context, Icons.account_box, MainPage()),
        ],
      ),
    );
  }

  Widget MyNavBarButton(BuildContext context, IconData icon, Widget destination) {
    return MaterialButton(
      child: Icon(icon, size: 35,),
      shape: CircleBorder(),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
      },
    );
  }
}
