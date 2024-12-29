class StoreMonitor {
  static final _instance = StoreMonitor._();
  final _metrics = <String, Map<String, dynamic>>{};

  factory StoreMonitor() => _instance;
  StoreMonitor._();

  void trackUpdate(String storeId) {
    if (!_metrics.containsKey(storeId)) {
      _metrics[storeId] = {
        'updates': 0,
        'lastUpdate': DateTime.now(),
      };
    }
    _metrics[storeId]?['updates'] = (_metrics[storeId]?['updates'] ?? 0) + 1;
    _metrics[storeId]?['lastUpdate'] = DateTime.now();
  }

  Map<String, dynamic> getMetrics() => Map.unmodifiable(_metrics);
}
