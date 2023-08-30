import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool) ?onChanged;
  final String label;
  final bool visible;

  CustomCheckbox({
    required this.value,
    required this.onChanged,
    required this.label,
    required this.visible
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:visible ,
      child:Container(
        height: MediaQuery.of(context).size.height/14,
      //   width: MediaQuery.of(context).size.width/1.9,
      // height: MediaQuery.of(context).size.height / 14,
      child:  Row(
          children: [
            Checkbox(
              activeColor:HexColor('#2ECC71'),
              value: value,
              onChanged: (bool? value){
                onChanged!(value!);
              },
            ),
            Text(label,style:  TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: MediaQuery.of(context).size.shortestSide * normaltext),),
          ],
        ),
      ),
    );
  }
}