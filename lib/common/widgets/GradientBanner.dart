import 'package:financial_app/common/styles.dart';
import 'package:flutter/material.dart';

class GradientBanner extends StatelessWidget {
  final Widget child;

  GradientBanner({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          gradient: getGradient(),
          borderRadius: BorderRadius.all(getRadius()),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.4),
              spreadRadius: 0,
              offset: Offset(7, 7),
            )
          ]),
      child: Padding(padding: EdgeInsets.all(15), child: child),
    );
  }
}
