import 'package:financial_app/common/Styles.dart';
import 'package:flutter/material.dart';

class GradientActionButton extends StatelessWidget {
  final Function tapHandler;
  final double _buttonSize = 60;

  GradientActionButton({@required this.tapHandler});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: this.tapHandler,
      child: Container(
        height: _buttonSize,
        width: _buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: getGradient(),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
