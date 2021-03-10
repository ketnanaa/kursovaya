import 'package:financial_app/common/styles.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  String currentValue;

  List<String> items;

  Function onChange;

  CustomDropdown({@required this.items, @required this.onChange});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  List<DropdownMenuItem<String>> buildDropdownMenuItems(List items) {
    List<DropdownMenuItem<String>> menuItems = List();
    for (String item in items) {
      menuItems.add(
        DropdownMenuItem(
          value: item,
          child: Center(child: Text(item)),
        ),
      );
    }
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blueGrey[700],
            borderRadius: BorderRadius.all(getRadius()),
            border: Border.all(color: Colors.white54)),
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 20),
          child: DropdownButton(
            underline: Container(color: Colors.transparent),
            isExpanded: true,
            items: buildDropdownMenuItems(widget.items),
            value: widget.currentValue,
            onChanged: (String newValue) {
              widget.onChange(newValue);
              setState(() {
                widget.currentValue = newValue;
              });
            },
          ),
        ));
  }
}
