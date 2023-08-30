import 'package:flutter/material.dart';

class MyAlertDialog extends StatefulWidget {
  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  int selectedNumber = 0;
  int selectedDecimal = 0;

  double getValue() {
    return selectedNumber + selectedDecimal / 100.0;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Number and Decimal'),
      content: Container(
        height: 200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Number"),
                Text("Decimal"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Slider(
                    value: selectedNumber.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        selectedNumber = value.toInt();
                      });
                    },
                    min: 0,
                    max: 55,
                    divisions: 55,
                    label: selectedNumber.toString(),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: selectedDecimal.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        selectedDecimal = value.toInt();
                      });
                    },
                    min: 0,
                    max: 99,
                    divisions: 99,
                    label: selectedDecimal.toString(),
                  ),
                ),
              ],
            ),
            Text(
              'Selected Value: ${getValue().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(getValue()),
          child: Text('OK'),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('AlertDialog with Number and Decimal')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            double result = await showDialog<double>(
              context: context,
              builder: (BuildContext context) {
                return MyAlertDialog();
              },
            );

            // Handle the result (selected number and decimal)
            print('Selected Number and Decimal: $result');
          },
          child: Text('Open AlertDialog'),
        ),
      ),
    ),
  ));
}
