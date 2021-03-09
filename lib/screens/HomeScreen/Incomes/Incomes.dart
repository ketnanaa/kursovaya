import 'package:financial_app/common/constants.dart';
import 'package:financial_app/common/formats.dart';
import 'package:financial_app/common/Widgets/CustomTextField.dart';
import 'package:financial_app/common/Widgets/ListItem.dart';
import 'package:financial_app/common/Widgets/ModalWindow.dart';
import 'package:financial_app/common/Widgets/RoundedButton.dart';
import 'package:financial_app/models/incomes/IncomesModel.dart';
import 'package:financial_app/screens/HomeScreen/Widgets/ListHeader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Incomes extends StatelessWidget {
  Widget _getIncomeListItem(BuildContext context, MapEntry<String, int> income,
          IncomesModel incomesModel) =>
      ListItem(
          title: income.key,
          prefix: "+ ",
          value: getMoneyFormat(income.value),
          onDismiss: (DismissDirection dir) {
            incomesModel.removeIncome(income.key);
          });

  Widget _getIncomeDialog(BuildContext context) {
    String incomeLabel;
    int incomeValue;
    return ModalWindow(
      buttonLabel: "Добавить",
      label: "Доход",
      tapHandler: () {
        if (incomeLabel == null || incomeValue == null) {
          return;
        }
        context.read<IncomesModel>().addIncome(incomeLabel, incomeValue);
        Navigator.pop(context);
      },
      child: Column(
        children: [
          CustomTextField.label(
              onChanged: (String newData) => incomeLabel = newData.inCaps),
          SizedBox(
            height: 10,
          ),
          CustomTextField.sum(
              onChanged: (newData) => incomeValue = int.parse(newData))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    IncomesModel _incomesModel = context.watch<IncomesModel>();
    Map<String, int> _incomes = _incomesModel.incomesMap;
    int _incomesSum = _incomesModel.incomesSum;
    return Column(
      children: [
        Expanded(flex: 3, child: ListHeader(label: "ДОХОДЫ", sum: _incomesSum)),
        Expanded(
            flex: 9,
            child: _incomes.length != 0
                ? ListView(
                    children: _incomes.entries
                        .map((income) => this
                            ._getIncomeListItem(context, income, _incomesModel))
                        .toList(),
                  )
                : Align(
                    child: Text(emptyListLabel,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w200)),
                  )),
        Spacer(),
        RoundedButton(
          text: "+Добавить",
          tapHandler: () {
            showDialog(
                context: context,
                builder: (_) => ChangeNotifierProvider<IncomesModel>.value(
                      value: Provider.of<IncomesModel>(context, listen: false),
                      child: _getIncomeDialog(context),
                    ));
          },
        )
      ],
    );
  }
}
