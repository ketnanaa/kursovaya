import 'dart:io';
import 'package:financial_app/models/AppModel.dart';
import 'package:financial_app/models/costs/Cost.dart';
import 'package:financial_app/models/costs/CostsModel.dart';
import 'package:financial_app/models/incomes/IncomesModel.dart';
import 'package:financial_app/navigation/Navigation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CostAdapter());
  runApp(FinancialApp());
}

class FinancialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial app',
      theme: ThemeData.dark(),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppModel()),
          ChangeNotifierProvider(create: (context) => IncomesModel()),
          ChangeNotifierProvider(create: (context) => CostsModel()),
        ],
        child: Navigation(),
      ),
    );
  }
}
