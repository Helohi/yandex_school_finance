import 'package:equatable/equatable.dart';

class SyncedResponse<T> extends Equatable {
  final T response;
  final bool isSynced;

  const SyncedResponse(this.response, {required this.isSynced});

  @override
  List<Object?> get props => [response, isSynced];
}
