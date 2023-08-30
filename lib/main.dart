import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../dashboard.dart';
import '../utils/flutter_toast_util.dart';

import 'blocfarmerTesting/MyBloc.dart';
import 'constants.dart';
import 'login/login_service.dart';
import 'login/sql_lite_localstorage.dart';
import 'models/loginAppaccess.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Save user details
Future<void> saveUserDetails(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userid', id);
}

Future<void> saveVersionDetails(String version) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('version', version);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper.instance;
  await dbHelper.initDatabase();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? username = await prefs.getInt('userid');
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  String? version = prefs.getString('version');
  // String
  List<ServiceAPPlogins> logindata = [];
  if (username != null) {
    logindata = await dbHelper.getServiceAPPlogins(username);
  }
  runApp(BlocProvider(
      create: (context) => MyBloc(),
      child: MyApp(
        data: logindata,
        versiondetals: version ?? "",
      )));
}

class MyApp extends StatelessWidget {
  final List<ServiceAPPlogins>? data;
  final String? versiondetals;

  MyApp({this.data, this.versiondetals});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: data!.isEmpty
          ? login()
          : Dashboard(
              heghtofscreen: MediaQuery.of(context).size.height,
              widthofscreen: MediaQuery.of(context).size.width,
              ServiceAPPlogin: data,
              farmerId: data![0].userMasterID,
              Version: versiondetals,
              visuble: true),
    );
  }
}

class login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _login();
  }
}

