import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase_provider/provider/login.dart';
import 'package:todo_firebase_provider/routes/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => provider.signInWithGoogle()
                    ..then((userCredential) {
                      if (userCredential != null) {
                        toPushReplaceNamed(context, Paths.home);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Error Signing in try again')));
                      }
                    }),
                  child: const Text('Google Sign in'))
            ],
          ),
        ),
      ),
    );
  }
}
