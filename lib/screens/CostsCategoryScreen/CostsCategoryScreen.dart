import 'package:financial_app/common/constants.dart';
import 'package:financial_app/common/formats.dart';
import 'package:financial_app/common/styles.dart';
import 'package:financial_app/common/Widgets/CustomTextField.dart';
import 'package:financial_app/common/Widgets/GradientActionButton.dart';
import 'package:financial_app/common/Widgets/ListItem.dart';
import 'package:financial_app/common/Widgets/ModalWindow.dart';
import 'package:financial_app/common/widgets/CustomDateField.dart';
import 'package:financial_app/models/costs/Cost.dart';
import 'package:financial_app/models/costs/CostsModel.dart';
import 'package:financial_app/navigation/CustomAppBar.dart';
import 'package:financial_app/screens/HomeScreen/Balance/BalanceBanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CostsCategoryScreen extends StatelessWidget {
  String currentCategoryLabel;

  CostsCategoryScreen({@required this.currentCategoryLabel});

  Widget _getCostListItem(BuildContext context, Cost cost, List<Cost> costs,
          CostsModel costsModel) =>
      ListItem(
        title: cost.label,
        subtitle: getDateFormat().format(cost.date),
        value: getMoneyFormat(cost.value),
        onDismiss: (DismissDirection dir) {
          costsModel.removeCost(currentCategoryLabel, costs.indexOf(cost));
        },
      );

  Widget _getCostDialog(BuildContext context, String categoryLabel) {
    String costLabel;
    int costValue;
    DateTime costDate;
    return ModalWindow(
      buttonLabel: "Добавить",
      tapHandler: () {
        if (costLabel == null || costValue == null || costDate == null) {
          return;
        }
        context.read<CostsModel>().addCost(categoryLabel,
            Cost(label: costLabel, value: costValue, date: costDate));
        Navigator.pop(context);
      },
      child: Column(
        children: [
          CustomTextField.label(
              onChanged: (String newData) => costLabel = newData.inCaps),
          SizedBox(
            height: 10,
          ),
          CustomTextField.sum(
              onChanged: (newData) => costValue = int.parse(newData)),
          SizedBox(
            height: 10,
          ),
          CustomDateField(onDatePick: (DateTime date) {
            costDate = date;
          })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CostsModel _costsModel = context.watch<CostsModel>();
    List<Cost> _costs = _costsModel.costsMap[currentCategoryLabel];
    return Scaffold(
        floatingActionButton: GradientActionButton(
          tapHandler: () {
            showDialog(
                context: context,
                builder: (_) => ChangeNotifierProvider<CostsModel>.value(
                      value: Provider.of<CostsModel>(context, listen: false),
                      child: _getCostDialog(context, currentCategoryLabel),
                    ));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: CustomAppBar(
          label: currentCategoryLabel,
        ),
        body: wrapScreen(
          screen: Column(
            children: [
              Expanded(
                  flex: 8,
                  child: BalanceBanner(
                      label: "СУММА",
                      balance:
                          _costsModel.getCategorySum(currentCategoryLabel))),
              Spacer(),
              Expanded(
                flex: 29,
                child: _costs.length != 0
                    ? ListView(
                        children: _costs
                            .map((cost) => _getCostListItem(
                                context, cost, _costs, _costsModel))
                            .toList())
                    : Align(
                        child: Text(emptyListLabel,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w200)),
                      ),
              )
            ],
          ),
        ));
  }
}
