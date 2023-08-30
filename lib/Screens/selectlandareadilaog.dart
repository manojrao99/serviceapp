import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MyAlertDialogjfj extends StatefulWidget {
  final maxacreas;
  final maxkanal;
  final maxmarala;
  MyAlertDialogjfj({
   required this.maxacreas,
    required  this.maxkanal,
    required  this.maxmarala
});

  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialogjfj> {
  int selectedacres = 0;
  int selectedkanal = 0;
  int selectedmarala = 0;

  String getValue() {
    return "$selectedacres.$selectedkanal.$selectedmarala";
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
                Text("Acres"),
                Text("Kanal"),
                Text("Marala"),
              ],
            ),

           Row(
             children: [
               Expanded(
                 child:   NumberPicker(
                   value: selectedacres,
                   minValue: 0,
                   maxValue: widget.maxacreas,
                   onChanged: (value) => setState(() => selectedacres = value),
                 ),
               ),
               Expanded(
                 child:   NumberPicker(
                   value: selectedkanal,
                   minValue: 0,
                   maxValue: widget.maxkanal,
                   onChanged: (value) => setState(() => selectedkanal = value),
                 ),
               ),
               Expanded(
                 child:   NumberPicker(
                   value: selectedmarala,
                   minValue: 0,
                   maxValue:  widget.maxmarala,
                   onChanged: (value) => setState(() => selectedmarala = value),
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

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(title: Text('AlertDialog with Number and Decimal')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             double? result = await showDialog<double>(
//               context: context,
//               builder: (BuildContext context) {
//                 return MyAlertDialog();
//               },
//             );
//
//             // Handle the result (selected number and decimal)
//             print('Selected Number and Decimal: $result');
//           },
//           child: Text('Open AlertDialog'),
//         ),
//       ),
//     ),
//   ));
// }
