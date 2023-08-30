import 'package:flutter/material.dart';
import '/Screens/farmerAccusation/widgets/number_of_years.dart';

import '../../../constants.dart';

class NumberYearsFollowedWidget extends StatelessWidget {
  final Function(double) onNumberOfYearsSelected;
  final TextEditingController controller;
  final bool visible;
  final String label;

  NumberYearsFollowedWidget(
      {required this.label,
      required this.visible,
      required this.controller,
      required this.onNumberOfYearsSelected});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Row(
        children: [
          Text(
            "${label}",
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.shortestSide * normaltext,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          InkWell(
            child: Container(
              height: MediaQuery.of(context).size.height / 14,
              width: MediaQuery.of(context).size.width / 1.9,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller:
                    controller, // Make sure you have access to this controller
                enabled: false,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.shortestSide * 0.035),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Number Of Years",
                  border: OutlineInputBorder(),
                  counter: Offstage(),
                ),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (value) {
                  String pattern =
                      r'(^[6-9]{1}[0-9]{5}|[1-9]{1}[0-9]{3}\\s[0-9]{3}]*$)';
                  RegExp exp2 = new RegExp(pattern);
                  return null;
                },
              ),
            ),
            onTap: () async {
              String? value = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return YearMonthPickerDialog(); // Use your YearMonthPickerDialog here
                },
              );
              onNumberOfYearsSelected(double.parse(value ?? '0.0'));
            },
          ),
        ],
      ),
    );
  }
}
