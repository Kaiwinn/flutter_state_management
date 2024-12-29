abstract class StoreBase<T> {
  T get state;

  Stream<T> get stream;

  void update(T newState);

  void updatePartial(T Function(T currentState) updater);

  Future<void> updateAsync(Future<T> Function() asyncUpdate);

  void reset(T defaultState);

  void addListener(void Function(T state) listener);

  void removeListener(void Function(T state) listener);

  void dispose();

  bool get isDisposed;
}