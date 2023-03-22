import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase_provider/provider/counter.dart';

class ConsumerScreen extends StatelessWidget {
  const ConsumerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumer'),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pushNamed('/consumer');
        //     },
        //     icon: const Icon(Icons.navigate_next),
        //   ),
        // ],
      ),
      body: Consumer<CounterProvider>(
        builder: (context, counter, child) {
          return Center(
            child: Text(counter.counterValue.toString()),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: 'consumer +1',
              onPressed: () =>
                  Provider.of<CounterProvider>(context, listen: false)
                      .incrementCounter(),
              child: const Icon(Icons.plus_one)),
          const SizedBox(height: 10),
          FloatingActionButton(
              heroTag: 'consumer -1',
              onPressed: () =>
                  Provider.of<CounterProvider>(context, listen: false)
                      .decrementCounter(),
              child: const Icon(Icons.exposure_minus_1)),
          const SizedBox(height: 10),
          FloatingActionButton(
              heroTag: 'consumer 0',
              onPressed: () =>
                  Provider.of<CounterProvider>(context, listen: false)
                      .resetCounter(),
              child: const Icon(Icons.restore)),
        ],
      ),
    );
  }
}
