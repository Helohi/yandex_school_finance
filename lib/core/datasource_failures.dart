sealed class Failure implements Exception {
  String get message;
}

class UnhandledFailure extends Failure {
  @override
  String get message => "Что-то пошло не так, попробуйте позже";
}

class UnauthorizedRequest extends Failure {
  @override
  String get message => "Вы не авторизовались";
}

class IncorrectIdFormat extends Failure {
  @override
  String get message => "Неверный аккаунт или транзакция";
}

class IdNotFound extends Failure {
  @override
  String get message => "Данный ID не был найден";
}
