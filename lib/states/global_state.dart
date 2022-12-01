/// このクラスは利用していないので、サンプルとしての位置付け
class GlobalState {
  const GlobalState({
    this.sessionId = '',
  });

  final String sessionId;

  GlobalState copyWith({
    String? sessionId,
  }) {
    return GlobalState(
      sessionId: sessionId ?? this.sessionId,
    );
  }
}
