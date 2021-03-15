import 'package:flutter/material.dart';

Radius getRadius() => Radius.circular(20.0);

Gradient getGradient() => LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Colors.indigo[700], Colors.pink[300]]);

Padding wrapScreen({Widget screen}) => Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: screen,
    );
