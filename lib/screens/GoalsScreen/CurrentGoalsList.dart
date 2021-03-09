import 'package:financial_app/common/constants.dart';
import 'package:financial_app/common/formats.dart';
import 'package:financial_app/common/Widgets/CustomTextField.dart';
import 'package:financial_app/common/Widgets/ListItem.dart';
import 'package:financial_app/common/Widgets/ModalWindow.dart';
import 'package:financial_app/models/goals/Goal.dart';
import 'package:financial_app/models/goals/GoalsModel.dart';
import 'package:financial_app/screens/HomeScreen/Widgets/ListHeader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentGoalsList extends StatelessWidget {
  Widget _getReplanishAccDialog(BuildContext context, String goalLabel) {
    int value;
    return ModalWindow(
      buttonLabel: "Пополнить",
      tapHandler: () {
        if (value == null) {
          return;
        }
        context.read<GoalsModel>().replenishAccumulations(goalLabel, value);
        Navigator.pop(context);
      },
      child: Column(
        children: [
          CustomTextField.sum(
              onChanged: (newData) => value = int.parse(newData))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    GoalsModel _goalsModel = context.watch<GoalsModel>();
    List<Goal> _goals = _goalsModel.currentGoals;

    Function _onTap(String label) {
      showDialog(
          context: context,
          builder: (_) => ChangeNotifierProvider<GoalsModel>.value(
                value: Provider.of<GoalsModel>(context, listen: false),
                child: _getReplanishAccDialog(context, label),
              ));
    }

    return Column(
      children: [
        Expanded(flex: 3, child: ListHeader(label: "ТЕКУЩИЕ")),
        Expanded(
            flex: 9,
            child: _goals.length != 0
                ? ListView(
                    children: _goals
                        .map((goal) => ListItem(
                              title: goal.label,
                              value:
                                  "${getMoneyFormat(goal.accumulations)}/${getMoneyFormat(goal.total)}",
                              onDismiss: (DismissDirection dir) {
                                if (dir == DismissDirection.endToStart) {
                                  _goalsModel.achieveGoal(goal.label);
                                } else {
                                  _goalsModel.removeGoal(goal.label);
                                }
                              },
                              onTap: () {
                                _onTap(goal.label);
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
