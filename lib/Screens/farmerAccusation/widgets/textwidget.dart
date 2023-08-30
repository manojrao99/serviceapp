import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(dynamic) onChanged;
  final bool allowNumbers;
  final bool allowDot;
  final bool allowSpecialCharacters;
  final TextInputType keyboardType;


  CustomTextFormField({
    required this.controller,
    required this.label,
    this.allowDot=false,
    required this.onChanged,
    this.allowNumbers = true,
    this.allowSpecialCharacters = true,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];

    if (!allowNumbers) {
      inputFormatters.add(FilteringTextInputFormatter.deny(RegExp(r'[0-9]')));
    }
    else if(allowNumbers) {
      inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'[0-9]')));
    }

  else if(!allowSpecialCharacters) {
      if (allowDot) {
        inputFormatters.add(AllowOnlyDotFormatter());
      } else {
        inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')));
      }

    }

    return Container(
      height: MediaQuery.of(context).size.height / 16,
      width: MediaQuery.of(context).size.width / 1.9,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style:TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.shortestSide * 0.032,fontWeight: FontWeight.bold,),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          counter: Offstage(),
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
class AllowOnlyDotFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow only digits and dot
    final filteredValue = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Ensure that there is only one dot and it's not the first character
    if (filteredValue == "." || filteredValue.startsWith(".")) {
      return oldValue;
    }

    return TextEditingValue(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}
