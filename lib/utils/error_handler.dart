import 'package:flutter/foundation.dart';

enum Errors {
  ERROR_UNDEFINED,
  ERROR_WRONG_PASSWORD,
  ERROR_USER_NOT_FOUND,
  ERROR_USER_DISABLED,
  ERROR_TOO_MANY_REQUESTS,
  ERROR_EMAIL_ALREADY_IN_USE,
}

extension ErrorString on String {
  Errors getError() {
    return Errors.values.firstWhere((e) => e.name == this);
  }
}

extension ErrorHandler on Errors {
  String get name => describeEnum(this);

  String getMessage() {
    switch (this) {
      case Errors.ERROR_WRONG_PASSWORD:
        return "Senha incorreta!";
        break;
      case Errors.ERROR_USER_NOT_FOUND:
        return "Usuário não encontrado!";
        break;
      case Errors.ERROR_USER_DISABLED:
        return "Usuário desabilitado!";
        break;
      case Errors.ERROR_TOO_MANY_REQUESTS:
        return "Guenta mão ai, tente novamente mais tarde!";
        break;
      case Errors.ERROR_EMAIL_ALREADY_IN_USE:
        return "Email já utilizado em outra conta! Go to SignIn";
        break;
      default:
        return "An undefined Error happened.";
    }
  }
}
