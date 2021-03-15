import 'package:financial_app/common/Widgets/CustomTextField.dart';
import 'package:financial_app/common/Widgets/ModalWindow.dart';
import 'package:financial_app/models/goals/Goal.dart';
import 'package:financial_app/models/goals/GoalsModel.dart';
import 'package:financial_app/common/formats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateGoalDialog extends StatelessWidget {
  String _goalLabel;
  int _goalValue;
  @override
  Widget build(BuildContext context) {
    return ModalWindow(
      buttonLabel: "Добавить",
      label: "Цель",
      tapHandler: () {
        if (_goalLabel == null || _goalValue == null) {
          return;
        }
        context.read<GoalsModel>().addGoal(
            Goal(label: _goalLabel, total: _goalValue, accumulations: 0));
        Navigator.pop(context);
      },
      child: Column(
        children: [
          CustomTextField.label(
              onChanged: (String newData) => _goalLabel = newData.inCaps),
          SizedBox(
            height: 10,
          ),
          CustomTextField.sum(
            onChanged: (newData) => _goalValue = int.parse(newData),
          )
        ],
      ),
    );
  }
}
