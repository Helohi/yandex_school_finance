import 'package:drift/drift.dart';
import 'package:yandex_school_finance/data/models/drift_models/drift_transaction_event_sourcing.dart';
import 'package:yandex_school_finance/data/models/freezed_models/account_models/account_update_request_model.dart';

class DriftBankAccountDatasource {
  Future<void> updateAccountById(
    int id,
    AccountUpdateRequestModel updatedAccount,
  ) async {
    final eventSourcing = await EventSourcingDatabase()
        .into(EventSourcingDatabase().accountEvent)
        .insert(
          AccountEventCompanion(
            accountId: Value(id),
            name: Value(updatedAccount.name),
            balance: Value(updatedAccount.balance.toDouble()),
            currency: Value(updatedAccount.currency.name),
          ),
        );
  }
}
