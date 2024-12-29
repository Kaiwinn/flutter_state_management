class StateUtils {
  static bool shouldUpdate<T>(T prev, T next) {
    if (prev == next) return false;
    if (prev is List && next is List) {
      if (prev.length != next.length) return true;
      for (var i = 0; i < prev.length; i++) {
        if (prev[i] != next[i]) return true;
      }
      return false;
    }
    return true;
  }
}