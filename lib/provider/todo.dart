import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase_provider/provider/base.dart';

class TodoProvider extends BaseProvider {
  final FirebaseDatabase _firebaseDatabase;
  final FirebaseAuth _auth;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  late int timestamp;
  late final DatabaseReference ref;
  late final DatabaseReference todoRef;

  TodoProvider(this._firebaseDatabase, this._auth) {
    init();
  }

  void init() {
    ref = _firebaseDatabase.ref();
    todoRef = FirebaseDatabase.instance.ref('/todo/${_auth.currentUser!.uid}');
    timestamp = DateTime.now().microsecondsSinceEpoch;
  }

  Future<void> submitNote() async {
    await ref.child('/todo/${_auth.currentUser!.uid}').push().set({
      "todo_name":
          nameController.text.trim().isEmpty ? 'name' : nameController.text,
      "todo_description": descriptionController.text.trim().isEmpty
          ? 'description'
          : descriptionController.text,
      "todo_timestamp": timestamp,
    });
    nameController.text = '';
    descriptionController.text = '';
    timestamp = DateTime.now().microsecondsSinceEpoch;
  }

  deleteNote(String key) {
    ref.child('/todo/${_auth.currentUser!.uid}/$key').remove();
  }

  Future<void> editNote(String key) async {
    await ref.child('/todo/${_auth.currentUser!.uid}/$key').update({
      "todo_name":
          nameController.text.trim().isEmpty ? 'name' : nameController.text,
      "todo_description": descriptionController.text.trim().isEmpty
          ? 'name'
          : descriptionController.text,
      "todo_timestamp": timestamp,
    });
    nameController.text = '';
    descriptionController.text = '';
    timestamp = DateTime.now().microsecondsSinceEpoch;
  }
}
