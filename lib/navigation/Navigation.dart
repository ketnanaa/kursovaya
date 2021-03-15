import 'package:financial_app/common/styles.dart';
import 'package:financial_app/common/widgets/GradientActionButton.dart';
import 'package:financial_app/models/AppModel.dart';
import 'package:financial_app/models/debts/DebtsModel.dart';
import 'package:financial_app/models/goals/GoalsModel.dart';
import 'package:financial_app/navigation/CustomAppBar.dart';
import 'package:financial_app/navigation/CustomNavBar.dart';
import 'package:financial_app/screens/DebtsScreen/CreateDebtDialog.dart';
import 'package:financial_app/screens/DebtsScreen/DebtsScreen.dart';
import 'package:financial_app/screens/GoalsScreen/CreateGoalDialog.dart';
import 'package:financial_app/screens/GoalsScreen/GoalsScreen.dart';
import 'package:financial_app/screens/HomeScreen/HomeScreen.dart';
import 'package:financial_app/screens/StatsScreen/StatsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * Виджет для управления сменой экранов,
 * использует AppModel как источник данных о текущем состоянии
 */
class Navigation extends StatelessWidget {
  /**
   * Массив виджетов экранов приложения
   */
  final List<Widget> _pageWidgetsList = [
    HomeScreen(),
    GoalsScreen(),
    DebtsScreen(),
    StatsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    AppModel _appModel = context.watch<AppModel>();

    /**
     * Массив виджетов ActionButton для каждого экрана
     */
    final List<Widget> _pageActionButtonsList = [
      null,
      GradientActionButton(tapHandler: () {
        showDialog(
            context: context,
            builder: (_) => ChangeNotifierProvider<GoalsModel>.value(
                  value: Provider.of<GoalsModel>(context, listen: false),
                  child: CreateGoalDialog(),
                ));
      }),
      GradientActionButton(
        tapHandler: () {
          showDialog(
              context: context,
              builder: (_) => ChangeNotifierProvider<DebtsModel>.value(
                    value: Provider.of<DebtsModel>(context, listen: false),
                    child: CreateDebtDialog(),
                  ));
        },
      ),
      null
    ];

    Widget _getActionButton(int pageIndex) => _pageActionButtonsList[pageIndex];

    return Scaffold(
        floatingActionButton: _getActionButton(_appModel.currentScreenIndex),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: CustomAppBar(
          label: _appModel.currentScreenLabel,
        ),
        bottomNavigationBar: CustomNavBar(),
        body:
            wrapScreen(screen: _pageWidgetsList[_appModel.currentScreenIndex]));
  }
}
