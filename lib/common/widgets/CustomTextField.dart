import 'package:financial_app/common/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String hintText;
  bool isNumber;
  Function onChanged;

  CustomTextField(
      {@required this.hintText,
      @required this.onChanged,
      this.isNumber = false});

  CustomTextField.sum({@required this.onChanged}) {
    this.hintText = "Сумма";
    this.isNumber = true;
  }

  CustomTextField.label({@required this.onChanged}) {
    this.hintText = "Название";
    this.isNumber = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: this.isNumber ? TextInputType.number : TextInputType.text,
      onChanged: this.onChanged,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintText: this.hintText,
          isDense: true,
          contentPadding: EdgeInsets.all(10),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.all(getRadius())),
          fillColor: Colors.blueGrey[700],
          filled: true),
    );
  }
}
