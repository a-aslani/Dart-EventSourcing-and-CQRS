
abstract class ApplicationService<T, P> {
  Future<(T?, String?)> call(P params);
}

class NoParams {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoParams && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
