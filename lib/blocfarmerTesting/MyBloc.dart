import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/devicetest.dart';

import '../login/devicequrryapi.dart';

part 'MyBlocEvent.dart';
part 'MyBlocLoadingState.dart';

class MyBloc extends Bloc<MyBlocEvent, MyBlocState> {
  MyBloc() : super(MyBlocInitial());

  @override
  Stream<MyBlocState> mapEventToState(MyBlocEvent event) async* {
    if (event is FetchDataButtonPressedEvent) {
      print(event);
      yield MyBlocLoadingState();
      print(event);
      try {
        DashboardService dashboardService = DashboardService();
        List<Device> data = [];
        Device? data1;
        // Conditionally call API based on some requirement
        if (event.shouldCallApi1) {
          print('farmerid ${event.farmerID}');
          data1 = await dashboardService.getFarmer(event.farmerID);
          print(data1);
        } else {
          data1 = await dashboardService.Serialnumberdevicetest(event.farmerID);
        }
        yield MyBlocLoadedState(
            data: Device(
                FarmerName: data1!.FarmerName,
                level2: 0,
                level3: 0,
                level4: 0,
                DeviceTypeID: data1.DeviceTypeID,
                DeviceDetailsID: data1.DeviceDetailsID,
                ClintName: data1.ClintName,
                level1fail: false,
                level2fail: false,
                level3fail: false,
                levelallfail: false,
                FarmerID: data1.FarmerID,
                level4fail: false,
                hardwareserialnumber: data1.hardwareserialnumber,
                counter: 0,
                DeviceID: data1.DeviceID,
                lastCommunicated: data1.lastCommunicated,
                serviceMOde: data1.serviceMOde,
                level1: 0,
                stopwatchtime: "",
                level1active: 0,
                level2active: 0,
                level3active: 0,
                level4active: 0,
                alllevelactive: 0,
                stopwatch: Stopwatch(),
                level1tested: false,
                level2tested: false,
                level3tested: false,
                level4tested: false,
                allleveltested: false));
      } catch (e) {
        yield MyBlocErrorState();
      }
    }
  }
}
