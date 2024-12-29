import 'dart:async';

import 'package:state_mgr/src/base/store_base.dart';

class StateStore<T> implements StoreBase<T> {
  final _controller = StreamController<T>.broadcast();
  final List<Function(T state)> _listeners = [];
  T _state;
  bool _isDisposed = false;

  StateStore(this._state);

  @override
  T get state => _state;

  @override
  Stream<T> get stream => _controller.stream;

  @override
  bool get isDisposed => _isDisposed;

  @override
  void update(T newState) {
    if (_isDisposed) return;
    _state = newState;
    _controller.add(_state);
    _notifyListeners();
  }

  @override
  void updatePartial(T Function(T currentState) updater) {
    if (_isDisposed) return;
    final newState = updater(_state);
    update(newState);
  }

  @override
  Future<void> updateAsync(Future<T> Function() asyncUpdate) async {
    if (_isDisposed) return;
    try {
      final newState = await asyncUpdate();
      update(newState);
    } catch (e) {
      _controller.addError(e);
    }
  }

  @override
  void reset(T defaultState) {
    if (_isDisposed) return;
    update(defaultState);
  }

  @override
  void addListener(void Function(T state) listener) {
    if (_isDisposed) return;
    _listeners.add(listener);
  }

  @override
  void removeListener(void Function(T state) listener) {
    if (_isDisposed) return;
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (var listener in _listeners) {
      listener(_state);
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _listeners.clear();
    _controller.close();
  }
}