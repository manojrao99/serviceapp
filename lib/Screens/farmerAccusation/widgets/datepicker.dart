import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class CustomDateField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onDateSelected;
  final bool visible;
  final String label;
 final bool labelvisible;
  final double height;
  final double width;

  CustomDateField({
    required this.height,
    required this.width,
    required this.label,
    required this.labelvisible,
    required this.visible,
    required this.controller,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: labelvisible? Row(
        children: [

      label =='Sowing Date of Current season'?Text("Sowing Date of \nCurrent season?",softWrap: true,maxLines: 2,style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.shortestSide * normaltext,fontWeight: FontWeight.bold,),):Text("$label :",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.shortestSide * normaltext,fontWeight: FontWeight.bold,),),
      Spacer(),
          InkWell(
            child: Container(
              height: height,
              width: width,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller,
                enabled: false,
                style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.shortestSide * 0.032,fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black),
                      // borderRadius: BorderRadius.circular(25.0),
                    ),
                  suffixIcon: Image.asset('assets/images/calendar1.png',
                    fit:  BoxFit.cover,

                  ),
                  labelText: "last date",
                 // border: OutlineInputBorder(
                 //    borderSide: BorderSide(
                 //        color: Colors.black,
                 //        width: 2.0), // Set border width here
              // ),
                  // counter: Offstage(),
                ),
                keyboardType: TextInputType.phone,
                // maxLength: 10,
                validator: (value) {
                  // Your validation logic here...
                  return null;
                },
              ),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate:DateTime(2018),
                lastDate:DateTime.now(),
              );

              if (pickedDate != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                onDateSelected(formattedDate);
              }
            },
          ),
        ],
      )  :
      InkWell(
        child: Container(
          height: height,
          width: width,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            enabled: false,
            style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.shortestSide * 0.032,fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.black),
                // borderRadius: BorderRadius.circular(25.0),
              ),
              suffixIcon: Image.asset('assets/images/calendar1.png',
                fit:  BoxFit.cover,

              ),
              labelText: "last date",
              // border: OutlineInputBorder(
              //    borderSide: BorderSide(
              //        color: Colors.black,
              //        width: 2.0), // Set border width here
              // ),
              // counter: Offstage(),
            ),
            keyboardType: TextInputType.phone,
            // maxLength: 10,
            validator: (value) {
              // Your validation logic here...
              return null;
            },
          ),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate:DateTime(2018),
            lastDate:DateTime.now(),
          );

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            onDateSelected(formattedDate);
          }
        },
      ),
    );
  }
}
