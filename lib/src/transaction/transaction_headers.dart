import 'package:webfetch/webfetch.dart';

class TransactionHeaders implements Headers {
  final _headers = Headers();

  TransactionHeaders({String? traceparent}) {
    if (traceparent != null) {
      _headers.set('traceparent', traceparent);
    }
  }

  @override
  void append(String name, String value) {
    if (name.toLowerCase() == 'traceparent') {
      return _headers.set(name, value);
    }

    _headers.append(name, value);
  }

  @override
  void delete(String name) => _headers.delete(name);

  @override
  Iterable<(String, String)> entries() => _headers.entries();

  @override
  void forEach(void Function(String value, String name, Headers parent) fn) =>
      _headers.forEach(fn);

  @override
  String? get(String name) => _headers.get(name);

  @override
  Iterable<String> getSetCookie() => _headers.getSetCookie();

  @override
  bool has(String name) => _headers.has(name);

  @override
  Iterable<String> keys() => _headers.keys();

  @override
  void set(String name, String value) => _headers.set(name, value);

  @override
  Iterable<String> values() => _headers.values();

  String? get traceparent => get('traceparent');

  set traceparent(String? value) {
    if (value == null || value.isEmpty) {
      return delete('traceparent');
    }

    set('traceparent', value);
  }
}
