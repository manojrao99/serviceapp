import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Access Denied'),
      content: Row(
        children: [
          Image.asset(
            'assets/images/access-denied.png',
            height: 50,
          ),
          SizedBox(width: 5,),
          Text('Please contact cultYvate.'),

        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

class MyAlertDialogNamed extends StatelessWidget {
  final parametter;
  MyAlertDialogNamed({required this.parametter});
  String capitalize(String input) {
    if (input == null || input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${capitalize(parametter)} Permission'),
      content: Row(
        children: [
          Image.asset(
            'assets/images/access-denied.png',
            height: 40,
          ),
          SizedBox(width: 5,),
          Text('You do not have permission to\n$parametter.Please contact cultYvate.'),

        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
// Usage:
// Show the dialog by calling:
// showDialog(
//   context: context,
//   builder: (BuildContext context) => MyAlertDialog(),
// );
