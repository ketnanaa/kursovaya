import 'package:financial_app/common/styles.dart';
import 'package:financial_app/common/widgets/GradientActionButton.dart';
import 'package:financial_app/models/AppModel.dart';
import 'package:financial_app/models/goals/GoalsModel.dart';
import 'package:financial_app/navigation/CustomAppBar.dart';
import 'package:financial_app/navigation/CustomNavBar.dart';
import 'package:financial_app/screens/GoalsScreen/CreateGoalDialog.dart';
import 'package:financial_app/screens/GoalsScreen/GoalsScreen.dart';
import 'package:financial_app/screens/HomeScreen/HomeScreen.dart';
import 'package:financial_app/screens/StatsScreen/StatsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navigation extends StatelessWidget {
  final List<Widget> _pageWidgetsList = [
    HomeScreen(),
    GoalsScreen(),
    Placeholder(),
    StatsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    AppModel _appModel = context.watch<AppModel>();

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
      null,
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
