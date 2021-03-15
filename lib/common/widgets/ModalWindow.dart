import 'package:financial_app/common/styles.dart';
import 'package:flutter/material.dart';

class ModalWindow extends StatelessWidget {
  final String label;
  final String buttonLabel;
  final Function tapHandler;
  final Widget child;

  ModalWindow(
      {this.label,
      @required this.buttonLabel,
      @required this.tapHandler,
      this.child});

  Widget _actionButton() => GestureDetector(
        onTap: this.tapHandler,
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: getRadius(), bottomRight: getRadius()),
              gradient: getGradient(),
              color: Colors.red),
          child: Text(this.buttonLabel,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  color: Colors.white)),
        ),
      );

  Widget _label(String label) => Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 23, color: Colors.white, fontWeight: FontWeight.w300),
      ));

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Theme.of(context).primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.all(getRadius())),
        child: Wrap(
          spacing: 10,
          children: [
            if (label != null) _label(this.label),
            Container(padding: EdgeInsets.all(15), child: this.child),
            _actionButton()
          ],
        ));
  }
}
