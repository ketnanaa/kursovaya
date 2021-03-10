import 'package:hive/hive.dart';

part 'DebtType.g.dart';

@HiveType(typeId: 1)
enum DebtType {
  @HiveField(0)
  deposit,
  @HiveField(1)
  loan
}
