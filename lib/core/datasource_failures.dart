import 'package:equatable/equatable.dart';
import 'package:yandex_school_finance/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

sealed class Failure extends Equatable implements Exception {
  String message(BuildContext context);
}

class UnhandledFailure extends Failure {
  @override
  String message(BuildContext context) =>
      AppLocalizations.of(context).unhandled_error;

  @override
  List<Object?> get props => [];
}

class UnauthorizedRequest extends Failure {
  @override
  String message(BuildContext context) =>
      AppLocalizations.of(context).unauthorized;

  @override
  List<Object?> get props => [];
}

class IncorrectIdFormat extends Failure {
  @override
  String message(BuildContext context) =>
      AppLocalizations.of(context).incorrect_id;

  @override
  List<Object?> get props => [];
}

class IdNotFound extends Failure {
  @override
  String message(BuildContext context) =>
      AppLocalizations.of(context).id_not_found;

  @override
  List<Object?> get props => [];
}

class AccountOrCategoryNotFound extends Failure {
  @override
  String message(BuildContext context) =>
      AppLocalizations.of(context).account_or_category_not_found;

  @override
  List<Object?> get props => [];
}
