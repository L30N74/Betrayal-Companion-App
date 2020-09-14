import 'package:flutter/material.dart';

class MyNavButton extends StatelessWidget {
  Text _text;
  Widget _destination;

  MyNavButton(this._text, this._destination);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: this._text,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => this._destination));
      },
    );
  }
}