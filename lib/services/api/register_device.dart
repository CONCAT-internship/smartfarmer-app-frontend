import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:smartfarm/model/api_response.dart';
import 'package:smartfarm/services/firebase_provider.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

import '../scan_data.dart';

class RegisterDevice {
  Future<APIResponse> registerDevice({String uid, String uuid}) {
    return http.post(API + '/RegisterDevice',
        body: jsonEncode(
          {"uid": uid, "uuid": uuid},
        ),
        headers: headers).then((data) {
      if(data.statusCode == 200){
        return APIResponse(error: false);
      }else{
        return APIResponse(error: true, errorMessage: '알 수 없는 에러입니다. 잠시 뒤 시도해주세요.');
      }
    });
  }
}


final registerFarm = RegisterDevice();