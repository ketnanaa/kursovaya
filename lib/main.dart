import 'dart:io';
import 'package:financial_app/models/AppModel.dart';
import 'package:financial_app/models/costs/Cost.dart';
import 'package:financial_app/models/costs/CostsModel.dart';
import 'package:financial_app/models/debts/DebtType.dart';
import 'package:financial_app/models/debts/Debt.dart';
import 'package:financial_app/models/debts/DebtsModel.dart';
import 'package:financial_app/models/goals/Goal.dart';
import 'package:financial_app/models/goals/GoalsModel.dart';
import 'package:financial_app/models/incomes/IncomesModel.dart';
import 'package:financial_app/navigation/Navigation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * Точка входа в приложение, где происходит
 * инициализация библиотеки Hive для взаимодействия с БД
 * и запускается корневой виджет FinancialApp
 */
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CostAdapter());
  Hive.registerAdapter(DebtTypeAdapter());
  Hive.registerAdapter(DebtAdapter());
  Hive.registerAdapter(GoalAdapter());
  runApp(FinancialApp());
}

/**
 * Корневой виджет приложения, регистрирует модели
 * и виджет навигации
 */
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
          ChangeNotifierProvider(create: (context) => GoalsModel()),
          ChangeNotifierProvider(create: (context) => DebtsModel()),
        ],
        child: Navigation(),
      ),
    );
  }
}
