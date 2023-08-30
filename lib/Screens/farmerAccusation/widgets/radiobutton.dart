import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants.dart';
class CustomRadioGroup extends StatelessWidget {
  final String label1;
  final String label2;
  final bool value;
  final void Function(bool)? onChanged;

  CustomRadioGroup({
    required this.label1,
    required this.label2,
    this.value = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 14,
      child: Row(
        children: [
          Radio(
            activeColor:HexColor('#2ECC71'),
            value: true,
            groupValue: value,
            onChanged: (bool? value){
              onChanged!(value!);
            },
          ),
          Text(label1,style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.shortestSide * normaltext,fontWeight: FontWeight.bold,),),

          Radio(
            value: false,
            activeColor:HexColor('#2ECC71'),
            groupValue: value,
            onChanged: (bool? value){
              onChanged!(value!);
            },
          ),
          Text(label2,style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.shortestSide * 0.032,fontWeight: FontWeight.bold,),),

        ],
      ),
    );
  }
}




