import 'package:financial_app/common/styles.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function tapHandler;
  final Color _color = Colors.blueGrey[800];
  final double _buttonHeight = 40;
  final _labelTextStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.w300);

  RoundedButton({@required this.text, @required this.tapHandler});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapHandler,
      child: Container(
          height: _buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.all(getRadius()),
          ),
          child: Center(
            child: Text(text, style: _labelTextStyle),
          )),
    );
  }
}
