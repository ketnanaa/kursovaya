import 'package:financial_app/common/Widgets/CustomDropdown.dart';
import 'package:financial_app/common/Widgets/CustomTextField.dart';
import 'package:financial_app/common/Widgets/ModalWindow.dart';
import 'package:financial_app/models/debts/Debt.dart';
import 'package:financial_app/models/debts/DebtType.dart';
import 'package:financial_app/models/debts/DebtsModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:financial_app/common/Formats.dart';

class CreateDebtDialog extends StatelessWidget {
  String _debtPerson;
  int _debtTotal;
  DebtType _debtType;
  Map<String, DebtType> _debtTypeMap = {
    "Депозит": DebtType.deposit,
    "Займ": DebtType.loan
  };
  @override
  Widget build(BuildContext context) {
    return ModalWindow(
      buttonLabel: "Добавить",
      tapHandler: () {
        if (_debtPerson == null || _debtTotal == null || _debtType == null) {
          return;
        }
        context.read<DebtsModel>().addDebt(Debt(
            person: _debtPerson,
            total: _debtTotal,
            accumulations: 0,
            debtType: _debtType));
        Navigator.pop(context);
      },
      child: Column(
        children: [
          CustomTextField(
              hintText: "ФИО",
              onChanged: (String newData) =>
                  _debtPerson = newData.capitalizeFirstofEach),
          SizedBox(
            height: 10,
          ),
          CustomTextField.sum(
            onChanged: (newData) => _debtTotal = int.parse(newData),
          ),
          SizedBox(
            height: 10,
          ),
          CustomDropdown(
            items: _debtTypeMap.keys.toList(),
            onChange: (String newValue) {
              _debtType = _debtTypeMap[newValue];
            },
          )
        ],
      ),
    );
  }
}
