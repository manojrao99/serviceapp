

import '../constants.dart';
import '../models/devicetest.dart';
import '../network/api_helper.dart';
import '../utils/flutter_toast_util.dart';

class DashboardService {
  Future<Device?> getFarmer(farmerID) async {
    String path = '$cultyvateURL/farmer/devicetestv2/' + farmerID.toString();
    Map<String, dynamic> response = await ApiHelper().get(path);
    if (response['success'] ?? false) {
      try{
        print("responce manoj ${response['data'].runtimeType}");
        return Device.fromJson(response['data']);
      }
      catch(e){
        print("error $e");
      }
    }
    return null;
  }
  Future<Device?> Serialnumberdevicetest(farmerID) async {
    String path = '$cultyvateURL/farmer/devicetestserialnumber/' + farmerID.toString();
    Map<String, dynamic> response = await ApiHelper().get(path);
    if (response['success'] ?? false) {
      try{
        print("responce manoj ${response['data'].runtimeType}");
        return Device.fromJson(response['data']);
      }
      catch(e){
        print("error $e");
      }
    }
    return null;
  }

  Future<Map<String, dynamic>> level(
      String deviceID, String Level) async {
    try {
      if (deviceID.isEmpty || Level.isEmpty) return {};

      String postUrl = '$cultyvateURL/farmer/devicetest';
      Map<String, dynamic> requestBody = {
        "device": deviceID,
        "level": Level
      };

      Map<String, dynamic> response =
      await ApiHelper().post(path: postUrl, postData: requestBody);

      if (response["success"] ?? false) {
        Map<String, dynamic> data = response["data"];
        return data;
      } else {
        FlutterToastUtil.showErrorToast(
            response["message"] ?? 'Network Not available');
      }
    } catch (e) {
      print(e);
      await FlutterToastUtil.showErrorToast(
          'Cannot get requested data, please try later.'
              ); // : ${e.toString()}');
    }
    return {};
  }
}
