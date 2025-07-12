class SyncedResponse<T> {
  final T response;
  final bool isSynced;

  SyncedResponse(this.response, {required this.isSynced});
}
