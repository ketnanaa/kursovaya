import 'package:financial_app/screens/GoalsScreen/AchivedGoalsList.dart';
import 'package:financial_app/screens/GoalsScreen/CurrentGoalsList.dart';
import 'package:flutter/material.dart';

class GoalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(flex: 14, child: CurrentGoalsList()),
        Spacer(),
        Expanded(flex: 14, child: AchivedGoalsList()),
        Spacer(),
      ],
    );
  }
}
