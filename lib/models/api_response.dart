class ApiResponse<T> {
  final T result;
  final String _status;

  const ApiResponse._(this.result, this._status);

  factory ApiResponse.success(T result) => ApiResponse._(result, 'success');
  factory ApiResponse.error(T result) => ApiResponse._(result, 'error');

  R when<R>({
    required R Function(T) success,
    required R Function(T) error,
  }) {
    switch (_status) {
      case 'success':
        return success(result);
      case 'error':
        return error(result);
      default:
        throw StateError('Invalid status: $result');
    }
  }
}
