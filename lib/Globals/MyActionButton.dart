import 'package:flutter/material.dart';

class MyActionButton extends StatelessWidget {
  Text _text;
  Function _press;

  MyActionButton(this._text, this._press);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: this._text,
      onPressed: this._press,
    );
  }
}