import 'package:financial_app/common/constants.dart';
import 'package:financial_app/common/formats.dart';
import 'package:financial_app/common/Widgets/CustomTextField.dart';
import 'package:financial_app/common/Widgets/ListItem.dart';
import 'package:financial_app/common/Widgets/ModalWindow.dart';
import 'package:financial_app/common/Widgets/RoundedButton.dart';
import 'package:financial_app/models/costs/Cost.dart';
import 'package:financial_app/models/costs/CostsModel.dart';
import 'package:financial_app/screens/CostsCategoryScreen/CostsCategoryScreen.dart';
import 'package:financial_app/screens/HomeScreen/Widgets/ListHeader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Costs extends StatelessWidget {
  Widget _getCostCategoryListItem(BuildContext context,
          String costCategoryLabel, CostsModel costsModel) =>
      ListItem(
          title: costCategoryLabel,
          prefix: "- ",
          value: getMoneyFormat(costsModel.getCategorySum(costCategoryLabel)),
          onDismiss: (DismissDirection dir) {
            costsModel.removeCostCategory(costCategoryLabel);
          },
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider<CostsModel>.value(
                          value:
                              Provider.of<CostsModel>(context, listen: false),
                          child: CostsCategoryScreen(
                              currentCategoryLabel: costCategoryLabel),
                        )));
          });

  Widget _getCostCategoryDialog(BuildContext context) {
    String costCategoryLabel;
    return ModalWindow(
      buttonLabel: "Добавить",
      label: "Категория",
      tapHandler: () {
        if (costCategoryLabel == null) {
          return;
        }
        context.read<CostsModel>().addCostCategory(costCategoryLabel);
        Navigator.pop(context);
      },
      child: Column(
        children: [
          CustomTextField.label(
              onChanged: (String newData) => costCategoryLabel = newData.inCaps)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CostsModel _costsModel = context.watch<CostsModel>();
    Map<String, List<Cost>> _costs = _costsModel.costsMap;
    int _totalSum = _costsModel.totalCostsSum;
    return Column(
      children: [
        Expanded(flex: 3, child: ListHeader(label: "РАСХОДЫ", sum: _totalSum)),
        Expanded(
            flex: 9,
            child: _costs.length != 0
                ? ListView(
                    children: _costs.entries
                        .map((costsCategory) => _getCostCategoryListItem(
                            context, costsCategory.key, _costsModel))
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
          text: "+Добавить категорию",
          tapHandler: () {
            showDialog(
                context: context,
                builder: (_) => ChangeNotifierProvider<CostsModel>.value(
                      value: Provider.of<CostsModel>(context, listen: false),
                      child: _getCostCategoryDialog(context),
                    ));
          },
        )
      ],
    );
  }
}
