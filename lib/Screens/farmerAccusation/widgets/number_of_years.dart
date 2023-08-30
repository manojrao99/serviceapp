import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class YearMonthPickerDialog extends StatefulWidget {

  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<YearMonthPickerDialog> {
  int selected_years = 0;
  int selected_month = 0;

  String getValue() {
    return "$selected_years.$selected_month";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text('Select Number and Decimal'),
      content: Container(
        height: 200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Years"),
                Text("Months"),

              ],
            ),

            Row(
              children: [
                Expanded(
                  child:   NumberPicker(
                    value: selected_years,
                    minValue: 0,
                    maxValue: 20,
                    onChanged: (value) => setState(() => selected_years = value),
                  ),
                ),
                Expanded(
                  child:   NumberPicker(
                    value: selected_month,
                    minValue: 0,
                    maxValue: 12,
                    onChanged: (value) => setState(() => selected_month = value),
                  ),
                ),

              ],
            )

          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            print("get valye ${getValue()}");
            Navigator.of(context).pop(getValue());
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}



