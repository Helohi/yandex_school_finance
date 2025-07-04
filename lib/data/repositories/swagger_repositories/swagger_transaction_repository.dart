import 'dart:developer' show log;

import 'package:dartz/dartz.dart';
import 'package:yandex_school_finance/core/datasource_failures.dart';
import 'package:yandex_school_finance/data/datasources/swagger/swagger_transaction_datasource.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_request_model.dart';
import 'package:yandex_school_finance/data/models/freezed_models/transaction_models/transaction_response_model.dart';
import 'package:yandex_school_finance/domain/repositories/transaction_repository.dart';

class SwaggerTransactionRepository implements TransactionRepository {
  final SwaggerTransactionDatasource _datasource;

  SwaggerTransactionRepository(SwaggerTransactionDatasource datasource)
    : _datasource = datasource;

  @override
  Future<Either<Failure, TransactionModel>> createTransaction(
    TransactionRequestModel newTransaction,
  ) async {
    try {
      return Right(await _datasource.createTransaction(newTransaction));
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      log("${e.runtimeType}: $e");
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, TransactionResponseModel>> getTransactionById(int id) {
    // TODO: implement getTransactionById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TransactionResponseModel>>>
  getTransactionsInPeriod(
    int id, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      return Right(
        await _datasource.getTransactionsInPeriod(id, startDate, endDate),
      );
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      log("${e.runtimeType}: $e");
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeTransactionById(int id) async {
    try {
      return Right(await _datasource.removeTransactionById(id));
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      log("${e.runtimeType}: $e");
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, TransactionResponseModel>> updateTransactionById(
    int id,
    TransactionRequestModel updatedTransaction,
  ) async {
    try {
      return Right(
        await _datasource.updateTransactionById(id, updatedTransaction),
      );
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      log("${e.runtimeType}: $e");
      return Left(UnhandledFailure());
    }
  }
}
