// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  Connectivity _connectivity = Connectivity();

  ConnectivityResult get connectivityResult => _connectivityResult;

  Future<ConnectivityResult> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _connectivityResult = result;
    return _connectivityResult;
  }
}
