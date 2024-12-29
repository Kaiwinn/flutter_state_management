import 'package:flutter/material.dart';
import '../store/state_store.dart';

class StateBuilder<T> extends StatelessWidget {
  final StateStore<T> store;
  final Widget Function(BuildContext context, T state) builder;

  const StateBuilder({
    super.key,
    required this.store,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: store.stream,
      initialData: store.state,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return builder(context, snapshot.data as T);
      },
    );
  }
}