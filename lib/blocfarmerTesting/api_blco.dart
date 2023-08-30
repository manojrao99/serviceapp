import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '/blocfarmerTesting/Timerevent/timerblco.dart';
import 'package:yahoofin/yahoofin.dart';
// import '  /blocfarmerTesting/timer.dart';

import '../constants.dart';
import '../models/devicetest.dart';
import '../network/api_helper.dart';
part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  TimerBloc timerblock;
  ApiBloc(this.timerblock) : super(ApiInitial());
  bool isTimerRunning = false;
  Device? updatedevice;
  List<Device> _deviceList = [];
  int remainingTime = 30;
  late Timer _timer;
  @override
  Stream<ApiState> mapEventToState(ApiEvent event) async* {
    // Device updatedevice;
    if (!isTimerRunning) {}
    if (event is FetchData) {
      try {
        String postUrl = '$cultyvateURL/farmer/devicetest';
        List<Device> filteredNumbers = _deviceList
            .where((device) =>
                device.level1tested != true ||
                device.level2tested != true ||
                device.level3tested != true ||
                device.level4tested != true ||
                device.allleveltested != true)
            .toList();
        String devices =
            filteredNumbers.map((element) => "'${element.DeviceID}'").join(',');

        Map<String, dynamic> requestBody = {
          "device": devices.toString(),
          "level": "all",
        };
        yield ApiLoading();
        print("posturl ${postUrl}");
        print("body $devices");
        final niftyResponse =
            await ApiHelper().post(path: postUrl, postData: requestBody);
        print("Data ${niftyResponse['data']}");
        timerblock.add(StartTimer(30));
        if (niftyResponse['data'].length > 0) {
          // timerblock.add(ResetTimer());
          // timerblock.close();

          for (int j = 0; j < niftyResponse['data'].length; j++) {
            print("lastdata dayt ${niftyResponse['data'][j]}");
            for (int i = 0; i < _deviceList.length; i++) {
              print(
                  "bool value check ${_deviceList[i].DeviceID == niftyResponse['data'][j]['DeviceID']}");
              if (niftyResponse['data'][j]['DeviceID'] ==
                  _deviceList[i].DeviceID) {
                print(niftyResponse['data'][j]['Level1'] > 4000);
                print(_deviceList[i].level1);
                print((niftyResponse['data'][j]['Level1'] > 4000) &&
                    (niftyResponse['data'][j]['Level2'] > 4000) &&
                    (niftyResponse['data'][j]['Level3'] > 4000) &&
                    (niftyResponse['data'][j]['Level4'] > 4000));

                print("status ${(niftyResponse['data'][j])}");
                if ((_deviceList[i].allleveltested == false) &&
                    (niftyResponse['data'][j]['Level1'] > 4000) &&
                    (niftyResponse['data'][j]['Level2'] > 4000) &&
                    (niftyResponse['data'][j]['Level3'] > 4000) &&
                    (niftyResponse['data'][j]['Level4'] > 4000)) {
                  deviceList[i].stopwatch.stop();
                  deviceList[i].timer?.cancel();
                  deviceList[i].stopwatch.reset();

                  FlutterRingtonePlayer.playNotification();
                  add(UpdateArrayPositionEvent(
                      i,
                      Device(
                          lastCommunicated:
                              niftyResponse['data'][j]['LastDate'].toString(),
                          serviceMOde: _deviceList[i].serviceMOde,
                          FarmerID: _deviceList[i].FarmerID,
                          DeviceTypeID: _deviceList[i].DeviceTypeID,
                          DeviceDetailsID: _deviceList[i].DeviceDetailsID,
                          level1fail: _deviceList[i].level1fail,
                          level2fail: _deviceList[i].level2fail,
                          level3fail: _deviceList[i].level3fail,
                          level4fail: _deviceList[i].level4fail,
                          levelallfail: _deviceList[i].levelallfail,
                          level1: _deviceList[i].level1,
                          level2: _deviceList[i].level2,
                          DeviceID: _deviceList[i].DeviceID,
                          hardwareserialnumber:
                              _deviceList[i].hardwareserialnumber,
                          FarmerName: _deviceList[i].FarmerName,
                          ClintName: _deviceList[i].ClintName,
                          level3: _deviceList[i].level3,
                          level4: _deviceList[i].level4,
                          stopwatchtime: '',
                          level1active: _deviceList[i].level1active,
                          level2active: _deviceList[i].level2active,
                          level3active: _deviceList[i].level3active,
                          level4active: _deviceList[i].level4active,
                          alllevelactive: _deviceList[i].counter + 1,
                          counter: _deviceList[i].counter + 1,
                          stopwatch: _deviceList[i].stopwatch,
                          level1tested: _deviceList[i].level1tested,
                          level2tested: _deviceList[i].level2tested,
                          level3tested: _deviceList[i].level3tested,
                          level4tested: _deviceList[i].level4tested,
                          allleveltested: true)));

// ?                  if (mounted) {
//  ?                   setState(() {

                  // });
                  // }
                } else if (_deviceList[i].level1tested == false &&
                    (niftyResponse['data'][j]['Level1'] > 4000) &&
                    !(niftyResponse['data'][j]['Level2'] > 4000) &&
                    !(niftyResponse['data'][j]['Level3'] > 4000) &&
                    !(niftyResponse['data'][j]['Level4'] > 4000)) {
                  print("level1");
                  deviceList[i].stopwatch.stop();
                  deviceList[i].timer?.cancel();
                  deviceList[i].stopwatch.reset();

                  FlutterRingtonePlayer.playNotification();
                  add(UpdateArrayPositionEvent(
                      i,
                      Device(
                          lastCommunicated:
                              niftyResponse['data'][j]['LastDate'].toString(),
                          serviceMOde: _deviceList[i].serviceMOde,
                          FarmerID: _deviceList[i].FarmerID,
                          level1: niftyResponse['data'][j]['Level1'],
                          level1fail: _deviceList[i].level1fail,
                          level2fail: _deviceList[i].level2fail,
                          DeviceTypeID: _deviceList[i].DeviceTypeID,
                          DeviceDetailsID: _deviceList[i].DeviceDetailsID,
                          level3fail: _deviceList[i].level3fail,
                          level4fail: _deviceList[i].level4fail,
                          levelallfail: _deviceList[i].levelallfail,
                          level2: _deviceList[i].level2,
                          DeviceID: _deviceList[i].DeviceID,
                          hardwareserialnumber:
                              _deviceList[i].hardwareserialnumber,
                          FarmerName: _deviceList[i].FarmerName,
                          ClintName: _deviceList[i].ClintName,
                          level3: _deviceList[i].level3,
                          level4: _deviceList[i].level4,
                          stopwatchtime: '',
                          level1active: _deviceList[i].counter + 1,
                          counter: _deviceList[i].counter + 1,
                          level2active: _deviceList[i].level2active,
                          level3active: _deviceList[i].level3active,
                          level4active: _deviceList[i].level4active,
                          alllevelactive: _deviceList[i].alllevelactive,
                          stopwatch: _deviceList[i].stopwatch,
                          level1tested: true,
                          level2tested: _deviceList[i].level2tested,
                          level3tested: _deviceList[i].level3tested,
                          level4tested: _deviceList[i].level4tested,
                          allleveltested: _deviceList[i].allleveltested)));

                  // updatedevice?.DeviceID=_deviceList[i].DeviceID;
                  // print(_deviceList[i].DeviceID);
                  // updatedevice?.level1=niftyResponse['data'][j]['Level1'];
                  // updatedevice?.level2=_deviceList[i].level2;
                  // updatedevice?.level3=_deviceList[i].level3;
                  // updatedevice?.level4=_deviceList[i].level4;
                  // updatedevice?.allleveltested=_deviceList[i].allleveltested;
                  // updatedevice?.level1tested=true;
                  // updatedevice?.level2tested=_deviceList[i].level2tested;
                  // updatedevice?.level3tested=_deviceList[i].level3tested;
                  // updatedevice?.level4tested=_deviceList[i].level4tested;
                } else if (_deviceList[i].level2tested == false &&
                    (niftyResponse['data'][j]['Level2'] > 4000) &&
                    !(niftyResponse['data'][j]['Level1'] > 4000) &&
                    !(niftyResponse['data'][j]['Level3'] > 4000) &&
                    !(niftyResponse['data'][j]['Level4'] > 4000)) {
                  print("level2");
                  // if (mounted) {
                  //   setState(() {
                  // updatedevice!.DeviceID=_deviceList[i]!.DeviceID;
                  // updatedevice!.level1=_deviceList[i]!.level1;
                  // updatedevice!.level2=niftyResponse['data'][j]['Level2'];
                  // updatedevice!.level3=_deviceList[i]!.level3;
                  // updatedevice!.level4=_deviceList[i]!.level4;
                  // updatedevice!.allleveltested=_deviceList[i]!.allleveltested;
                  // updatedevice!.level1tested=_deviceList[i]!.level1tested;
                  // updatedevice!.level2tested=true;
                  // updatedevice!.level3tested=_deviceList[i]!.level3tested;
                  // updatedevice!.level4tested=_deviceList[i]!.level4tested;
                  // // updatedevice!.level1tested=_deviceList[i]!.level1tested;
                  deviceList[i].stopwatch.stop();
                  deviceList[i].timer?.cancel();
                  deviceList[i].stopwatch.reset();

                  FlutterRingtonePlayer.playNotification();
                  add(UpdateArrayPositionEvent(
                      i,
                      Device(
                          lastCommunicated:
                              niftyResponse['data'][j]['LastDate'].toString(),
                          serviceMOde: _deviceList[i].serviceMOde,
                          FarmerID: _deviceList[i].FarmerID,
                          level1: _deviceList[i].level1,
                          level2: niftyResponse['data'][j]['Level2'],
                          DeviceID: _deviceList[i].DeviceID,
                          DeviceTypeID: _deviceList[i].DeviceTypeID,
                          DeviceDetailsID: _deviceList[i].DeviceDetailsID,
                          level1fail: _deviceList[i].level1fail,
                          level2fail: _deviceList[i].level2fail,
                          level3fail: _deviceList[i].level3fail,
                          level4fail: _deviceList[i].level4fail,
                          levelallfail: _deviceList[i].levelallfail,
                          hardwareserialnumber:
                              _deviceList[i].hardwareserialnumber,
                          FarmerName: _deviceList[i].FarmerName,
                          ClintName: _deviceList[i].ClintName,
                          level3: _deviceList[i].level3,
                          level4: _deviceList[i].level4,
                          stopwatchtime: '',
                          level1active: _deviceList[i].level1active,
                          level2active: _deviceList[i].counter + 1,
                          counter: _deviceList[i].counter + 1,
                          level3active: _deviceList[i].level3active,
                          level4active: _deviceList[i].level4active,
                          alllevelactive: _deviceList[i].alllevelactive,
                          stopwatch: _deviceList[i].stopwatch,
                          level1tested: _deviceList[i].level1tested,
                          level2tested: true,
                          level3tested: _deviceList[i].level3tested,
                          level4tested: _deviceList[i].level4tested,
                          allleveltested: _deviceList[i].allleveltested)));
                } else if (_deviceList[i].level3tested == false &&
                    (niftyResponse['data'][j]['Level3'] > 4000) &&
                    !(niftyResponse['data'][j]['Level2'] > 4000) &&
                    !(niftyResponse['data'][j]['Level1'] > 4000) &&
                    !(niftyResponse['data'][j]['Level4'] > 4000)) {
                  // if (mounted) {
                  //   setState(() {
                  // updatedevice!.DeviceID=_deviceList[i].DeviceID;
                  // updatedevice!.level1=_deviceList[i].level1;
                  // updatedevice!.level2=_deviceList[i].level2;
                  // updatedevice!.level3=niftyResponse['data'][j]['Level3'];
                  // updatedevice!.level4=_deviceList[i]!.level4;
                  // updatedevice!.allleveltested=_deviceList[i]!.allleveltested;
                  // updatedevice!.level1tested=_deviceList[i]!.level1tested;
                  // updatedevice!.level2tested=_deviceList[i]!.level2tested;
                  // updatedevice!.level3tested=true;
                  // updatedevice!.level4tested=_deviceList[i]!.level4tested;
                  // updatedevice!.level1tested=_deviceList[i]!.level1tested;
                  deviceList[i].stopwatch.stop();
                  deviceList[i].timer?.cancel();
                  deviceList[i].stopwatch.reset();
                  //   });
                  // }
                  print("level3");

                  FlutterRingtonePlayer.playNotification();
                  add(UpdateArrayPositionEvent(
                      i,
                      Device(
                          lastCommunicated:
                              niftyResponse['data'][j]['LastDate'].toString(),
                          serviceMOde: _deviceList[i].serviceMOde,
                          FarmerID: _deviceList[i].FarmerID,
                          level1: _deviceList[i].level1,
                          level2: _deviceList[i].level2,
                          DeviceTypeID: _deviceList[i].DeviceTypeID,
                          DeviceDetailsID: _deviceList[i].DeviceDetailsID,
                          DeviceID: _deviceList[i].DeviceID,
                          level1fail: _deviceList[i].level1fail,
                          level2fail: _deviceList[i].level2fail,
                          level3fail: _deviceList[i].level3fail,
                          level4fail: _deviceList[i].level4fail,
                          levelallfail: _deviceList[i].levelallfail,
                          hardwareserialnumber:
                              _deviceList[i].hardwareserialnumber,
                          FarmerName: _deviceList[i].FarmerName,
                          ClintName: _deviceList[i].ClintName,
                          level3: niftyResponse['data'][j]['Level3'],
                          level4: _deviceList[i].level4,
                          stopwatchtime: '',
                          level1active: _deviceList[i].level1active,
                          level2active: _deviceList[i].level2active,
                          level3active: _deviceList[i].counter + 1,
                          counter: _deviceList[i].counter + 1,
                          level4active: _deviceList[i].level4active,
                          alllevelactive: _deviceList[i].alllevelactive,
                          stopwatch: _deviceList[i].stopwatch,
                          level1tested: _deviceList[i].level1tested,
                          level2tested: _deviceList[i].level2tested,
                          level3tested: true,
                          level4tested: _deviceList[i].level4tested,
                          allleveltested: _deviceList[i].allleveltested)));
                } else if (_deviceList[i].level4tested == false &&
                    (niftyResponse['data'][j]['Level4'] > 4000) &&
                    !(niftyResponse['data'][j]['Level2'] > 4000) &&
                    !(niftyResponse['data'][j]['Level3'] > 4000) &&
                    !(niftyResponse['data'][j]['Level1'] > 4000)) {
                  print("level4");
                  // if (mounted) {
                  //   setState(() {
                  // updatedevice!.DeviceID=_deviceList[i]!.DeviceID;
                  // updatedevice!.level1=_deviceList[i]!.level1;
                  // updatedevice!.level2=_deviceList[i]!.level2;
                  // updatedevice!.level3==_deviceList[i]!.level3;
                  // updatedevice!.level4=niftyResponse['data'][j]['Level4'];
                  // updatedevice!.allleveltested=_deviceList[i]!.allleveltested;
                  // updatedevice!.level1tested=_deviceList[i]!.level1tested;
                  // updatedevice!.level2tested=_deviceList[i]!.level2tested;
                  // updatedevice!.level3tested=_deviceList[i]!.level3tested;
                  // updatedevice!.level4tested=true;
                  // updatedevice!.level1tested=_deviceList[i]!.level1tested;
                  deviceList[i].stopwatch.stop();
                  deviceList[i].timer?.cancel();
                  deviceList[i].stopwatch.reset();
                  //   });
                  //   });
                  // }
                  //   yield* updatedevice;
                  FlutterRingtonePlayer.playNotification();
                  add(UpdateArrayPositionEvent(
                      i,
                      Device(
                          lastCommunicated: niftyResponse['data'][j]
                              ['LastDate'],
                          serviceMOde: _deviceList[i].serviceMOde,
                          FarmerID: _deviceList[i].FarmerID,
                          level1: _deviceList[i].level1,
                          level2: _deviceList[i].level2,
                          DeviceTypeID: _deviceList[i].DeviceTypeID,
                          DeviceDetailsID: _deviceList[i].DeviceDetailsID,
                          DeviceID: _deviceList[i].DeviceID,
                          level1fail: _deviceList[i].level1fail,
                          level2fail: _deviceList[i].level2fail,
                          level3fail: _deviceList[i].level3fail,
                          level4fail: _deviceList[i].level4fail,
                          levelallfail: _deviceList[i].levelallfail,
                          hardwareserialnumber:
                              _deviceList[i].hardwareserialnumber,
                          FarmerName: _deviceList[i].FarmerName,
                          ClintName: _deviceList[i].ClintName,
                          level3: _deviceList[i].level3,
                          level4: niftyResponse['data'][j]['Level4'],
                          stopwatchtime: '',
                          level1active: _deviceList[i].level1active,
                          level2active: _deviceList[i].level2active,
                          level3active: _deviceList[i].level3active,
                          level4active: _deviceList[i].counter + 1,
                          counter: _deviceList[i].counter + 1,
                          alllevelactive: _deviceList[i].alllevelactive,
                          stopwatch: _deviceList[i].stopwatch,
                          level1tested: _deviceList[i].level1tested,
                          level2tested: _deviceList[i].level2tested,
                          level3tested: _deviceList[i].level3tested,
                          level4tested: true,
                          allleveltested: _deviceList[i].allleveltested)));
                }

                // else {
                //   yield ApiLoaded(posts: _deviceList);
                // }

                // yield ApiLoaded(posts:_deviceList);
                // print("match");
              }
            }
          }
          // deviceList<Device> = [];// create a list of Device objects from the response data
          yield ApiLoaded(posts: deviceList);
        } else {
          yield ApiLoaded(posts: _deviceList);
        }
      } catch (error) {
        print(error);
        yield ApiError(errorMessage: error.toString());
      }
    } else if (event is AddItemEvent) {
      final List<Device> updatedList = List.from(deviceList)
        ..add(event.newItem);

      _deviceList = updatedList;

      yield ApiLoaded(posts: updatedList);
    }
    if (event is UpdateArrayPositionEvent) {
      _deviceList[event.index] = event.newValue;
      yield ApiLoaded(posts: _deviceList);
    }
    if (event is RemoveItemEvent) {
      final List<Device> updatedList = List.from(deviceList)
        ..remove(event.item);

      _deviceList = updatedList;

      yield ApiLoaded(posts: updatedList);
    }
  }

  List<Device> get deviceList => _deviceList;

  void _startTimer() {
    // TimerBloc _timerBloc = TimerBloc();
    if (!isTimerRunning) {
      // _timerBloc.cancelTimer();
      var yfin = YahooFin();
      _timer = Timer.periodic(Duration(seconds: 30), (_) {
        isTimerRunning = true;
        print("data calling");
        if (deviceList.length > 0) {
          List<Device> filteredNumbers = _deviceList
              .where((device) =>
                  (device.level1tested != true) ||
                  (device.level2tested != true) ||
                  (device.level3tested != true) ||
                  (device.level4tested != true) ||
                  (device.allleveltested != true))
              .toList();
          if (filteredNumbers.length > 0) {
            add(FetchData());
          }
        }
        isTimerRunning = false; // set the flag back to false
      });
    }
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void restartTimer() {
    _stopTimer();
    _startTimer();
  }

  void starttimer() {
    // _stopTimer();
    _startTimer();
  }

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }
}
