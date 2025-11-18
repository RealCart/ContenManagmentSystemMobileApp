class Either<L, R> {
  const Either._(this._left, this._right);

  factory Either.left(L value) => Either._(value, null);

  factory Either.right(R value) => Either._(null, value);

  final L? _left;
  final R? _right;

  bool get isLeft => _left != null;
  bool get isRight => _right != null;

  L get left => _left as L;
  R get right => _right as R;

  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight) =>
      isLeft ? onLeft(left) : onRight(right);
}
