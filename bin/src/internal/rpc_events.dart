typedef RpcEventHandler = void Function(Map<String, dynamic> json);

/// RPC events.
class RpcEvents {
  RpcEvents();

  /// Registed events.
  final Map<int, RpcEventHandler> _events = <int, RpcEventHandler>{};

  /// Register event.
  void on(int event, RpcEventHandler handler) {
    _events[event] = handler;
  }

  /// Trigger event.
  void trigger(int event, Map<String, dynamic> json) {
    _events[event]?.call(json);

    // Remove event.
    _events.remove(event);
  }

  /// Clear events.
  void clear() {
    _events.clear();
  }
}
