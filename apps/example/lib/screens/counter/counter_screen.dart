import 'package:flutter/material.dart';
import 'package:state_mgr/state_mgr.dart';

class CounterExample extends StatelessWidget {
  final counterStore = StateStore<int>(0);

  CounterExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter Example')),
      body: StreamBuilder<int>(
        stream: counterStore.stream,
        builder: (context, snapshot) {
          return Center(
            child: Text(
              'Count: ${snapshot.data ?? 0}',
              style: TextStyle(fontSize: 24),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterStore.update(counterStore.state + 1),
        child: Icon(Icons.add),
      ),
    );
  }
}