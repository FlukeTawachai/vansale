import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vansale/api/apiexception.dart';
import 'package:vansale/api/class/request/common/deleterequest.dart';
import 'package:vansale/api/class/request/common/recoveryrequest.dart';
import 'package:vansale/api/class/request/common/searchrequest.dart';
import 'package:vansale/api/class/request/customer/customer_attach_request.dart';
import 'package:vansale/api/class/request/customer/customerblock.dart';
import 'package:vansale/api/class/request/customer/customerrequest.dart';
import 'package:vansale/api/class/response/branch/branchinfo.dart';
import 'package:vansale/api/class/response/common/apiresponse.dart';
import 'package:vansale/api/class/response/config/configinfo.dart';
import 'package:vansale/api/class/response/customer/create_customer_response.dart';

import 'package:vansale/api/class/response/customer/customer_info.dart';
import 'package:vansale/api/class/response/mapsalebranch/mapsalebranchinfo.dart';
import 'package:vansale/api/class/response/province/addressiteminfo.dart';
import 'package:vansale/api/class/response/routeMobile/routeinfo.dart';

class WebApiProxy {
  String host = 'http://27.254.207.240:11111/';
  // String host = 'http://10.1.1.58:11111/';
  String language = 'TH';
  String appToken = '7d361a9f-6b9f-4a85-bc03-0f5f237a658f';

  WebApiProxy(
      {this.host = 'http://27.254.207.240:11111/',
      // this.host = 'http://10.1.1.58:11111/',
      this.appToken = '7d361a9f-6b9f-4a85-bc03-0f5f237a658f',
      this.language = 'TH'});

  Future<String> processPostRequest(String url, String body) async {
    var reqUrl = Uri.parse(host + url);
    print('-------------------------------------');
    print(reqUrl);
    print('Request Url : ' + reqUrl.toString());
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'ApiKey': appToken
    };

