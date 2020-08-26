import 'dart:convert';
import 'package:smartfarm/model/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class CheckDeviceOverlap {

  Future<APIResponse> checkDevice(String uuid) {
    String errorMessage;
    bool isError;

    return http
        .post(API + '/CheckDeviceOverlap',
            body: jsonEncode(
              {
                'uuid': '$uuid',
              },
            ),
            headers: headers)
        .then((data) {

      switch (data.statusCode) {
        case 200:
          isError = false;
          break;
        case 403:
          isError = true;
          errorMessage = '이미 사용중인 기기입니다.';
          break;
        case 404:
          isError = true;
          errorMessage = '등록되어있지 않은 기기입니다.';
          break;
        default:
          isError = true;
          errorMessage = '알 수 없는 에러입니다. 잠시 뒤 시도해주세요.';
      }
      return APIResponse(error: isError, errorMessage: errorMessage);
    }).catchError((_) => APIResponse(error: true, errorMessage: '알 수 없는 에러입니다. 잠시 뒤 시도해주세요.'));
  }
}

final checkDevice = CheckDeviceOverlap();
