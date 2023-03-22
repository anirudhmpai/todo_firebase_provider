import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase_provider/provider/todo.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Consumer<TodoProvider>(builder: (context, provider, child) {
          return StreamBuilder<DatabaseEvent>(
            stream: provider.todoRef.onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData && snapshot.data!.snapshot.exists) {
                  return showData(snapshot);
                } else {
                  return const Text('No Data available');
                }
              } else {
                return const Text('Error loading data');
              }
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notePopup(context, false);
        },
        child: const Icon(Icons.add),
      ),
    ));
  }

  Widget showData(AsyncSnapshot<DatabaseEvent> snapshot) {
    debugPrint(snapshot.data!.snapshot.children.first.toString());
    // snapshot.data!.snapshot.children.first.value["todo_name"];
    var listItems = snapshot.data!.snapshot.children.toList();
    return ListView.separated(
      itemBuilder: (context, index) {
        var listItem = listItems[index].value;
        var data = jsonDecode(jsonEncode(listItem!));
        return Consumer<TodoProvider>(builder: (context, provider, child) {
          return ListTile(
            onTap: () {
              provider.nameController.text = data['todo_name'];
              provider.descriptionController.text = data['todo_description'];
              provider.timestamp = data['todo_timestamp'];
              notePopup(context, true, key: listItems[index].key!);
            },
            onLongPress: () => provider.deleteNote(listItems[index].key!),
            title: Text(data['todo_name']),
            subtitle:
                Text('${data['todo_description']}\n${data['todo_timestamp']}'),
            isThreeLine: true,
          );
        });
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 2,
      ),
      itemCount: listItems.length,
    );
  }

  Future<dynamic> notePopup(BuildContext context, bool isEdit, {String? key}) {
    return showDialog(
      context: context,
      // barrierDismissible: true,
      // useRootNavigator: true,
      builder: (context) => Center(
        child: Container(
          height: 300,
          width: 500,
          margin: const EdgeInsets.all(25) + MediaQuery.of(context).viewInsets,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Material(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            child: Consumer<TodoProvider>(builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Add Note',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  TextFormField(
                    controller: provider.nameController,
                    decoration: const InputDecoration(hintText: 'Enter Name'),
                  ),
                  TextFormField(
                    controller: provider.descriptionController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Description'),
                  ),
                  TextButton(
                      onPressed: () => datePickerPopup(context),
                      child: Text(isEdit
                          ? provider.timestamp.toString()
                          : DateTime.now().toString())),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          isEdit
                              ? provider.editNote(key!)
                              : provider.submitNote();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save Note')),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> datePickerPopup(BuildContext context) {
    var provider = Provider.of<TodoProvider>(context, listen: false);
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      selectableDayPredicate: (day) {
        provider.timestamp = day.microsecondsSinceEpoch;
        return true;
      },
    );
  }
}
