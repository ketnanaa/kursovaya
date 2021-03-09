import 'package:financial_app/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:financial_app/common/Formats.dart';

class DateField extends StatefulWidget {
  final Function(DateTime) onDatePick;

  DateField({@required this.onDatePick});

  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  static const HINT_TEXT = "Дата";
  DateTime _selectedDate;
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintText: HINT_TEXT,
          isDense: true,
          contentPadding: EdgeInsets.all(10),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.all(getRadius())),
          fillColor: Colors.blueGrey[700],
          filled: true),
      focusNode: AlwaysDisabledFocusNode(),
      controller: _textEditingController,
      onTap: () {
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      widget.onDatePick(_selectedDate);
      _textEditingController
        ..text = getDateFormat().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
