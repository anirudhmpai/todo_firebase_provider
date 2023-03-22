import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:todo_firebase_provider/helpers/commons.dart';
import 'package:todo_firebase_provider/provider/base.dart';

class ConnectivityProvider extends BaseProvider {
  bool _isOnline = false;
  bool get isOnline => _isOnline;

  Stream<ConnectivityResult> connectivityStream =
      Connectivity().onConnectivityChanged;

  ConnectivityProvider() {
    Connectivity connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((event) {
      if (Commons.isNetworkAvailable(event)) {
        _isOnline = true;
        notifyListeners();
      } else {
        _isOnline = false;
        notifyListeners();
      }
    });
  }
}
