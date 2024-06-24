class DomainStateException implements Exception {
  List<String>? _parameters = [];
  String? _message;

  DomainStateException({required message, List<String>? parameters}) {
    _message = message;
    _parameters = parameters;
  }

  String get message => toString();

  @override
  String toString() {
    if (_parameters == null || _parameters!.isEmpty) {
      return _message!;
    }

    String result = _message!;

    for (int i = 0; i < _parameters!.length; i++) {
      result = result.replaceAll("{{$i}}", _parameters![i]);
    }

    return result;
  }
}
