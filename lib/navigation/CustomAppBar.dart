import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String label;
  final TextStyle _labelTextStyle =
      TextStyle(fontSize: 27, fontWeight: FontWeight.w300);

  CustomAppBar({@required this.label}) : preferredSize = Size.fromHeight(50.0);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(
        label.toUpperCase(),
        style: _labelTextStyle,
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
