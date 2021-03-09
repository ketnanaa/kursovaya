import 'package:financial_app/common/formats.dart';
import 'package:financial_app/common/widgets/GradientBanner.dart';
import 'package:flutter/material.dart';

class Balance extends StatelessWidget {
  final String label;
  final int balance;
  final TextStyle _subtitleTextStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w300);
  final TextStyle _titleTextStyle =
      TextStyle(fontSize: 40, fontWeight: FontWeight.w300);

  Balance({
    @required this.label,
    @required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return GradientBanner(
        child: Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            this.label,
            style: _subtitleTextStyle,
          ),
        ),
        Center(
          child: Text(
            getMoneyFormat(balance),
            style: _titleTextStyle,
          ),
        )
      ],
    ));
  }
}
