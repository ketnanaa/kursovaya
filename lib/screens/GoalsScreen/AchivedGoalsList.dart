import 'package:financial_app/common/constants.dart';
import 'package:financial_app/common/Widgets/ListItem.dart';
import 'package:financial_app/models/goals/Goal.dart';
import 'package:financial_app/models/goals/GoalsModel.dart';
import 'package:financial_app/screens/HomeScreen/Widgets/ListHeader.dart';
import 'package:financial_app/common/formats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AchivedGoalsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GoalsModel _goalsModel = context.watch<GoalsModel>();
    List<Goal> _goals = _goalsModel.achivedGoals;

    Function _onDismiss(String label) {
      _goalsModel.removeGoal(label);
    }

    return Column(
      children: [
        Expanded(flex: 3, child: ListHeader(label: "ЗАВЕРШЕННЫЕ")),
        Expanded(
            flex: 9,
            child: _goals.length != 0
                ? ListView(
                    children: _goals
                        .map((goal) => ListItem(
                              title: goal.label,
                              value: "${getMoneyFormat(goal.total)}",
                              onDismiss: (DismissDirection dir) {
                                _onDismiss(goal.label);
                              },
                            ))
                        .toList(),
                  )
                : Align(
                    child: Text(emptyListLabel,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w200)),
                  ))
      ],
    );
  }
}
