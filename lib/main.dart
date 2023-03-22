import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase_provider/provider/connectivity.dart';
import 'package:todo_firebase_provider/provider/counter.dart';
import 'package:todo_firebase_provider/provider/login.dart';
import 'package:todo_firebase_provider/routes/app_routes.dart';

import 'screens/login.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CounterProvider(context, 1),
      ),
      ChangeNotifierProvider(
        create: (context) => ConnectivityProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Firebase Provider',
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRoutes().onGenerateRoute,
      debugShowCheckedModeBanner: false,
      home: const _Unfocus(child: LoginScreen()),
    );
  }
}

class _Unfocus extends StatelessWidget {
  const _Unfocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
