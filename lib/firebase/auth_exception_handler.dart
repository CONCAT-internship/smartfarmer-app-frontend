import 'package:smartfarm/firebase/auth_result_status.dart';

class AuthExceptionHandler {
  static handleException(e) {
    var status;
    switch (e.code) {
      case "ERROR_INVALID_EMAIL":
        status = AuthResultStatus.invalidEmail;
        break;
      case "ERROR_WRONG_PASSWORD":
        status = AuthResultStatus.wrongPassword;
        break;
      case "ERROR_USER_NOT_FOUND":
        status = AuthResultStatus.userNotFound;
        break;
      case "ERROR_USER_DISABLED":
        status = AuthResultStatus.userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case "ERROR_WEAK_PASSWORD":
        status = AuthResultStatus.weakPassword;
        break;
      case "ERROR_MISSING_EMAIL":
        status = AuthResultStatus.weakPassword;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "이메일 형식이 잘못되었습니다. 다시 입력해주세요.";
        break;
      case AuthResultStatus.wrongPassword: //비번 틀림
        errorMessage = "패스워드가 틀립니다. 다시 한 번 입력해주세요.";
        break;
      case AuthResultStatus.userNotFound: //아이디 없음
        errorMessage = "등록된 이메일이 없습니다.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "아이디 비활성화 상태입니다 고객센터에 문의바랍니다.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "서버에 너무 많은 요청이 있습니다. 잠시 후 다시 시도해주세요.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "이메일 가입이 중지되었습니다.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage = "이 이메일로 이미 가입처리가 되었습니다.";
        break;
      case AuthResultStatus.weakPassword:
        errorMessage = "비밀번호를 6자리 이상 입력해주세요.";
        break;
      case AuthResultStatus.missingEmail:
        errorMessage = "이메일을 기입해주세요.";
        break;
      default:
        errorMessage = "알 수 없는 에러입니다. 잠시 후 다시 시도해주세요.";
    }

    return errorMessage;
  }
}
