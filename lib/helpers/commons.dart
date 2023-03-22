import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Commons {
  static Widget loadingWidget(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(18), child: Text(message)),
        const CircularProgressIndicator.adaptive()
      ],
    );
  }

  static bool isNetworkAvailable(ConnectivityResult snapshot) {
    return snapshot == ConnectivityResult.mobile ||
        snapshot == ConnectivityResult.wifi;
    // || snapshot.data == ConnectivityResult.vpn ||
    // snapshot.data == ConnectivityResult.ethernet;
  }
}
