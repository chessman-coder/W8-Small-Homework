enum AsyncValueState { loading, error, success }

class AsyncState<T> {
  final T? data;
  final Object? error;
  final AsyncValueState state;

  AsyncState._({this.data, this.error, required this.state});

  factory AsyncState.loading() => AsyncState._(state: AsyncValueState.loading);
  factory AsyncState.success(T data) =>
      AsyncState._(state: AsyncValueState.success, data: data);
  factory AsyncState.error(Object error) =>
      AsyncState._(state: AsyncValueState.error, error: error);
}
