import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_firebase_provider/provider/base.dart';

class TodoProvider extends BaseProvider {
  final FirebaseDatabase _firebaseDatabase;
  final FirebaseAuth _auth;
  late final DatabaseReference ref;
  late final DatabaseReference todoRef;

  TodoProvider(this._firebaseDatabase, this._auth) {
    init();
  }

  void init() {
    ref = _firebaseDatabase.ref();
    todoRef = FirebaseDatabase.instance.ref('/todo/${_auth.currentUser!.uid}');
  }

  Future<void> submitNote() async {
    await ref.child('/todo/${_auth.currentUser!.uid}').push().set({
      "todo_name": "name data is shown here",
      "todo_description": "description data is shows here",
      "todo_timestamp": DateTime.now().microsecondsSinceEpoch,
    });
  }

  deleteNote(String key) {
    ref.child('/todo/${_auth.currentUser!.uid}/$key').remove();
  }
}
