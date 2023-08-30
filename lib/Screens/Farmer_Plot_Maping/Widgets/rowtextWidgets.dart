import 'package:flutter/cupertino.dart';
import '/constants.dart';

class RowTextWidget extends StatelessWidget {
  final headerName;
  final outputName;
  RowTextWidget({this.headerName, this.outputName});

  @override
  Widget build(BuildContext context) {
    final fontsize = MediaQuery.of(context).size.width *
        MediaQuery.of(context).size.height *
        0.00004;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              headerName,
              style: iostextstyle(fontsize),
            ),
          ),
          Center(
            child: Text(
              outputName,
              style: iostextstyle(fontsize),
            ),
          )
        ],
      ),
    );
  }
}
