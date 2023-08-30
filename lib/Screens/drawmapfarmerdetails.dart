import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
class GoogleMapFarmerDetails extends StatefulWidget {
  const GoogleMapFarmerDetails({Key? key}) : super(key: key);

  @override
  State<GoogleMapFarmerDetails> createState() => _GoogleMapFarmerDetailsState();
}

class _GoogleMapFarmerDetailsState extends State<GoogleMapFarmerDetails> {
  TextEditingController deviceid=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Container(
            height: MediaQuery.of(context).size.height/15,
            child: Image.asset(
              'assets/images/cultyvate.png',
              height: 30,
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height/20,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text(
                      "Farmer",
                      style: TextStyle(
                          color: Color.fromRGBO(10 ,192 ,92,2),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " Details",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ] )
          ),

          Row(
              children: [


                Container(
                  // height: MediaQuery.of(context).size.height/12,
                  width: MediaQuery.of(context).size.width/1.26,
                  padding: EdgeInsets.fromLTRB(20, 0, 5, 5),
                  child: TextFormField(
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                      FilteringTextInputFormatter.deny(
                          RegExp(r'\s')),
                    ],
                    controller: deviceid,
                    decoration: InputDecoration(
                      labelText:'MobileNumber',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),

                      border: OutlineInputBorder(),
                      // counter: Offstage(),
                    ),
                  ),
                ),
                TextButton(
                  style:  TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.blueAccent
                  ),
                  onPressed: ()async{
                    // BlocProvider.of<TimerBloc>(context).add(StartTimer(30));

                    if(deviceid.text.trim().length>9) {


                      setState(() {
                        // devicedata = [];
                        // errormessage = "";
                      });
                      // myBloc.add( FetchDataButtonPressedEvent(shouldCallApi1: val==1 ?true:false, farmerID: deviceid
                      //     .text));
                      // // BlocProvider.of<MyBloc>(context).add(
                      //     FetchDataButtonPressedEvent(shouldCallApi1: val==1 ?true:false, farmerID: deviceid
                      //         .text)
                      // );
                      // DashboardService dashboardService = DashboardService();
                      // setState((){
                      //   dataloading=true;
                      // });
                      // if(val==1) {
                      //   farmer = await dashboardService.getFarmer(deviceid
                      //       .text);
                      // }
                      // else {
                      //   farmer = await dashboardService.Serialnumberdevicetest(deviceid
                      //       .text);
                      // }
                      // setState((){
                      //   dataloading=false;
                      //   showfarmerDetails=true;
                      // });
                      // print(farmer);
                      // devicedata = await getTelematics(deviceid.text.trim());
                    }
                    else{
                      Fluttertoast.showToast(
                          msg: "Please Enter Valid Mobile Number",
                          backgroundColor: Colors.red
                      );
                    }


                  },child: Text("Search",style: TextStyle(fontSize: 10),),),
                SizedBox(width: 20,)
              ]
          ),
        ],
      ),
      )


    );
  }
}
