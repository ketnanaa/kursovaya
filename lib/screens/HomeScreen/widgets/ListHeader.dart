import 'package:financial_app/common/formats.dart';
import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  String label;
  int sum;

  ListHeader({@required this.label, this.sum});

  Widget _getLabel(String label) {
    return Align(
      alignment: sum != null ? Alignment.topLeft : Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _getSummary(int sum) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        getMoneyFormat(sum),
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: _getLabel(label)),
        if (sum != null) Expanded(flex: 1, child: _getSummary(sum))
      ],
    );
  }
}
