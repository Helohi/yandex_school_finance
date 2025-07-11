import 'dart:developer' show log;

import 'package:dartz/dartz.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_transaction_datasource.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_request_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/data/repositories/swagger_repositories/swagger_drift_connection.dart';
import 'package:yandex_school_finance/domain/entity/synced_response.dart';
import 'package:yandex_school_finance/domain/repositories/transaction_repository.dart';

class SwaggerTransactionRepository implements TransactionRepository {
  final SwaggerTransactionDatasource _datasource;
  final SwaggerDriftConnection _driftConnection;

  SwaggerTransactionRepository(this._datasource, this._driftConnection);

  @override
  Future<Either<Failure, SyncedResponse<TransactionModel>>> createTransaction(
    TransactionRequestModel newTransaction,
  ) async {
    try {
      final transaction = await _driftConnection.createLocallyTransaction(
        newTransaction,
      );
      await _driftConnection.addCreateTransactionBackup(
        transaction.id,
        newTransaction,
      );
      final isSynced = await _driftConnection.sync();
      return Right(SyncedResponse(transaction, isSynced: isSynced));
    } on Failure catch (f) {
      return Left(f);
    } catch (e, stackTrace) {
      log(
        "${e.runtimeType} in $runtimeType.createTransaction: $e",
        error: e,
        stackTrace: stackTrace,
      );
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, SyncedResponse<List<TransactionResponseModel>>>>
  getTransactionsInPeriod(
    int accountId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final isSynced = await _driftConnection.sync();

    try {
      return Right(
        SyncedResponse(
          await _driftConnection.getTransactionsInPeriod(
            accountId,
            startDate,
            endDate,
          ),
          isSynced: isSynced,
        ),
      );
    } on Failure catch (f) {
      return Left(f);
    } catch (e, stackTrace) {
      log(
        "${e.runtimeType} in $runtimeType.getTransactionsInPeriod: $e",
        error: e,
        stackTrace: stackTrace,
      );
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, SyncedResponse<void>>> removeTransactionById(
    int id,
  ) async {
    try {
      final deletedTransaction = await _driftConnection
          .removeLocallyTransactionById(id);
      if (deletedTransaction.remoteId != null) {
        await _driftConnection.addDeleteTransactionBackup(
          id,
          deletedTransaction.remoteId!,
        );
      }
      final isSynced = await _driftConnection.sync();

      return Right(SyncedResponse(null, isSynced: isSynced));
    } on Failure catch (f) {
      return Left(f);
    } catch (e, stackTrace) {
      log(
        "${e.runtimeType} in $runtimeType.removeTransactionById: $e",
        error: e,
        stackTrace: stackTrace,
      );
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, SyncedResponse<TransactionResponseModel>>>
  updateTransactionById(
    int id,
    TransactionRequestModel updatedTransaction,
  ) async {
    try {
      final newTransaction = await _datasource.updateTransactionById(
        id,
        updatedTransaction,
      );
      await _driftConnection.addUpdateTransactionBackup(
        id,
        newTransaction.id,
        updatedTransaction,
      );
      final isSynced = await _driftConnection.sync();
      return Right(SyncedResponse(newTransaction, isSynced: isSynced));
    } on Failure catch (f) {
      return Left(f);
    } catch (e, stackTrace) {
      log(
        "${e.runtimeType} in $runtimeType.updateTransactionById: $e",
        error: e,
        stackTrace: stackTrace,
      );
      return Left(UnhandledFailure());
    }
  }
}
