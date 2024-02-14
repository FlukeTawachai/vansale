import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'class/response/ResponseAll.dart';
import 'class/response/province/addressiteminfo.dart';

class ApiProxyMobile {
  String host = 'http://27.254.207.240:11102/';
  // String host = 'http://10.1.1.58:11102/';
  // String host = 'http://192.168.2.36:3000/';

  String dbHost = '10.1.1.58';
  int dbPort = 5432;
  String dbName = 'Vansale';
  String dbUser = 'vansale';
  String dbPass = 'TcLWUyRfyLkgk4xv';

  ApiProxyMobile(
      {this.host = 'http://27.254.207.240:11102/',
      // this.host = 'http://10.1.1.58:11102/',
      // this.host = 'http://192.168.2.36:3000/',
      this.dbHost = '10.1.1.58',
      this.dbPort = 5432,
      this.dbName = 'Vansale',
      this.dbUser = 'vansale',
      this.dbPass = 'TcLWUyRfyLkgk4xv'});

  Future<String> processPostRequest(String url, String body) async {
    var reqUrl = Uri.parse(host + url);
    print('-------------------------------------');
    print(reqUrl);
    print('Request Url : ' + reqUrl.toString());
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'DATABASE_HOST': dbHost,
      'DATABASE_PORT': dbPort.toString(),
      'DATABASE_SERVICE_NAME': dbName,
      'DATABASE_USER_NAME': dbUser,
      'DATABASE_PASSWORD': dbPass
    };

    debugPrint('Request Header : ' + headers.toString());
    logPrint('Request Body : ' + body);
    var resp = await http.post(reqUrl, headers: headers, body: body);
    debugPrint('Response Code : ' + resp.statusCode.toString());
    if (resp.statusCode == 200) {
      print('Post :' + resp.body.toString());
      print('-------------------------------------');
      return resp.body;
    } else {
      throw Exception('API Request error.');
    }
  }

  Future<String> processGetRequest(String url) async {
    var reqUrl = Uri.parse(host + url);
    print('-------------------------------------');
    print(reqUrl);
    var resp = await http.get(reqUrl, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'DATABASE_HOST': dbHost,
      'DATABASE_PORT': dbPort.toString(),
      'DATABASE_SERVICE_NAME': dbName,
      'DATABASE_USER_NAME': dbUser,
      'DATABASE_PASSWORD': dbPass
    });
    if (resp.statusCode == 200) {
      print('Post :' + resp.body.toString());
      print('-------------------------------------');
      return resp.body;
    } else {
      print(resp.body);
      throw Exception('API Request error.');
    }
  }

  Future<Response> getProvincescBRANCD(dynamic data) async {
    String result;
    result = await processGetRequest('Address/Provinces/' + data);
    print('API Response : ' + result);
    // ignore: unnecessary_null_comparison
    if (result == 'null') {
      Response resp = Response();
      return resp;
    } else {
      Response resp = Response.fromJson(jsonDecode(result));
      return resp;
    }
  }

  void logPrint(Object object) async {
    int defaultPrintLength = 1020;
    if (object == null || object.toString().length <= defaultPrintLength) {
      print(object);
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
      }
    }
  }
}
