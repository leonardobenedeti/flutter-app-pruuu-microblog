import 'package:Pruuu/utils/strings.dart';
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
        return Strings.wrongPassword;
        break;
      case Errors.ERROR_USER_NOT_FOUND:
        return Strings.userNotFound;
        break;
      case Errors.ERROR_USER_DISABLED:
        return Strings.userDisabled;
        break;
      case Errors.ERROR_TOO_MANY_REQUESTS:
        return Strings.tryAgain;
        break;
      case Errors.ERROR_EMAIL_ALREADY_IN_USE:
        return Strings.emailAlreadyInUse;
        break;
      default:
        return Strings.defaultError;
    }
  }
}
