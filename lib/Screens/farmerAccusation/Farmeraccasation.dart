import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_text_search/dropdown_text_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '/Screens/Permissiondenydiloag.dart';
import '/Screens/demogpscamtest.dart';
import '/Screens/farmerAccusation/bloc/acausationblock.dart';
import '/Screens/farmerAccusation/model_classes/districs.dart';
import '/Screens/farmerAccusation/model_classes/village_model.dart';
import '/Screens/farmerAccusation/mycubicstate.dart';
import '/Screens/farmerAccusation/sqllite/distics.dart';
import '/Screens/farmerAccusation/sqllite/taluka.dart';
import '/Screens/farmerAccusation/sqllite/villagesqllite.dart';
import '/Screens/farmerAccusation/widgets/state.dart';
import '/Screens/farmerAccusation/widgets/textwidget.dart';
import '/Screens/locationcamera.dart';
import '/Screens/selectlandareadilaog.dart';
import '/models/clintslist.dart';
import 'package:numberpicker/numberpicker.dart';
import '/models/villageinformation.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:datepicker_cupertino/datepicker_cupertino.dart';
import '/models/villageinformation.dart';
import 'package:search_dropdown/simple_search_popup.dart';

import '../../contrrolers/farmerAcasation_controller.dart';
import '../../models/farmeraccasationdataobject.dart';
import '../../models/villageinformation.dart';
import '../../sqllite/Db_helper/camera.dart';
import '../../sqllite/Db_helper/clintlistdbhelper.dart';
import '../../sqllite/Db_helper/vilagesdbhelper.dart';

import 'model_classes/taluka_model.dart';
import 'widgets/checkbox.dart';
import 'widgets/datepicker.dart';
import 'widgets/land_widget.dart';
import 'widgets/number_of_years.dart';
import 'widgets/number_of_years_widget.dart';
import 'widgets/radiobutton.dart';

class Farmeracusationpage extends StatelessWidget {
  final screenwidth;
  final screenhight;
  final incerpermission;
  Farmeracusationpage(
      {required this.screenhight,
      required this.screenwidth,
      required this.incerpermission})
      : super();
  final FormController _controller = FormController();
  @override
  Widget build(BuildContext context) {
    // final myBloc = BlocProvider.of<MyBloc>(context);
    // final incerpermission;
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyBloc>(create: (context) => MyBloc()),
        BlocProvider<FormController>(create: (context) => FormController()),
      ],
      child: Scaffold(
        body: Farmeracusation(
            incerpermission: incerpermission), // Replace with your form widget
      ),
    );
  }
}

class Farmeracusation extends StatefulWidget {
  final incerpermission;
  const Farmeracusation({required this.incerpermission}) : super();

  @override
  State<Farmeracusation> createState() => FarmeracusationState();
}

