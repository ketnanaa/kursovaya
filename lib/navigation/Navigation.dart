import 'package:financial_app/common/styles.dart';
import 'package:financial_app/models/AppModel.dart';
import 'package:financial_app/navigation/CustomAppBar.dart';
import 'package:financial_app/navigation/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navigation extends StatelessWidget {
  final List<Widget> _pageWidgetsList = [Placeholder()];

  @override
  Widget build(BuildContext context) {
    AppModel _appModel = context.watch<AppModel>();

    return Scaffold(
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
