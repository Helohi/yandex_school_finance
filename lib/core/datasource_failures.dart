import 'package:yandex_school_finance/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

sealed class Failure implements Exception {
  String message(BuildContext context);
}

class UnhandledFailure extends Failure {
  @override
  String message(BuildContext context) =>
      AppLocalizations.of(context).unhandled_error;
}

class UnauthorizedRequest extends Failure {
  @override
  String message(BuildContext context) =>
      AppLocalizations.of(context).unauthorized;
}

class IncorrectIdFormat extends Failure {
  @override
  String message(BuildContext context) =>
      AppLocalizations.of(context).incorrect_id;
}

class IdNotFound extends Failure {
  @override
  String message(BuildContext context) =>
      AppLocalizations.of(context).id_not_found;
}

class AccountOrCategoryNotFound extends Failure {
  @override
  String message(BuildContext context) =>
      AppLocalizations.of(context).account_or_category_not_found;
}