class FarmeracusationState extends State<Farmeracusation>
    with SingleTickerProviderStateMixin {
  final PostsBloc postsBloc = PostsBloc();
  TabController? _tabController;
  int _selectedIndex = 0;

  District? selecteddistic;
  Taluka? selected_taluka;
  List<Taluka> takukas = [];
  List<Village> villages = [];
  Village? selected_Village;

  late MyBloc _bloc;
  final clintdatabse = DatabaseclintHelper.instance;
  late final dbHelper = DatabaseHelper.instance;

  bool viilagedataloading = false;
  NumberPicker? integerNumberPicker;
  bool laserleveling = false;
  bool laserdo = false;

  bool dsr = false;
  bool dsrdo = false;

  TextEditingController villagetext = new TextEditingController();
  TextEditingController farmername = new TextEditingController();
  TextEditingController fathername = new TextEditingController();
  TextEditingController mobilenumber = new TextEditingController();
  TextEditingController own_dsr_Date = TextEditingController();
  TextEditingController own_dsr_numberof_years = TextEditingController();
  TextEditingController own_transplantation_date = TextEditingController();
  TextEditingController lease_dsr_numberof_years = TextEditingController();
  TextEditingController lease_transplantation_date = TextEditingController();
  TextEditingController lease_dsr_date = TextEditingController();
  TextEditingController lease_awd_deploymnet_date = TextEditingController();
  TextEditingController own_awd_deploymnet_date = TextEditingController();
  TextEditingController lease_awd_number_of_years = TextEditingController();
  TextEditingController own_awd_number_of_years = TextEditingController();
  TextEditingController own_no_tillage_date = new TextEditingController();
  TextEditingController lease_no_tillage_dat = new TextEditingController();
  TextEditingController lease_laser_last_date = new TextEditingController();
  TextEditingController cooperative = TextEditingController();
  TextEditingController own_laser_last_date = new TextEditingController();
  /* own land crm  date controllers */
  TextEditingController own_crm_balling_lastdate = new TextEditingController();
  TextEditingController own_crm_Mulching_lastdate = new TextEditingController();
  TextEditingController own_crm_bio_spray_lastdate =
      new TextEditingController();
  /*ow landcrm date editing controllers end*/
  /* lease land crm  date controllers */
  TextEditingController lease_crm_balling_lastdate =
      new TextEditingController();
  TextEditingController lease_crm_Mulching_lastdate =
      new TextEditingController();
  TextEditingController lease_crm_bio_spray_lastdate =
      new TextEditingController();
  /*lease crm date editing controllers end*/
  bool transplantaition = false;
  bool transplantaitiondo = false;

  _generateBorderRadius(index, selectedtab) {
    if ((index + 1) == selectedtab)
      return BorderRadius.only(bottomRight: Radius.circular(10.0));
    else if ((index - 1) == selectedtab)
      return BorderRadius.only(bottomLeft: Radius.circular(10.0));
    else
      return BorderRadius.zero;
  }

  Future PostImage(phonenumberone, context) async {
    Map<String, String> header = {
      "content-type": "application/json",
      "API_KEY": "12345678"
    };
    var path =
        'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/Imagepost/post';
    // var  path= 'http://192.168.1.10:8085/api/farm2fork/Imagepost/post';
    print(path);
    final dio = Dio();
    Map<String, dynamic> returnData = {};
    try {
      final response = await dio.post(path,
          data: phonenumberone,
          options: Options(headers: header),
          queryParameters: {});
      if (response.statusCode == 200) {
        return response.data['data'][0]['ID'].toString();
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print("error one is ${e}");
      Fluttertoast.showToast(
          msg: 'Cannot post  data, please try later: ${e.toString()}');
    }
    return returnData;
  }

  late PermissionStatus status;
  askPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isDenied == true) {
      askPermission();
    } else {
      return status;
    }
  }

  bool loading = false;
  static FarmeracusationState? instance;
  List<Uint8List> images = [];
  List<String> imagesid = [];
  final List<String> _tabNames = ['Own Land', 'Lease Land'];
  static final tracking = TrackingScrollController();

  @override
  void initState() {
    instance = this;
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
    askPermission();
    postsBloc.add(PostsInitialFetchEvent());
    postsBloc.add(GetTaluka());
    postsBloc.add(GetVillage());
  }

  bool clintlistloading = false;
  bool savelocally = false;
  List<ClintsList> Clintlist = [];

  ClintsList? selectedclint;

  Future insertimageslocattodb(records) async {
    final liteimagesid = records.split(',');
    print("remo $liteimagesid");
    List<String> Imagesids = [];
    for (int j = 0; j < liteimagesid.length; j++) {
      if (records[j] == '{}') {
      } else {
        final camreahelp = Camera_sqllite_database.instance;
        print("sqliteid ${liteimagesid[j]}");
        await camreahelp
            .querybyId(int.parse(liteimagesid[j]))
            .then((value) async {
          print(value);
          var dataone = {
            "farmerID": value[0]['farmerID'] == 0 ? null : value[0]['farmerID'],
            "FieldOfficerID": value[0]['FieldOfficerID'] == 0
                ? null
                : value[0]['FieldOfficerID'],
            "FieldmanagerID": value[0]['FieldManagerID'] == 0
                ? null
                : value[0]['FieldManagerID'],
            "image": null,
            "imagenv": value[0]['imagenv'],
            "Latitude": value[0]['Latitude'],
            "Longtitude": value[0]['Longitude'],
          };
          await PostImage(dataone, context).then((value) async {
            print("value $value");
            final camreahelp = Camera_sqllite_database.instance;
            var z = await camreahelp.delete(int.parse(liteimagesid[j]));
            print("delete id $z");
            setState(() {
              Imagesids.add(value);
            });
          });
        });
      }
    }
    print("imagepsot ${Imagesids}");
    return Imagesids;
  }

  @override
  void dispose() {
    postsBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  TextEditingController taluka_controller = TextEditingController();
  TextEditingController village_controller = TextEditingController();
  TextEditingController disticcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<MyBloc>(context);
    double imageHeight = MediaQuery.of(context).size.height / 25;
    double imageWidth = MediaQuery.of(context).size.width / 8;
    var savedata = context.read<FormController>();

    return BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        buildWhen: (previous, current) => current is! PostsAdditionSuccessState,
        listener: (context, state) {
          print("Listener triggered: ${state.runtimeType}");
          if (state is PostsAdditionSuccessState) {
            // Show the success dialog here
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Success'),
                  content: Text('Data saved successfully!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Close the dialog
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          print("state  ecampler ${state.runtimeType}");
          switch (state.runtimeType) {
            case PostsFetchingLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostFetchingSuccessfulState:
              final successState = state as PostFetchingSuccessfulState;

              return BlocBuilder<FormController, FarmerData>(
                  builder: (context, state) {
                TextStyle headers = TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.shortestSide * 0.04);
                own_laser_last_date.text = state.own_laser_leveling_date ?? "";
// mobilenumber.text=state.MobileNumber??'';
                own_no_tillage_date.text = state.ownNotillage_date ?? "";
                lease_no_tillage_dat.text = state.lease_Notillage_date ?? "";
                own_dsr_Date.text =
                    state.own_Somaring_Current_sesson_Date ?? "";
                lease_dsr_date.text =
                    state.lease_Somaring_Current_sesson_Date ?? "";
                own_dsr_numberof_years.text =
                    state.own_dsr_number_of_years_fallowed.toString();
                // own_awd_number_of_years.text=state.own_awd_number_of_years_sinse.toString()??"";
                own_transplantation_date.text = state.own_transplatation_date ??
                    ""; // print("state ${savedata.selectedIndex}");
                lease_transplantation_date.text =
                    state.lease_transplatation_date ?? "";
                lease_awd_deploymnet_date.text =
                    state.lease_awd_deploymentDate ?? "";
                own_awd_number_of_years.text =
                    state.own_awd_number_of_years_sinse.toString();
                own_dsr_numberof_years.text =
                    state.own_dsr_number_of_years_fallowed.toString();
                own_awd_deploymnet_date.text =
                    state.own_awd_deploymentDate ?? "";
                /*own  crm values asagning*/
                own_crm_balling_lastdate.text = state.own_crm_ballingdate ?? "";
                own_crm_Mulching_lastdate.text =
                    state.own_crm_malhing_date ?? "";
                own_crm_bio_spray_lastdate.text =
                    state.own_crm_bio_spray_date ?? "";
                /*lease crm values asagning*/
                lease_crm_balling_lastdate.text =
                    state.lease_crm_ballingdate ?? "";
                lease_crm_Mulching_lastdate.text =
                    state.lease_crm_malhing_date ?? "";
                lease_crm_bio_spray_lastdate.text =
                    state.lease_crm_bio_spray_date ?? "";
                lease_awd_number_of_years.text =
                    state.lease_awd_number_of_years_sinse.toString();
                lease_dsr_numberof_years.text =
                    state.lease_dsr_number_of_years_fallowed.toString();
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: BlocBuilder<FormController, FarmerData>(
                      builder: (context, state) {
                    double tab2hight =
                        ((MediaQuery.of(context).size.height / 14) * 20 +
                            (state.lease_dsr
                                ? MediaQuery.of(context).size.height / 14 + 20
                                : 0) +
                            (state.lease_awd
                                ? MediaQuery.of(context).size.height / 14 + 20
                                : 0) +
                            (MediaQuery.of(context).size.height / 14) * 3);
                    double tab1hight =
                        ((MediaQuery.of(context).size.height / 14) * 20 +
                            (state.own_dsr
                                ? MediaQuery.of(context).size.height / 14 + 20
                                : 0) +
                            (state.own_awd
                                ? MediaQuery.of(context).size.height / 14 + 20
                                : 0) +
                            (MediaQuery.of(context).size.height / 14) * 3 +
                            50);

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 15,
                            child: Image.asset(
                              'assets/images/cultyvate.png',
                              height: 50,
                            ),
                          ),
                          Row(
                            children: [
                              Text("Farmer Name:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.032,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                              Spacer(),
                              CustomTextFormField(
                                  onChanged: savedata.onFarmerName,
                                  controller: farmername,
                                  allowNumbers: false,
                                  allowSpecialCharacters: false,
                                  label: 'Farmer Name'),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("Father Name:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.032,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                              Spacer(),
                              CustomTextFormField(
                                  onChanged: savedata.onFarmerFatherName,
                                  controller: fathername,
                                  allowNumbers: false,
                                  allowSpecialCharacters: false,
                                  label: 'Father Name'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("Mobile Number:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.032,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                              Spacer(),
                              CustomTextFormField(
                                  onChanged: savedata.onMobileNumberChanged,
                                  controller: mobilenumber,
                                  allowNumbers: true,
                                  allowSpecialCharacters: false,
                                  allowDot: false,
                                  keyboardType: TextInputType.phone,
                                  label: 'Mobile Number'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("District:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.032,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Spacer(),
                              Container(
                                height: MediaQuery.of(context).size.height / 16,
                                width: MediaQuery.of(context).size.width / 1.9,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<District>(
                                    isExpanded: true,
                                    hint: Text(
                                        state.Distic == ''
                                            ? 'Select District'
                                            : state.Distic,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide *
                                              0.032,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    items: successState.posts
                                        .map((item) => DropdownMenuItem(
                                              value: item,
                                              child: Text(item.districtName,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .shortestSide *
                                                            0.032,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ))
                                        .toList(),
                                    value: selecteddistic,
                                    onChanged: (value) async {
                                      print(value);

                                      selecteddistic = value;
                                      selected_taluka = null;
                                      takukas = [];
                                      TalukaDatabase taluka = TalukaDatabase();
                                      takukas =
                                          await taluka.getDistrictsByDistrictID(
                                              selecteddistic!.districtID);

                                      savedata.onFarmerDistic(
                                          value: selecteddistic?.districtName ??
                                              "",
                                          id: selecteddistic!.districtID);
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      height: 40,
                                      width: 200,
                                    ),
                                    dropdownStyleData: const DropdownStyleData(
                                      maxHeight: 200,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                    ),
                                    dropdownSearchData: DropdownSearchData(
                                      searchController: disticcontroller,
                                      searchInnerWidgetHeight: 50,
                                      searchInnerWidget: Container(
                                        height: 50,
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                          bottom: 4,
                                          right: 8,
                                          left: 8,
                                        ),
                                        child: TextFormField(
                                          expands: true,
                                          maxLines: null,
                                          controller: disticcontroller,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 8,
                                            ),
                                            hintText: 'Search for an item...',
                                            hintStyle:
                                                const TextStyle(fontSize: 12),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      searchMatchFn: (item, searchValue) {
                                        return item.value!.districtName
                                            .toLowerCase()
                                            .toString()
                                            .contains(
                                                searchValue.toLowerCase());
                                      },
                                    ),
                                    //This to clear the search value when you close the menu
                                    onMenuStateChange: (isOpen) {
                                      if (!isOpen) {
                                        disticcontroller.clear();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text("Taluk:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.032,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Spacer(),
                              Container(
                                height: MediaQuery.of(context).size.height / 18,
                                width: MediaQuery.of(context).size.width / 1.9,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<Taluka>(
                                    isExpanded: true,
                                    hint: Text('Select Taluk ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide *
                                              0.032,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    items: takukas
                                        .map((item) => DropdownMenuItem(
                                              value: item,
                                              child: Text(item.talukaName,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .shortestSide *
                                                            0.032,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ))
                                        .toList(),
                                    value: selected_taluka,
                                    onChanged: (value) async {
                                      villages = [];

                                      selected_taluka = value;
                                      VillageDatabase villagedatabse =
                                          VillageDatabase();
                                      villages = await villagedatabse
                                          .getVillagesByTalukaID(
                                              selected_taluka!.talukaID);
                                      print("villages ${villages}");

                                      setState(() {});
                                      savedata.onFarmerTaluka(
                                          value: selected_taluka!.talukaName,
                                          id: selected_taluka!.talukaID);
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      height: 40,
                                      width: 200,
                                    ),
                                    dropdownStyleData: const DropdownStyleData(
                                      maxHeight: 200,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                    ),
                                    dropdownSearchData: DropdownSearchData(
                                      searchController: taluka_controller,
                                      searchInnerWidgetHeight: 50,
                                      searchInnerWidget: Container(
                                        height: 50,
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                          bottom: 4,
                                          right: 8,
                                          left: 8,
                                        ),
                                        child: TextFormField(
                                          expands: true,
                                          maxLines: null,
                                          controller: taluka_controller,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 8,
                                            ),
                                            hintText: 'Search for an item...',
                                            hintStyle:
                                                const TextStyle(fontSize: 12),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      searchMatchFn: (item, searchValue) {
                                        return item.value!.talukaName
                                            .toLowerCase()
                                            .toString()
                                            .contains(
                                                searchValue.toLowerCase());
                                      },
                                    ),
                                    //This to clear the search value when you close the menu
                                    onMenuStateChange: (isOpen) {
                                      if (!isOpen) {
                                        taluka_controller.clear();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("Village:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.032,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                              Spacer(),
                              Container(
                                height: MediaQuery.of(context).size.height / 18,
                                width: MediaQuery.of(context).size.width / 1.9,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<Village>(
                                    isExpanded: true,
                                    hint: Text(
                                      state.Village == ''
                                          ? 'Select Village'
                                          : state.Village,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.032,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    items: villages
                                        .map((item) => DropdownMenuItem(
                                              value: item,
                                              child: Text(
                                                item.villageName,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .shortestSide *
                                                          0.032,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: selected_Village,
                                    onChanged: (value) {
                                      // setState(() {
                                      selected_Village = value;
                                      // });
                                      savedata.onFarmerVillage(
                                        value: selected_Village!.villageName,
                                        id: selected_Village!.villageID,
                                      );
                                    },
                                    // ... rest of your DropdownButton2 configuration
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text("Co-operative Name:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.032,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Spacer(),
                              CustomTextFormField(
                                  controller: cooperative,
                                  label: "cooperative",
                                  onChanged: savedata.onFarmerCooperateName)

                              // Container(
                              //   height: MediaQuery
                              //       .of(context)
                              //       .size
                              //       .height / 18,
                              //   width: MediaQuery
                              //       .of(context)
                              //       .size
                              //       .width / 1.9,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.all(
                              //         Radius.circular(5)),
                              //     border: Border.all(color: Colors.grey),
                              //   ),
                              //   child: DropdownTextSearch(
                              //     onChange: (val) {
                              //       // selectdevalues=  returnData.firstWhere(
                              //       //       (element) => element!.villagename!.toLowerCase().startsWith(val.toLowerCase()), // Return null if no element found
                              //       // );
                              //       // savedata.onFarmerCooperateName(val);
                              //       cooperative.text = val;
                              //     },
                              //     noItemFoundText: "Invalid Village",
                              //     controller: cooperative,
                              //     overlayHeight: 300,
                              //     items: Clintlist.map((element) =>
                              //     element!.clintName!).toList(),
                              //     filterFnc: (String a, String b) {
                              //       return a.toLowerCase().startsWith(
                              //           b.toLowerCase());
                              //     },
                              //     decorator: InputDecoration(
                              //       hintText: "cooperative",
                              //       border: OutlineInputBorder(),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 6, right: 6, bottom: 6),
                            height: savedata.selectedIndexs == 0
                                ? tab1hight
                                : tab2hight + 30,
                            child: DefaultTabController(
                              initialIndex: savedata.selectedIndexs,
                              length: 2,
                              child: Column(
                                children: <Widget>[
                                  Material(
                                    color: Colors.grey.shade50,
                                    child: TabBar(
                                      onTap: savedata.onItemTapped,
                                      unselectedLabelColor: Colors.blue,
                                      labelColor: Colors.blue,
                                      indicatorColor: Colors.green,
                                      labelPadding: const EdgeInsets.all(0.0),
                                      tabs: [
                                        Tab(
                                          child: SizedBox.expand(
                                            child: Container(
                                              height:
                                                  savedata.selectedIndexs == 0
                                                      ? 50.0
                                                      : 40.0,
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Own Land',
                                                style: TextStyle(
                                                    fontSize:
                                                        savedata.selectedIndexs ==
                                                                0
                                                            ? 20.0
                                                            : 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.purple.shade50,
                                                  borderRadius:
                                                      _generateBorderRadius(
                                                          0,
                                                          savedata
                                                              .selectedIndexs)),
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: SizedBox.expand(
                                            child: Container(
                                              height:
                                                  savedata.selectedIndexs == 1
                                                      ? 50.0
                                                      : 40.0,
                                              alignment: Alignment.center,
                                              child: Center(
                                                  child: Text(
                                                "Lease Land",
                                                style: TextStyle(
                                                    fontSize:
                                                        savedata.selectedIndexs ==
                                                                1
                                                            ? 20.0
                                                            : 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue.shade50,
                                                  borderRadius:
                                                      _generateBorderRadius(
                                                          0,
                                                          savedata
                                                              .selectedIndexs)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: savedata.selectedIndexs == 0
                                            ? Colors.purple.shade50
                                            : Colors.blue.shade50,
                                      ),
                                      child: TabBarView(
                                        // controller: _tabController,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3.6),
                                                  Spacer(),
                                                  Flexible(
                                                    child: Container(
                                                      // height:MediaQuery.of(context).size.height/16 ,
                                                      width: ((MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2.05) /
                                                              3) -
                                                          10,
                                                      child: Text("Acres"),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                      child: Container(
                                                    // height:MediaQuery.of(context).size.height/16 ,
                                                    width:
                                                        ((MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    2.05) /
                                                                3) -
                                                            10,
                                                    child: Text("Kanal"),
                                                  )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                      child: Container(
                                                          // height:MediaQuery.of(context).size.height/16 ,
                                                          width: ((MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2.05) /
                                                                  3) -
                                                              10,
                                                          child:
                                                              Text("Marala"))),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              30),
                                                  SizedBox(width: imageWidth)
                                                ],
                                              ),
                                              OwnLandRow(
                                                label: 'Own Land:',
                                                latlang: state.ownland_latlang,
                                                compulsory: true,
                                                maxmarala: 20,
                                                maxacreas: 100,
                                                maxkanal: 08,
                                                imageHeight: imageHeight,
                                                imageWidth: imageWidth,
                                                getLocation:
                                                    savedata.getLocation,
                                                acreasText: state
                                                    .ownland_in_acaras
                                                    .toString(),
                                                kanalText: state
                                                    .ownland_in_kanal
                                                    .toString(),
                                                maralaText: state
                                                    .ownland_in_Marala
                                                    .toString(),
                                                onFarmerOwnArealatUpdate: savedata
                                                    .onFarmer_ownland_latlang_update,
                                                latLngColor:
                                                    state.ownland_latlang_color,
                                                onLandTap:
                                                    savedata.onFarmer_ownland,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              OwnLandRow(
                                                label: 'Area Under TPR:',
                                                latlang: state
                                                    .own_area_under_tpr_latlang,
                                                compulsory: true,
                                                maxmarala:
                                                    state.ownland_in_Marala,
                                                maxacreas:
                                                    state.ownland_in_acaras,
                                                maxkanal:
                                                    state.ownland_in_kanal,
                                                imageHeight: imageHeight,
                                                imageWidth: imageWidth,
                                                getLocation:
                                                    savedata.getLocation,
                                                acreasText: state
                                                    .own_tpr_in_acaras
                                                    .toString(),
                                                kanalText: state.own_tpr_kanal
                                                    .toString(),
                                                maralaText: state.own_tpr_Marala
                                                    .toString(),
                                                onFarmerOwnArealatUpdate: savedata
                                                    .onFarmer_own_area_under_tpr_update,
                                                latLngColor: state
                                                    .own_area_under_tpr_latlang_color,
                                                onLandTap:
                                                    savedata.onFarmer_Own_Tpr,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              OwnLandRow(
                                                label: 'Area under DSR:',
                                                latlang: state
                                                    .own_area_under_dsr_latlang,
                                                compulsory: false,
                                                maxmarala:
                                                    state.own_tpr_Marala!,
                                                maxacreas:
                                                    state.own_tpr_in_acaras!,
                                                maxkanal: state.own_tpr_kanal!,
                                                imageHeight: imageHeight,
                                                imageWidth: imageWidth,
                                                getLocation:
                                                    savedata.getLocation,
                                                acreasText: state.own_dsr_acaras
                                                    .toString(),
                                                kanalText: state
                                                    .own_dsr_in_kanal
                                                    .toString(),
                                                maralaText: state
                                                    .own_dsr_in_Marala
                                                    .toString(),
                                                onFarmerOwnArealatUpdate: savedata
                                                    .onFarmer_own_area_under_dsr_update,
                                                latLngColor: state
                                                    .own_area_under_dsr_latlang_color,
                                                onLandTap:
                                                    savedata.onFarmer_own_Dsr,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              OwnLandRow(
                                                label:
                                                    'Area Under Residue Mgmt:',
                                                latlang: state
                                                    .own_area_under_mangemnet_latlang,
                                                compulsory: false,
                                                maxmarala:
                                                    state.own_dsr_in_Marala!,
                                                maxacreas:
                                                    state.own_dsr_acaras!,
                                                maxkanal:
                                                    state.own_dsr_in_kanal!,
                                                imageHeight: imageHeight,
                                                imageWidth: imageWidth,
                                                getLocation:
                                                    savedata.getLocation,
                                                acreasText: state
                                                    .own_mangedby_in_acaras
                                                    .toString(),
                                                kanalText: state
                                                    .own_mangedby_in_kanal
                                                    .toString(),
                                                maralaText: state
                                                    .own_mangedby_in_Marala
                                                    .toString(),
                                                onFarmerOwnArealatUpdate: savedata
                                                    .onFarmer_own_area_under_residue_mgmt_update,
                                                latLngColor: state
                                                    .own_area_under_mangemnet_latlang_color,
                                                onLandTap: savedata
                                                    .onFarmer_own_residueMgmt,
                                              ),
                                              Divider(),
                                              Text(
                                                'Which of the following are you following?',
                                                style: headers,
                                              ),
                                              Text(
                                                "Laser leveling?",
                                                style: headers,
                                              ),
                                              CustomRadioGroup(
                                                label1: 'Yes',
                                                label2: 'No',
                                                value: state.own_laser_leveling,
                                                onChanged: savedata
                                                    .own_onRadio_laser_leveling_ValueChanged,
                                              ),
                                              CustomDateField(
                                                visible:
                                                    state.own_laser_leveling,
                                                controller: own_laser_last_date,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    14,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.9,
                                                label: 'Last Date',
                                                labelvisible: true,
                                                onDateSelected: savedata
                                                    .own_onFarmer_laser_leveling_date,
                                              ),
                                              CustomCheckbox(
                                                  onChanged: savedata
                                                      .own_onFarmer_laser_leveling_intrested,
                                                  value: state
                                                      .own_laser_leveling_are_you_intrested,
                                                  label:
                                                      'Are you interested to do?',
                                                  visible: state
                                                          .own_laser_leveling ==
                                                      false),
                                              Divider(),
                                              Text(
                                                "DSR?",
                                                style: headers,
                                              ),
                                              CustomRadioGroup(
                                                label1: 'Yes',
                                                label2: 'No',
                                                value: state.own_dsr,
                                                onChanged: savedata
                                                    .own_onRadio_dsr_leveling_ValueChanged,
                                              ),
                                              NumberYearsFollowedWidget(
                                                visible: state.own_dsr,
                                                label: 'No.Yrs Followed?',
                                                controller:
                                                    own_dsr_numberof_years,
                                                onNumberOfYearsSelected: savedata
                                                    .own_onFarmer_dsr_numberofyesrs,
                                              ),
                                              CustomDateField(
                                                visible: state.own_dsr,
                                                controller: own_dsr_Date,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    14,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.9,
                                                label:
                                                    'Sowing Date of Current season',
                                                labelvisible: true,
                                                onDateSelected: savedata
                                                    .own_onFarmer_dsr_last_date,
                                              ),
                                              CustomCheckbox(
                                                  onChanged: savedata
                                                      .own_onFarmer_dsr_are_you_intrested,
                                                  value: state
                                                      .own_dsr_are_you_intrested,
                                                  label:
                                                      'Are you interested to do?',
                                                  visible:
                                                      state.own_dsr == false),
                                              Divider(),
                                              Text(
                                                'Transplantation?',
                                                style: headers,
                                              ),
                                              CustomDateField(
                                                visible: true,
                                                controller:
                                                    own_transplantation_date,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    14,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.9,
                                                label:
                                                    'Date of Transplantation',
                                                labelvisible: true,
                                                onDateSelected: savedata
                                                    .onFarmer_own_transplatation_date,
                                              ),
                                              Divider(),
                                              Text(
                                                'AWD?',
                                                style: headers,
                                              ),
                                              CustomRadioGroup(
                                                label1: 'Yes',
                                                label2: 'No',
                                                value: state.own_awd,
                                                onChanged: savedata
                                                    .own_onRadio_awd_ValueChanged,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              NumberYearsFollowedWidget(
                                                visible: state.own_awd,
                                                label: 'No.Yrs Followed?',
                                                controller:
                                                    own_awd_number_of_years,
                                                onNumberOfYearsSelected: savedata
                                                    .own_onFarmer_awd_numberofyesrs,
                                              ),
                                              Visibility(
                                                  visible: state.own_awd,
                                                  child: SizedBox(
                                                    height: 10,
                                                  )),
                                              CustomDateField(
                                                visible: state.own_awd,
                                                controller:
                                                    own_awd_deploymnet_date,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    14,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.9,
                                                label: 'Deployment date',
                                                labelvisible: true,
                                                onDateSelected: savedata
                                                    .onFarmer_own_awd_date,
                                              ),
                                              CustomCheckbox(
                                                  onChanged: savedata
                                                      .own_onFarmer_awd_are_you_intrested,
                                                  value: state
                                                      .own_awd_are_you_intrested,
                                                  label:
                                                      'Are you interested to do?',
                                                  visible:
                                                      state.own_awd == false),
                                              Divider(),
                                              Text(
                                                "No Tillage?",
                                                style: headers,
                                              ),
                                              CustomRadioGroup(
                                                label1: 'Yes',
                                                label2: 'No',
                                                value: state.own_NoTillage,
                                                onChanged: savedata
                                                    .own_onRadio_NoTillage_ValueChanged,
                                              ),
                                              CustomDateField(
                                                visible: state.own_NoTillage,
                                                controller: own_no_tillage_date,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    14,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.9,
                                                label: 'Last Date',
                                                labelvisible: true,
                                                onDateSelected: savedata
                                                    .own_onFarmer_Notillage_date,
                                              ),
                                              CustomCheckbox(
                                                onChanged: savedata
                                                    .own_onFarmer_Notillage_are_you_intrested,
                                                value: state
                                                    .own_Notillage_are_you_intrested,
                                                label:
                                                    'Are you interested to do?',
                                                visible: state.own_NoTillage ==
                                                    false,
                                              ),
                                              Divider(),
                                              Text(
                                                "CRM?",
                                                style: headers,
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    14,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomCheckbox(
                                                      onChanged: savedata
                                                          .onFarmer_own_crm_balling,
                                                      value:
                                                          state.own_crm_balling,
                                                      label: 'Baling?',
                                                      visible: true,
                                                    ),
                                                    Spacer(),
                                                    CustomDateField(
                                                      visible:
                                                          state.own_crm_balling,
                                                      controller:
                                                          own_crm_balling_lastdate,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.9,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              14,
                                                      // width: MediaQuery.of(context).size.width/2.5,
                                                      label: 'Last Date',
                                                      labelvisible: false,
                                                      onDateSelected: savedata
                                                          .onFarmer_own_crm_balling_lastdate,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    14,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomCheckbox(
                                                      onChanged: savedata
                                                          .onFarmer_own_crm_malhing,
                                                      value:
                                                          state.own_crm_malhing,
                                                      label: 'Mulching?',
                                                      visible: true,
                                                    ),
                                                    Spacer(),
                                                    CustomDateField(
                                                      visible:
                                                          state.own_crm_malhing,
                                                      controller:
                                                          own_crm_Mulching_lastdate,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.9,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              14,
                                                      label: 'Last Date',
                                                      labelvisible: false,
                                                      onDateSelected: savedata
                                                          .onFarmer_own_crm_mulching_date,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    14,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomCheckbox(
                                                      onChanged: savedata
                                                          .onFarmer_own_crm_bio_spray,
                                                      value: state
                                                          .own_crm_bio_spray,
                                                      label: 'Bio spray?',
                                                      visible: true,
                                                    ),
                                                    Spacer(),
                                                    CustomDateField(
                                                      visible: state
                                                          .own_crm_bio_spray,
                                                      controller:
                                                          own_crm_bio_spray_lastdate,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              14,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.9,
                                                      label: 'Last Date',
                                                      labelvisible: false,
                                                      onDateSelected: savedata
                                                          .onFarmer_own_crm_bio_spray_date,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3.6),
                                                  Spacer(),
                                                  Flexible(
                                                    child: Container(
                                                      // height:MediaQuery.of(context).size.height/16 ,
                                                      width: ((MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2.05) /
                                                              3) -
                                                          10,
                                                      child: Text("Acres",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .shortestSide *
                                                                0.032,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                      child: Container(
                                                    // height:MediaQuery.of(context).size.height/16 ,
                                                    width:
                                                        ((MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    2.05) /
                                                                3) -
                                                            10,
                                                    child: Text("Kanal",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .shortestSide *
                                                              0.032,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                      child: Container(
                                                          // height:MediaQuery.of(context).size.height/16 ,
                                                          width: ((MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2.05) /
                                                                  3) -
                                                              10,
                                                          child: Text("Marala",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .shortestSide *
                                                                    0.032,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )))),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              30),
                                                  SizedBox(width: imageWidth)
                                                ],
                                              ),
                                              OwnLandRow(
                                                label: 'Lease Land:',
                                                latlang:
                                                    state.leaseland_latlang,
                                                compulsory: false,
                                                maxmarala: 20,
                                                maxacreas: 100,
                                                maxkanal: 08,
                                                imageHeight: imageHeight,
                                                imageWidth: imageWidth,
                                                getLocation:
                                                    savedata.getLocation,
                                                acreasText: state
                                                    .leaseland_in_acaras
                                                    .toString(),
                                                kanalText: state
                                                    .leaseland_in_kanal
                                                    .toString(),
                                                maralaText: state
                                                    .leaseland_in_Marala
                                                    .toString(),
                                                onFarmerOwnArealatUpdate: savedata
                                                    .onFarmer_leaseland_latlang_update,
                                                latLngColor: state
                                                    .leaseland_latlang_color,
                                                onLandTap: savedata
                                                    .onFarmer_lease_land,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              OwnLandRow(
                                                label: 'Area Under TPR:',
                                                latlang:
                                                    state.lease_tpr_latlang,
                                                compulsory: false,
                                                maxmarala:
                                                    state.leaseland_in_Marala,
                                                maxacreas:
                                                    state.leaseland_in_acaras,
                                                maxkanal:
                                                    state.leaseland_in_kanal,
                                                imageHeight: imageHeight,
                                                imageWidth: imageWidth,
                                                getLocation:
                                                    savedata.getLocation,
                                                acreasText: state
                                                    .lease_tpr_in_acaras
                                                    .toString(),
                                                kanalText: state.lease_tpr_kanal
                                                    .toString(),
                                                maralaText: state
                                                    .lease_tpr_Marala
                                                    .toString(),
                                                onFarmerOwnArealatUpdate: savedata
                                                    .onFarmer_lease_area_under_tpr_update,
                                                latLngColor: state
                                                    .lease_tpr_latlang_color,
                                                onLandTap:
                                                    savedata.onFarmer_lease_Tpr,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              OwnLandRow(
                                                label: 'Area under DSR:',
                                                latlang:
                                                    state.lease_dsr_latlang,
                                                compulsory: false,
                                                maxmarala:
                                                    state.lease_tpr_Marala!,
                                                maxacreas:
                                                    state.lease_tpr_in_acaras!,
                                                maxkanal:
                                                    state.lease_tpr_kanal!,
                                                imageHeight: imageHeight,
                                                imageWidth: imageWidth,
                                                getLocation:
                                                    savedata.getLocation,
                                                acreasText: state
                                                    .lease_dsr_acaras
                                                    .toString(),
                                                kanalText: state
                                                    .lease_dsr_in_kanal
                                                    .toString(),
                                                maralaText: state
                                                    .lease_dsr_in_Marala
                                                    .toString(),
                                                onFarmerOwnArealatUpdate: savedata
                                                    .onFarmer_lease_area_under_dsr_latlang_update,
                                                latLngColor: state
                                                    .lease_dsr_latlang_color,
                                                onLandTap:
                                                    savedata.onFarmer_lease_Dsr,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              OwnLandRow(
                                                label:
                                                    'Area Under Residue Mgmt:',
                                                latlang: state
                                                    .lease_mangedby_latlang,
                                                compulsory: false,
                                                maxmarala:
                                                    state.lease_dsr_in_Marala!,
                                                maxacreas:
                                                    state.lease_dsr_acaras!,
                                                maxkanal:
                                                    state.lease_dsr_in_kanal!,
                                                imageHeight: imageHeight,
                                                imageWidth: imageWidth,
                                                getLocation:
                                                    savedata.getLocation,
                                                acreasText: state
                                                    .leaseland_in_acaras
                                                    .toString(),
                                                kanalText: state
                                                    .leaseland_in_kanal
                                                    .toString(),
                                                maralaText: state
                                                    .leaseland_in_Marala
                                                    .toString(),
                                                onFarmerOwnArealatUpdate: savedata
                                                    .onFarmer_own_area_under_residue_mgmt_latlang_update,
                                                latLngColor: state
                                                    .lease_mangedby_latlang_color,
                                                onLandTap: savedata
                                                    .onFarmer_lease_under_managed,
                                              ),
                                              Divider(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Which of the following are you following...?'),
                                                  Text("Laser leveling....?"),
                                                  CustomRadioGroup(
                                                    label1: 'Yes',
                                                    label2: 'No',
                                                    value: state
                                                        .lease_laser_leveling,
                                                    onChanged: savedata
                                                        .lease_onRadio_laser_leveling_ValueChanged,
                                                  ),
                                                  CustomDateField(
                                                    visible: state
                                                        .lease_laser_leveling,
                                                    controller:
                                                        lease_laser_last_date,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            14,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.9,
                                                    label: 'Last Date',
                                                    labelvisible: true,
                                                    onDateSelected: savedata
                                                        .own_onFarmer_laser_leveling_date,
                                                  ),
                                                  CustomCheckbox(
                                                    onChanged: savedata
                                                        .lease_onFarmer_laser_leveling_intrested,
                                                    value: state
                                                        .lease_laser_leveling_are_you_intrested,
                                                    label:
                                                        'Are you interested to do?',
                                                    visible: state
                                                            .lease_laser_leveling ==
                                                        false,
                                                  ),

                                                  Divider(),
                                                  Text("DSR..?"),
                                                  CustomRadioGroup(
                                                    label1: 'Yes',
                                                    label2: 'No',
                                                    value: state.lease_dsr,
                                                    onChanged: savedata
                                                        .lease_onRadio_dsr_leveling_ValueChanged,
                                                  ),
                                                  NumberYearsFollowedWidget(
                                                    visible: state.lease_dsr,
                                                    label: 'No.Yrs Followed?',
                                                    controller:
                                                        lease_dsr_numberof_years,
                                                    onNumberOfYearsSelected:
                                                        savedata
                                                            .lease_onFarmer_dsr_numberofyesrs,
                                                  ),

                                                  CustomDateField(
                                                    visible: state.lease_dsr,
                                                    controller: lease_dsr_date,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            14,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.9,
                                                    label:
                                                        'S Date of Current season',
                                                    labelvisible: true,
                                                    onDateSelected: savedata
                                                        .lease_onFarmer_laser_dsr_SolingDate,
                                                  ),

                                                  CustomCheckbox(
                                                      onChanged: savedata
                                                          .lease_onFarmer_dsr_are_you_intrested,
                                                      value: state
                                                          .lease_dsr_are_you_intrested,
                                                      label:
                                                          'Are you interested to do?',
                                                      visible: state.own_dsr ==
                                                          false),

                                                  Divider(),
                                                  Text('Transplantation....?'),
                                                  CustomDateField(
                                                    visible: true,
                                                    controller:
                                                        lease_transplantation_date,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            14,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.9,
                                                    label:
                                                        'Date of Transplantation:',
                                                    labelvisible: true,
                                                    onDateSelected: savedata
                                                        .onFarmer_lease_transplatation_date,
                                                  ),

                                                  Divider(),
                                                  Text('AWD?'),
                                                  CustomRadioGroup(
                                                    label1: 'Yes',
                                                    label2: 'No',
                                                    value: state.lease_awd,
                                                    onChanged: savedata
                                                        .lease_onRadio_awd_ValueChanged,
                                                  ),

                                                  CustomDateField(
                                                    visible: state.lease_awd,
                                                    controller:
                                                        lease_awd_deploymnet_date,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            14,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.9,
                                                    label: 'Deployment date',
                                                    labelvisible: true,
                                                    onDateSelected: savedata
                                                        .onFarmer_lease_awd_date,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  NumberYearsFollowedWidget(
                                                    visible: state.lease_awd,
                                                    label: 'No.Yrs Followed?',
                                                    controller:
                                                        lease_awd_number_of_years,
                                                    onNumberOfYearsSelected:
                                                        savedata
                                                            .lease_onFarmer_awd_numberofyesrs,
                                                  ),

                                                  CustomCheckbox(
                                                    onChanged: savedata
                                                        .lease_onFarmer_awd_are_you_intrested,
                                                    value: state
                                                        .lease_awd_are_you_intrested,
                                                    label:
                                                        'Are you interested to do?',
                                                    visible: state.lease_awd ==
                                                        false,
                                                  ),
                                                  Divider(),
                                                  Text("No Tillage?"),
                                                  CustomRadioGroup(
                                                    label1: 'Yes',
                                                    label2: 'No',
                                                    value:
                                                        state.lease_NoTillage,
                                                    onChanged: savedata
                                                        .lease_onRadio_NoTillage_ValueChanged,
                                                  ),

                                                  CustomDateField(
                                                    visible:
                                                        state.lease_NoTillage,
                                                    controller:
                                                        lease_no_tillage_dat,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            14,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.9,
                                                    label: 'Last Date',
                                                    labelvisible: true,
                                                    onDateSelected: savedata
                                                        .lease_onFarmer_Notillage_date,
                                                  ),

                                                  CustomCheckbox(
                                                    onChanged: savedata
                                                        .lease_onFarmer_Notillage_are_you_intrested,
                                                    value: state
                                                        .lease_Notillage_are_you_intrested,
                                                    label:
                                                        'Are you interested to do?',
                                                    visible:
                                                        state.lease_NoTillage ==
                                                            false,
                                                  ),

                                                  Divider(),
                                                  Text("CRM...?"),
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            14,
                                                    // width: MediaQuery.of(context).size.width/1.9,
                                                    // height: MediaQuery.of(context).size.height/15,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CustomCheckbox(
                                                          onChanged: savedata
                                                              .onFarmer_lease_crm_balling,
                                                          value: state
                                                              .lease_crm_balling,
                                                          label: 'Baling?',
                                                          visible: true,
                                                        ),
                                                        Spacer(),
                                                        CustomDateField(
                                                          visible: state
                                                              .lease_crm_balling,
                                                          controller:
                                                              lease_crm_balling_lastdate,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              14,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.9,
                                                          label: 'Last Date',
                                                          labelvisible: false,
                                                          onDateSelected: savedata
                                                              .onFarmer_lease_crm_balling_lastdate,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            14,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CustomCheckbox(
                                                          onChanged: savedata
                                                              .onFarmer_lease_crm_malhing,
                                                          value: state
                                                              .lease_crm_malhing,
                                                          label: 'Mulching?',
                                                          visible: true,
                                                        ),
                                                        Spacer(),
                                                        CustomDateField(
                                                          visible: state
                                                              .lease_crm_malhing,
                                                          controller:
                                                              lease_crm_Mulching_lastdate,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              14,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.9,
                                                          label: 'Last Date',
                                                          labelvisible: false,
                                                          onDateSelected: savedata
                                                              .onFarmer_lease_crm_mulching_date,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            14,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CustomCheckbox(
                                                          onChanged: savedata
                                                              .onFarmer_lease_crm_bio_spray,
                                                          value: state
                                                              .lease_crm_bio_spray,
                                                          label: 'Bio spray?',
                                                          visible: true,
                                                        ),
                                                        Spacer(),
                                                        CustomDateField(
                                                          visible: state
                                                              .lease_crm_bio_spray,
                                                          controller:
                                                              lease_crm_bio_spray_lastdate,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              14,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.9,
                                                          label: 'Last Date',
                                                          labelvisible: false,
                                                          onDateSelected: savedata
                                                              .onFarmer_lease_crm_bio_spray_date,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //
                                                  //
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 8.0,
                            shrinkWrap: true,
                            children: <Widget>[
                                  ...List.generate(
                                    images.length,
                                    (index) {
                                      return Stack(
                                        children: <Widget>[
                                          InkWell(
                                            child: Image.memory(images[index],
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover),
                                            onTap: () {},
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ] +
                                [
                                  images.length < 2
                                      ? InkWell(
                                          onTap: () async {
                                            final status =
                                                await Permission.storage.status;
                                            final camerastatus =
                                                await Permission.camera.status;
                                            if (status.isGranted &&
                                                camerastatus.isGranted) {
                                              setState(() {
                                                loading = true;
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          // CameraMapApp())

                                                          LocationCamera(
                                                            Farmerid: 0,
                                                            FieldofficerId: 0,
                                                            FieldmanagerID: 0,
                                                            from:
                                                                'Farmeraccasation',
                                                          ))).then((value) {
                                                setState(() {
                                                  loading = false;
                                                });
                                              });
// Get.to(CameraPreviewScreen());
                                            } else {
                                              await Permission.camera.request();

                                              await Permission.storage
                                                  .request();
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/camera.png',
                                                height: 80,
                                              ),
                                              Text("Add Image")
                                            ],
                                          ))
                                      : SizedBox()
                                ],
                          ),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                child: Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  savedata.onSaveButtonPressed(
                                      context, postsBloc);
                                }),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              });

            default:
              return const SizedBox();
          }
        });

    Dtaepicker() async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2018),
          //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime.now());
      return pickedDate;
    }

    Widget _getTabView(int index) {
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [],
          ));
    }

// Future Postdata(phonenumberone, row,context) async {
//   Map<String, String> header = {
//     "content-type": "application/json",
//     "API_KEY": "12345678"
//   };
//   // var  path = 'http://20.219.2.201/servicesF2Fapp/api/farm2fork/Imagepost/post';
//   var  path= 'http://aquaf.centralindia.cloudapp.azure.com/servicesF2Fapp/api/farm2fork/farmeraccusation/postfarmerdetails';
//   print(path);
//   final dio = Dio();
//   Map<String, dynamic> returnData = {};
//   try {
//     final response =
//     await dio.post(path,  data: phonenumberone,options: Options(headers: header),queryParameters: {});
//     print("responcasklfme ${response.data['status']==true}");
//     if (response.statusCode == 200) {
//       if(response.data['status']==true) {
//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text("Data Saved Successfully"),
//                 actions: [
//                   TextButton(
//                     child: Text("OK"),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       Navigator.of(context).pop();
//                     },
//                   )
//                 ],
//               );
//             }
//         );
//         // Fluttertoast.showToast(
//         //     backgroundColor: Colors.green,
//         //     textColor: Colors.black,
//         //     msg: "Data saved successfully");
//       }
//       // Navigator.pop(context);
//       return response.statusCode;
//       returnData = response.data;
//     }
//     else{
//       return response.statusCode;
//     }
//   }
//   on DioError catch (e) {
//     Postsqllitemodel village = Postsqllitemodel.fromMap(row);
//     var z = await dbHelper.insertpostdata(village);
//     if (z == z.toInt()) {
//       Fluttertoast.showToast(msg: 'Saved successfully in local dtabase');
//       print(z == z.toInt());
//     }
//   }
//
//   catch (e) {
//     print("error one is ${e}");
//     Fluttertoast.showToast(
//         msg: 'Cannot post  data, please try later: ${e.toString()}');
//
//   }
//   return returnData;
//
// }

    _getTab(index, child, selectedtab, savedata) {
      print("selected tab ${selectedtab}");
      Widget ata = Tab(
        child: SizedBox.expand(
          child: Container(
            child: child,
            decoration: BoxDecoration(
                color: index == selectedtab ? Colors.white : Colors.grey,
                borderRadius: _generateBorderRadius(index, selectedtab)),
          ),
        ),
      );
      setState(() {});
      return ata;
    }

    // _insert({villagename, villageid, Disticname, thathkalID, thatkalname}) async {
    //   final row = {
    //     DatabaseHelper.columnvillageid: villageid,
    //     DatabaseHelper.columnname: villagename,
    //     DatabaseHelper.columnDistrictName: Disticname,
    //     DatabaseHelper.columnTalukaID: thathkalID,
    //     DatabaseHelper.columnTalukaName: thatkalname,
    //   };
    //   Village village = Village.fromMap(row);
    //   final id = await dbHelper.insert(village);
    //   // Fluttertoast.showToast(msg: 'inserted row id:$id');
    // }

//    _insert({villagename, villageid,Disticname,thathkalID,thatkalname}) async {
//   // row to insert
//
//
//
//   Map<String, dynamic> row = {
//     DatabaseHelper.columnvillageid:villageid,
//     DatabaseHelper.columnname: villagename,
//     DatabaseHelper.columnDistrictName:Disticname,
//     DatabaseHelper.columnTalukaID:thathkalID,
//     DatabaseHelper.columnTalukaName:thatkalname
//   };
//   print('row $row');
//   Village village = Village.fromMap(row);
// print("village ${village.villageName}");
//   final id = await dbHelper.insert(village);
//   // Fluttertoast.showToast(msg: 'inserted row id:$id');
// }
    deleteclintlist() async {
      await clintdatabse.deleteall();
    }

    deleteall() async {
      await dbHelper.deleteall();
    }

    getclintlistfromsqllite() async {
      final clintdatabse = DatabaseclintHelper.instance;
      print("error clintlist before ");
      final allrows = await clintdatabse.queryAllRows();
      print("error clintlist");
      allrows.forEach((element) {
        Clintlist.add(ClintsList(
            clintName: element['ClintName'], clintId: element['CLintId']));
      });
    }
  }

//
// class SmallBoxWidget extends StatelessWidget {
//   final hight;
//   final width;
//   final  text;
//   final Color color;
//
//   SmallBoxWidget({required this.width,required this.hight,required this.text, required this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: hight,
//       decoration: BoxDecoration(
//         color: color,
//         border: Border.all(color: Colors.grey, width: 2),
//       ),
//       child: Center(
//         child: Text(
//           text.toString(),
//           style: TextStyle(fontSize: 16, color: Colors.black),
//         ),
//       ),
//     );
}

// }

// class CircleTabIndicator extends Decoration {
//   final Color color;
//   final double radius;
//
//   CircleTabIndicator({required this.color, required this.radius});
//
//   @override
//   _CirclePainter createBoxPainter([VoidCallback? onChanged]) {
//     return _CirclePainter(this, onChanged);
//   }
// }

// class _CirclePainter extends BoxPainter {
//   final CircleTabIndicator decoration;
//
//   _CirclePainter(this.decoration, VoidCallback? onChanged) : super(onChanged);
//
//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
//     final Rect circleRect = Rect.fromCircle(
//       center: Offset(offset.dx + configuration.size!.width / 2, offset.dy + configuration.size!.height / 2),
//       radius: decoration.radius,
//     );
//
//     final Paint paint = Paint();
//     paint.color = decoration.color;
//     paint.style = PaintingStyle.fill;
//
//     canvas.drawCircle(circleRect.center, decoration.radius, paint);
//   }
// }