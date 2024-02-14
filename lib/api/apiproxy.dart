import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vansale/api/class/emp_authen.dart';

import 'apiexception.dart';
import 'class/response/emp_authen.dart';

class ApiProxy {
  String host = 'http://10.0.2.2:10000';
  String language = 'TH';
  String appToken = '7d361a9f-6b9f-4a85-bc03-0f5f237a658f';

  ApiProxy({this.host = 'http://10.0.2.2:10000', this.language = 'TH'});

  Future<RespEmpAuthen> login(String userName, String password) async {
    var url = host + '/api/Login/EmployeeAuthentication';

    EmpAuthen empA = EmpAuthen(username: userName, password: password);
    var resp = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'ApiKey': appToken
        },
        body: jsonEncode(empA.toJson()));

    if (resp.statusCode == 200) {
      var result = RespEmpAuthen.fromJson(jsonDecode(resp.body));
      return result;
    } else {
      throw ApiResponseException(resp.body);
    }
  }
}
