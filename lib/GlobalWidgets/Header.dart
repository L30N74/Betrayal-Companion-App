import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  String text;

  Header(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          color: Colors.white
      ),
      child: Center(
        child: FittedBox(
          child: Text(
            this.text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Rock'),
              textAlign: TextAlign.center
          ),
        )
      ),
    );
  }
}
