import 'package:charts_flutter/flutter.dart' as charts;
import 'package:financial_app/common/Formats.dart';
import 'package:financial_app/models/costs/CostsModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatelessWidget {
  List<charts.Series<CostCategory, String>> _createSeriesList(
      List<CostCategory> costCategorysList) {
    const int numberOfColors = 3;
    return [
      charts.Series<CostCategory, String>(
        id: 'Costs',
        domainFn: (CostCategory costCategory, _) => costCategory.label,
        measureFn: (CostCategory costCategory, _) => costCategory.categorySum,
        colorFn: (_, index) {
          return charts.MaterialPalette.pink.makeShades(numberOfColors)[index];
        },
        data: costCategorysList,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    CostsModel _costsModel = context.watch<CostsModel>();
    List<CostCategory> _costCategorysList = _costsModel.costCategorysList;
    int _totalSum = _costsModel.totalCostsSum;

    return _costCategorysList.length != 0 && _totalSum != 0
        ? Stack(children: [
            charts.PieChart(_createSeriesList(_costCategorysList),
                defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 60,
                    arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                          labelPosition: charts.ArcLabelPosition.inside),
                    ])),
            Center(
              child: Text(
                getMoneyFormat(_totalSum),
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
              ),
            )
          ])
        : Align(
            child: Text("Расходы отсутствуют",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w200)),
          );
  }
}
