import 'package:flutter/material.dart';
import '../store/state_store.dart';

class StateBuilder<T> extends StatelessWidget {
  final StateStore<T> store;
  final Widget Function(BuildContext context, T state) builder;
  final bool Function(T previous, T current)? shouldRebuild;

  const StateBuilder({
    required this.store,
    required this.builder,
    this.shouldRebuild,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: store.stream,
      initialData: store.state,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error!);
        }

        return _StateBuilderChild<T>(
          currentState: snapshot.data as T,
          shouldRebuild: shouldRebuild,
          builder: builder,
        );
      },
    );
  }
}

class _StateBuilderChild<T> extends StatefulWidget {
  final T currentState;
  final bool Function(T previous, T current)? shouldRebuild;
  final Widget Function(BuildContext, T) builder;

  const _StateBuilderChild({
    required this.currentState,
    required this.builder,
    this.shouldRebuild,
    super.key,
  });

  @override
  State<_StateBuilderChild<T>> createState() => _StateBuilderChildState<T>();
}

class _StateBuilderChildState<T> extends State<_StateBuilderChild<T>> {
  late T previousState;

  @override
  void initState() {
    super.initState();
    previousState = widget.currentState;
  }

  @override
  Widget build(BuildContext context) {
    final shouldUpdate = widget.shouldRebuild?.call(previousState, widget.currentState) ??
                        !identical(previousState, widget.currentState);

    if (shouldUpdate) {
      previousState = widget.currentState;
      return widget.builder(context, widget.currentState);
    }

    return widget.builder(context, previousState);
  }
}