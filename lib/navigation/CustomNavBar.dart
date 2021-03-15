import 'package:financial_app/models/AppModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavBar extends StatelessWidget {
  final double _iconSize = 25;

  @override
  Widget build(BuildContext context) {
    AppModel _appModel = context.watch<AppModel>();
    return BottomNavigationBar(
      selectedItemColor: Colors.pink[300],
      iconSize: _iconSize,
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            label: _appModel.currentScreenLabel,
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            backgroundColor: Theme.of(context).primaryColor),
        BottomNavigationBarItem(
            label: _appModel.currentScreenLabel,
            icon: Icon(Icons.turned_in_not),
            activeIcon: Icon(Icons.turned_in),
            backgroundColor: Theme.of(context).primaryColor),
        BottomNavigationBarItem(
            label: _appModel.currentScreenLabel,
            icon: Icon(Icons.group_outlined),
            activeIcon: Icon(Icons.group),
            backgroundColor: Theme.of(context).primaryColor),
        BottomNavigationBarItem(
            label: _appModel.currentScreenLabel,
            icon: Icon(Icons.insert_chart_outlined),
            activeIcon: Icon(Icons.insert_chart),
            backgroundColor: Theme.of(context).primaryColor),
      ],
      currentIndex: _appModel.currentScreenIndex,
      onTap: (int index) {
        _appModel.changeScreen(index);
      },
    );
  }
}
