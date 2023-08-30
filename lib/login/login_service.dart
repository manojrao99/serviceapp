import 'package:fluttertoast/fluttertoast.dart';

// import '../models/version.dart';
// import '../utils/string_extension.dart';
// import '../network/api_helper.dart';
// import '../utils/constants.dart';
import '../constants.dart';
import '../network/api_helper.dart';
import '../utils/flutter_toast_util.dart';

class LoginService {
  Future<Map<String, dynamic>> generateOTP(String mobile) async {
    try {
      if (mobile.length != 10 || (int.tryParse(mobile) ?? 0) == 0) return {};
      Map<String, dynamic> response = await ApiHelper()
          .get('$cultyvateURL/farmer/otp/${int.parse(mobile)}');
      if (response["success"] ?? false) {
        Map<String, dynamic> data = response["data"];

        return data;
      } else {
        Fluttertoast.showToast(msg: response["message"].i18n);
      }
    } catch (e) {
      FlutterToastUtil.showErrorToast(
          'Cannot get requested data, please try later.');
    }
    return {};
  }

  Future<Map<String, dynamic>> validateUser(
      String userName, String password) async {
    print(userName);
    try {
      if (userName.isEmpty || password.isEmpty) return {};

      String postUrl = '$cultyvateURL/farmer/login';
      print('url $postUrl');
      Map<String, dynamic> requestBody = {
        "userName": userName,
        "password": password
      };

      Map<String, dynamic> response =
      await ApiHelper().post(path: postUrl, postData: requestBody);

      if (response["success"] ?? false) {
        Map<String, dynamic> data = response["data"];
        print(data);

        return response;
      } else {
        return response;
      }
      //   FlutterToastUtil.showErrorToast(
      //       response["message"] ?? 'Invalid user id / pwd ');
      // }
    } catch (e) {
      print(e.toString());
      await FlutterToastUtil.showErrorToast(
          'Cannot get requested data, please try later.'
              ); // : ${e.toString()}');
    }
    return {};
  }

  // Future getversion() async {
  //   String path = '$watherstationURL/appversion/appversion';
  //   Map<String, dynamic> response = await ApiHelper().get(path);
  //   if (response['success'] ?? false) {
  //     print("responce $response");
  //     return response['data'][0]['MobileAPPVersion'];
  //   } else if (response.isNotEmpty) {
  //     FlutterToastUtil.showErrorToast(response['message'].i18n);
  //   }
  //   return null;
  // }
}