    debugPrint('Request Header : ' + headers.toString());
    var resp = await http.post(reqUrl, headers: headers, body: body);
    debugPrint('Response Code : ' + resp.statusCode.toString());
    if (resp.statusCode == 200) {
      print('Post :' + resp.body.toString());
      print('-------------------------------------');
      return resp.body;
    } else {
      var result = ApiResponse.fromJson(jsonDecode(resp.body));
      throw ApiException(result.message!);
    }
  }

  Future<String> processGetRequest(String url) async {
    var reqUrl = Uri.parse(host + url);
    print('-------------------------------------');
    print(reqUrl);
    var resp = await http.get(reqUrl, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'ApiKey': appToken
    });
    if (resp.statusCode == 200) {
      print('Get :' + resp.body.toString());
      print('-------------------------------------');
      return resp.body;
    } else {
      var result = ApiResponse.fromJson(jsonDecode(resp.body));
      throw ApiException(result.message!);
    }
  }

  Future<List<CustomerInfo>> getAllCustomer() async {
    var result = await processGetRequest('api/Customer');
    List<CustomerInfo> returnValue = [];
    List<dynamic> json = jsonDecode(result);
    if (json.isNotEmpty) {
      for (var item in json) {
        returnValue.add(CustomerInfo.fromJson(item));
      }
    }

    return returnValue;
  }

  Future<CustomerInfo> getCustomer(String id) async {
    var result = await processGetRequest('api/Customer/' + id);
    return CustomerInfo.fromJson(jsonDecode(result));
  }

  Future<List<CustomerInfo>> searchCustomer(SearchRequest req) async {
    var result = await processPostRequest(
        'api/Customer/Search', jsonEncode(req.toJson()));
    List<CustomerInfo> returnValue = [];
    List<dynamic> json = jsonDecode(result);
    if (json.isNotEmpty) {
      for (var item in json) {
        returnValue.add(CustomerInfo.fromJson(item));
      }
    }

    return returnValue;
  }

  Future<CreateCustomerResponse> createCustomer(CustomerRequest req) async {
    var result = await processPostRequest(
        'api/Customer/Create', jsonEncode(req.toJson()));
    return CreateCustomerResponse.fromJson(jsonDecode(result));
  }

  Future<ApiResponse> updateCustomer(String id, CustomerRequest req) async {
    var result = await processPostRequest(
        'api/Customer/Update/' + id, jsonEncode(req.toJson()));
    return ApiResponse.fromJson(jsonDecode(result));
  }

  Future<ApiResponse> deleteCustomer(DeleteRequest req) async {
    var result = await processPostRequest(
        'api/Customer/Delete', jsonEncode(req.toJson()));
    return ApiResponse.fromJson(jsonDecode(result));
  }

  Future<ApiResponse> recoveryCustomer(RecoveryRequest req) async {
    var result = await processPostRequest(
        'api/Customer/Recovery', jsonEncode(req.toJson()));
    return ApiResponse.fromJson(jsonDecode(result));
  }

  Future<ApiResponse> createCustomerBlock(CustomerBlockRequest req) async {
    var result = await processPostRequest(
        'api/Customer/SaveBlock', jsonEncode(req.toJson()));
    return ApiResponse.fromJson(jsonDecode(result));
  }

  Future<ApiResponse> attachCustomerImage(CustomerAttachRequest req) async {
    var result = await processPostRequest(
        'api/Customer/Attach', jsonEncode(req.toJson()));
    return ApiResponse.fromJson(jsonDecode(result));
  }

  Future<List<AddressItemInfo>> getAllProvinces() async {
    var result = await processGetRequest('api/Address/Provinces');
    List<AddressItemInfo> returnValue = [];
    List<dynamic> json = jsonDecode(result);
    if (json.isNotEmpty) {
      for (var item in json) {
        returnValue.add(AddressItemInfo.fromJson(item));
      }
    }

    return returnValue;
  }

  Future<List<AddressItemInfo>> getCities(String province) async {
    var result = await processGetRequest('api/Address/Cities/' + province);
    List<AddressItemInfo> returnValue = [];
    List<dynamic> json = jsonDecode(result);
    if (json.isNotEmpty) {
      for (var item in json) {
        returnValue.add(AddressItemInfo.fromJson(item));
      }
    }

    return returnValue;
  }

  Future<List<AddressItemInfo>> getDistricts(
      String province, String city) async {
    var result = await processGetRequest(
        'api/Address/Districts/' + province + '/' + city);
    List<AddressItemInfo> returnValue = [];
    List<dynamic> json = jsonDecode(result);
    if (json.isNotEmpty) {
      for (var item in json) {
        returnValue.add(AddressItemInfo.fromJson(item));
      }
    }

    return returnValue;
  }

  Future<AddressItemInfo> getDistrict(
      String province, String city, String district) async {
    var result = await processGetRequest(
        'api/Address/Districts/' + province + '/' + city + '/' + district);
    return AddressItemInfo.fromJson(jsonDecode(result));
  }

  Future<List<BranchInfo>> getAllBranches() async {
    var result = await processGetRequest('api/Branch');
    List<BranchInfo> returnValue = [];
    List<dynamic> json = jsonDecode(result);
    if (json.isNotEmpty) {
      for (var item in json) {
        returnValue.add(BranchInfo.fromJson(item));
      }
    }

    return returnValue;
  }

  Future<List<ConfigInfo>> getAllConfig(
      String configFunction, String configName) async {
    var result = await processGetRequest(
        'api/Config/GetValues/' + configFunction + '/' + configName);
    List<ConfigInfo> returnValue = [];
    List<dynamic> json = jsonDecode(result);
    if (json.isNotEmpty) {
      for (var item in json) {
        returnValue.add(ConfigInfo.fromJson(item));
      }
    }

    return returnValue;
  }

  Future<List<RouteInfo>> getAllRoutes() async {
    var result = await processGetRequest('api/Route');
    List<RouteInfo> returnValue = [];
    List<dynamic> json = jsonDecode(result);
    if (json.isNotEmpty) {
      for (var item in json) {
        returnValue.add(RouteInfo.fromJson(item));
      }
    }

    return returnValue;
  }

  Future<List<MapBranchSaleInfo>> getAllMapBranchSale(String branchCode) async {
    var result = await processGetRequest(
        'api/MapBranchSale/InitialSearch/' + branchCode);
    List<MapBranchSaleInfo> returnValue = [];
    List<dynamic> json = jsonDecode(result);
    if (json.isNotEmpty) {
      for (var item in json) {
        returnValue.add(MapBranchSaleInfo.fromJson(item));
      }
    }

    return returnValue;
  }
}
