import 'package:financial_app/common/styles.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String subtitle;
  final String title;
  final String value;
  final String prefix;
  final Function onDismiss;
  final Function onTap;

  ListItem(
      {@required this.title,
      this.subtitle,
      this.prefix = "",
      this.value,
      this.onDismiss,
      this.onTap});

  Widget _getBody() => Row(
        children: [
          Expanded(
              flex: 40,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18, color: Colors.white)))),
          Expanded(
              flex: 60,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("${prefix}${value}",
                      style: TextStyle(fontSize: 18, color: Colors.pink[300]))))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(title),
      onDismissed: onDismiss,
      child: GestureDetector(
        onTap: onTap,
        child: Tooltip(
          message: title,
          child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  if (subtitle != null)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          subtitle,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[700],
                        borderRadius: BorderRadius.all(getRadius()),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: _getBody(),
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
