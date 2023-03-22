import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase_provider/provider/counter.dart';
import 'package:todo_firebase_provider/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int result = Provider.of<CounterProvider>(context).counterValue;
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: Colors.white))),
          onPressed: () async {
            await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();
          },
          child: const Text('Logout', style: TextStyle(color: Colors.white)),
        ),
        leadingWidth: 75,
        title: const Text('Provider'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => toPushNamed(context, Paths.consumer),
            icon: const Icon(Icons.navigate_next),
          ),
        ],
      ),
      body: Center(child: Text(result.toString())),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: 'provider +1',
              onPressed: () =>
                  Provider.of<CounterProvider>(context, listen: false)
                      .incrementCounter(),
              child: const Icon(Icons.plus_one)),
          const SizedBox(height: 10),
          FloatingActionButton(
              heroTag: 'provider -1',
              onPressed: () =>
                  Provider.of<CounterProvider>(context, listen: false)
                      .decrementCounter(),
              child: const Icon(Icons.exposure_minus_1)),
          const SizedBox(height: 10),
          FloatingActionButton(
              heroTag: 'provider 0',
              onPressed: () {
                Provider.of<CounterProvider>(context, listen: false)
                    .resetCounter();
              },
              child: const Icon(Icons.restore)),
        ],
      ),
    );
  }
}
