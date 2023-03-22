import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase_provider/provider/connectivity.dart';
import 'package:todo_firebase_provider/provider/login.dart';
import 'package:todo_firebase_provider/screens/consumer.dart';
import 'package:todo_firebase_provider/screens/home.dart';
import 'package:todo_firebase_provider/screens/login.dart';
import 'package:todo_firebase_provider/screens/no_internet.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (context) {
        final isOnline = Provider.of<ConnectivityProvider>(context).isOnline;
        final isAuthenticated =
            Provider.of<LoginProvider>(context).isAuthenticated;
        if (isOnline) {
          if (isAuthenticated) {
            switch (routeSettings.name) {
              case Paths.initial:
                return const LoginScreen();
              case Paths.home:
                return const HomeScreen();
              case Paths.login:
                return const LoginScreen();
              case Paths.consumer:
                return const ConsumerScreen();
              case Paths.noInternet:
                return const NoInternetScreen();
              default:
                return const HomeScreen();
            }
          } else {
            return const LoginScreen();
          }
        } else {
          return const NoInternetScreen();
        }
      },
    );
  }
}

abstract class Paths {
  Paths._();
  static const initial = '/';
  static const home = '/home';
  static const login = '/login';
  static const consumer = '/consumer';
  static const noInternet = '/no-internet';
}
