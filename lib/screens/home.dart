import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../routes/app_routes.dart';
import '../routes/navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => toPushNamed(context, Paths.todo),
            icon: const Icon(Icons.navigate_next),
          ),
        ],
      ),
      body: const Center(child: Text('TODO')),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     addNotePopup(context);
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