class _login extends State<login> {
  var width, hieght;
  bool error = false;
  bool loading = false;
  String versionglobaly = '';
  final dbHelper = DatabaseHelper.instance;
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  void initState() {
    checkAppVersion();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    hieght = MediaQuery.of(context).size.height;

    // colorfontsize=width * hieght * 0.001;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/cultyvate.png',
              height: 50,
            ),
            SizedBox(height: hieght / 12),
            Card(
              // color: Color(0xFFB9F6CA),
              color: Colors.white,
              elevation: 20,
              child: SizedBox(
                width: width,
                height: hieght / 2,
                child: Stack(
                  children: [
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: TextFormField(
                            controller: username,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              counter: Offstage(),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: TextFormField(
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.key),
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              counter: Offstage(),
                            ),
                          ),
                        ),
                        error
                            ? Text(
                                'Invalid Username and Password',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              )
                            : Text(''),
                        MaterialButton(
                          height: hieght / 12,
                          minWidth: 300,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20)),
                          onPressed: () {
                            loginPasswordValidate();
                            // if (username.text == "user" &&
                            //     password.text == "cultYvate") {
                            //   setState(() {
                            //     error = false;
                            //   });
                            //   Get.to(Dashboard());
                            //   // Navigator.pushReplacement(
                            //   //     context,
                            //   //     MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
                            // } else {
                            //   setState(() {
                            //     error = true;
                            //   });
                            // }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.green,
                        ),
                      ],
                    ),
                    Visibility(
                      visible: loading,
                      child: Positioned(
                        bottom: 200,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          color: HexColor('#7e7f80'),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/cultyvate.png',
                                height: 50,
                              ),
                              SizedBox(height: 16),
                              Text("Loading"),
                              SizedBox(height: 16),
                              CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     IconButton(onPressed: null, icon: Icon(MdiIcons.instagram,size: 35,color: Colors.red,)),
            //     IconButton(onPressed: null, icon: Icon(MdiIcons.facebook,size: 35,color: Colors.blue,)),
            //     IconButton(onPressed: null, icon: Icon(MdiIcons.linkedin,size: 35,color: Colors.blueAccent,)),
            //     IconButton(onPressed: null, icon: Icon(MdiIcons.youtube,size: 35,color: Colors.red,)),
            //   ],
            // )
          ])),
        ));
  }

  Future<void> checkAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versioncode = packageInfo.version;
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String buildNumber = packageInfo.buildNumber;
    saveVersionDetails(versioncode);
    setState(() {
      versionglobaly = versioncode;
    });
    // print("version ${versioncode == vesionfromapi}");
    print("version $appName");
    print("version $packageName");
    print("version $buildNumber");
    // loginPasswordValidate();
  }

  List<ServiceAPPlogins> Appaccessdata = [];
  Future<void> loginPasswordValidate() async {
    var usermasterid;
    await dbHelper.initDatabase();
    Appaccessdata = [];
    try {
      setState(() {
        loading = true;
      });
      if (username.text.trim() == "" || password.text.trim() == "") {
        FlutterToastUtil.showErrorToast(
            "Please enter your user name and password.");
      } else {
        Map<String, dynamic> response = await LoginService()
            .validateUser(username.text.trim(), password.text.trim());
        if (response["success"] ?? false) {
          setState(() {
            loading = false;
          });
          print(response['data']);
          if (response['data']["seriveappallowed"] ?? false) {
            print(
                "length of appaccess ${response['data']["ServiceAPPallowed"]}");

            final appaccessdata =
                json.decode(response['data']["ServiceAPPallowed"]);

            print("app version  ${appaccessdata.length}");
            // var appaccessdata=response['data']["ServiceAPPallowed"];
            usermasterid = appaccessdata[0]['UserMasterID'];
            saveUserDetails(appaccessdata[0]['UserMasterID']);

            // print("app aaccess ${appaccessdata[0]['CanCreateYN']}");

            for (int i = 0; i < appaccessdata.length; i++) {
              // print("optionname ${appaccessdata[i]}");
              try {
                final appdata = ServiceAPPlogins(
                  iD: appaccessdata[i]['ID'] ?? 0,
                  canCreateYN: appaccessdata[i]['CanCreateYN'] ?? false,
                  canDeleteYN: appaccessdata[i]['CanDeleteYN'] ?? false,
                  canExportYN: appaccessdata[i]['CanExportYN'] ?? false,
                  canPrintYN: appaccessdata[i]['CanPrintYN'] ?? false,
                  canUpdateYN: appaccessdata[i]['CanUpdateYN'] ?? false,
                  canViewYN: appaccessdata[i]['CanViewYN'] ?? false,
                  companyID: appaccessdata[i]['CompanyID'] ?? 0,
                  optionName: appaccessdata[i]['OptionName'] ?? "",
                  userMasterID: appaccessdata[i]['UserMasterID'] ?? 0,
                );

                await dbHelper.insertServiceAPPlogin(appdata);
              } catch (e) {
                print("error while adding $e");
                // Handle the exception here, if needed.
              } finally {
                // print("length is ${Appaccessdata!.length}");
                // print("length is ${Appaccessdata!.length}");
              }
            }

            //
            //     for(int i=0;i<appaccessdata.length;i++){
            //     print("optionname ${appaccessdata[i]['ID'].runtimeType}");
            //     // print("app aaccess  data manoj ${appaccessdata[i]}");
            //     try{
            //     Appaccessdata?.add(ServiceAPPlogin(
            //         iD:appaccessdata[i]['ID'],
            //         // canCreateYN:appaccessdata[i]['CanCreateYN'] ,
            //         // canDeleteYN: appaccessdata[i]['CanDeleteYN'],
            //         // canExportYN:appaccessdata[i]['CanExportYN'] ,
            //         // canPrintYN: appaccessdata[i]['CanPrintYN'],
            //         // canUpdateYN:appaccessdata[i]['CanUpdateYN'] ,
            //         // canViewYN:appaccessdata[i]['CanViewYN'] ,
            //         // companyID:appaccessdata[i]['CompanyID'] ,
            //         // optionName: appaccessdata[i]['OptionName'],
            //         // userMasterID:appaccessdata[i]['UserMasterID']
            //     ));
            //
            //   }
            //
            //     catch(e){
            //       print("error whileadding $e");
            //     }
            //    finally{
            //       print("length is ${ Appaccessdata!.length}");
            //       print("length is ${ Appaccessdata!.length}");
            //    }
            // }

            // Appaccessdata!.forEach((element) {
            //   print("element id ${element.iD}",);
            // });
            if (response == {} || (response['data']["farmerID"] ?? "") == "") {
              FlutterToastUtil.showErrorToast("Invalid user id / pwd.");
              return;
            }
            // Appaccessdata!.forEach((element) {
            //   print("element id ${element.iD}",);
            // });
            final data = await dbHelper.getServiceAPPlogins(usermasterid);
            print("data sqllite  ${data}");
            Get.to(Dashboard(
              heghtofscreen: MediaQuery.of(context).size.height,
              widthofscreen: MediaQuery.of(context).size.width,
              ServiceAPPlogin: data,
              farmerId: response['data']["farmerID"],
              Version: versionglobaly,
              visuble: response['data']["ServiceAPPDisable"],
            ));
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Image.asset(
                      'assets/images/cultyvate.png',
                      height: 50,
                    ),
                    content:
                        Text('Access denied. \n Please contact cultYvate.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          }
        } else {
          setState(() {
            loading = false;
          });
          // showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return AlertDialog(
          //         title: Image.asset(
          //           'assets/images/cultyvate.png',
          //           height: 50,
          //         ),
          //         content: Text(
          //             '${response["message"]}'),
          //         actions: <Widget>[
          //           TextButton(
          //             child: Text('Close'),
          //             onPressed: () {
          //               Navigator.of(context).pop();
          //             },
          //           ),
          //         ],
          //       );
          //     });
        }
      }
    } catch (e) {
    } finally {
      // setState(() {
      //   loading=false;
      // });
    }
  }
}
