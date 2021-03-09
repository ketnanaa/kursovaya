// import 'package:financial_app/screens/HomeScreen/Widgets/Balance/TotalBalance.dart';
// import 'package:financial_app/screens/HomeScreen/Widgets/Costs/Costs.dart';
// import 'package:financial_app/screens/HomeScreen/Widgets/Incomes/Incomes.dart';
import 'package:financial_app/screens/HomeScreen/Incomes/Incomes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(flex: 8, child: Placeholder()),
        Expanded(flex: 14, child: Incomes()),
        Spacer(),
        Expanded(flex: 14, child: Placeholder()),
        Spacer(),
      ],
    );
  }
}
