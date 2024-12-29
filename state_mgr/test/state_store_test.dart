import 'package:flutter_test/flutter_test.dart';
import 'package:state_mgr/state_mgr.dart';

void main() {
  group('StateStore Tests', () {
    late StateStore<int> store;

    setUp(() {
      store = StateStore<int>(0);
    });

    test('initial state should be correct', () {
      expect(store.state, 0);
    });

    test('update should change state', () {
      store.update(1);
      expect(store.state, 1);
    });

    test('stream should emit new values', () async {
      expect(store.stream, emitsInOrder([1, 2]));

      store.update(1);
      store.update(2);
    });
  });
}