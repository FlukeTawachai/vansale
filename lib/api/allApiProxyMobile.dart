import 'dart:convert';

import 'package:vansale/api/apiProxyMobile.dart';
import 'package:vansale/api/class/request/mobile/PayReq.dart';
import 'package:vansale/api/class/request/mobile/addBKRReq.dart';
import 'package:vansale/api/class/request/mobile/addBarsketStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/addCheckInReq.dart';
import 'package:vansale/api/class/request/mobile/addCustomerOrderReq.dart';
import 'package:vansale/api/class/request/mobile/addLOSSPROReq.dart';
import 'package:vansale/api/class/request/mobile/addProductIncreateCounter.dart';
import 'package:vansale/api/class/request/mobile/addProductTransferReq.dart';
import 'package:vansale/api/class/request/mobile/addRTPROReq.dart';
import 'package:vansale/api/class/request/mobile/addRecheckStockProductReq.dart';
import 'package:vansale/api/class/request/mobile/addRefuelReq.dart';
import 'package:vansale/api/class/request/mobile/addReturnBasketToStock.dart';
import 'package:vansale/api/class/request/mobile/addReturnDTReq.dart';
import 'package:vansale/api/class/request/mobile/addReturnHDReq.dart';
import 'package:vansale/api/class/request/mobile/addReturnProductToStockReq.dart';
import 'package:vansale/api/class/request/mobile/addStockBalanceReq.dart';
import 'package:vansale/api/class/request/mobile/addStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/addSupplierCreditReq.dart';
import 'package:vansale/api/class/request/mobile/addSupplierReceivBillReq.dart';
import 'package:vansale/api/class/request/mobile/addSupplierReceiveDT.dart';
import 'package:vansale/api/class/request/mobile/addSupplierReceiveHDReq.dart';
import 'package:vansale/api/class/request/mobile/canclePoByBeforePOReq.dart';
import 'package:vansale/api/class/request/mobile/createPoByBeforePOReq.dart';
import 'package:vansale/api/class/request/mobile/deliveryPO.dart';
import 'package:vansale/api/class/request/mobile/getCustForSortingReq.dart';
import 'package:vansale/api/class/request/mobile/getCustHisWithDateReq.dart';
import 'package:vansale/api/class/request/mobile/getCustomerPODTReq.dart';
import 'package:vansale/api/class/request/mobile/getCustomerPOhisReq.dart';
import 'package:vansale/api/class/request/mobile/getGroupRouteReq.dart';
import 'package:vansale/api/class/request/mobile/getProductBranchReq.dart';
import 'package:vansale/api/class/request/mobile/getProductOrBasketStockReq.dart';
import 'package:vansale/api/class/request/mobile/getProductReturnOfRouteReq.dart';
import 'package:vansale/api/class/request/mobile/getProductReturnReq.dart';
import 'package:vansale/api/class/request/mobile/getProductSalePriceResp.dart';
import 'package:vansale/api/class/request/mobile/getProductStockReq.dart';
import 'package:vansale/api/class/request/mobile/getRefuelReq.dart';
import 'package:vansale/api/class/request/mobile/getRouteTodayReq.dart';
import 'package:vansale/api/class/request/mobile/getSPOrderDTReq.dart';
import 'package:vansale/api/class/request/mobile/getSaleStoreOrderReq.dart';
import 'package:vansale/api/class/request/mobile/getStartWorkReq.dart';
import 'package:vansale/api/class/request/mobile/getStoreDetailReq.dart';
import 'package:vansale/api/class/request/mobile/getSupplierOrderReq.dart';
import 'package:vansale/api/class/request/mobile/getVehicleWithBranchReq.dart';
import 'package:vansale/api/class/request/mobile/locationStoreReq.dart';
import 'package:vansale/api/class/request/mobile/pocdReq.dart';
import 'package:vansale/api/class/request/mobile/pohdAndPodtReq.dart';
import 'package:vansale/api/class/request/mobile/queryPodtReq.dart';
import 'package:vansale/api/class/request/mobile/routeCusReq.dart';
import 'package:vansale/api/class/request/mobile/routeReq.dart';
import 'package:vansale/api/class/request/mobile/searchBasket.dart';
import 'package:vansale/api/class/request/mobile/searchRefuelReq.dart';
import 'package:vansale/api/class/request/mobile/startStopWorkReq.dart';
import 'package:vansale/api/class/request/mobile/supplierCreditPayReq.dart';
import 'package:vansale/api/class/request/mobile/updateICLProReq.dart';
import 'package:vansale/api/class/request/mobile/updatePodtReq.dart';
import 'package:vansale/api/class/request/mobile/updatePohdReq.dart';
import 'package:vansale/api/class/request/mobile/updateReturnHDReq.dart';
import 'package:vansale/api/class/request/mobile/updateStatusAPPOHD.dart';
import 'package:vansale/api/class/request/mobile/updateStroreSortingReq.dart';
import 'package:vansale/api/class/response/routeMobile/BasketReturnResp.dart';
import 'package:vansale/api/class/response/routeMobile/addSendMoneyReq.dart';
import 'package:vansale/api/class/response/routeMobile/commonResp.dart';
import 'package:vansale/api/class/response/routeMobile/getBasketResp.dart';
import 'package:vansale/api/class/response/routeMobile/getBasketReturnOfRoute.dart';
import 'package:vansale/api/class/response/routeMobile/getBranchAllResp.dart';
import 'package:vansale/api/class/response/routeMobile/getCustForSortingResp.dart';
import 'package:vansale/api/class/response/routeMobile/getCustInRouteResp.dart';
import 'package:vansale/api/class/response/routeMobile/getCustomerGroupResp.dart';
import 'package:vansale/api/class/response/routeMobile/getCustomerPODTResp.dart';
import 'package:vansale/api/class/response/routeMobile/getCustomerPOhisResp.dart';
import 'package:vansale/api/class/response/routeMobile/getCustomerResp.dart';
import 'package:vansale/api/class/response/routeMobile/getGroupRouteResp.dart';
import 'package:vansale/api/class/response/routeMobile/getHisBasketResp.dart';
import 'package:vansale/api/class/response/routeMobile/getHisProduct.dart';
import 'package:vansale/api/class/response/routeMobile/getHisProductResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductBranchResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductOfSupplier.dart';
import 'package:vansale/api/class/response/routeMobile/getProductOrBasketStockResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductReturnOfRouteResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductReturnResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductSetResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductStockResp.dart';
import 'package:vansale/api/class/response/routeMobile/getRefuel.dart';
import 'package:vansale/api/class/response/routeMobile/getRefuelHisOfDayResp.dart';
import 'package:vansale/api/class/response/routeMobile/getRouteTodayResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSPOrderDTResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSaleStoreOrderResp.dart';
import 'package:vansale/api/class/response/routeMobile/getStartWorkResp.dart';
import 'package:vansale/api/class/response/routeMobile/getStoreDetailResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSumMoneyResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSupplierBasketResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSupplierOrderResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSupplierResp.dart';
import 'package:vansale/api/class/response/routeMobile/getVehicleWithBranchResp.dart';
import 'package:vansale/api/class/response/routeMobile/locationStoreResp.dart';
import 'package:vansale/api/class/response/routeMobile/pocdResp.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/proTypeResp.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeResp.dart';
import 'package:vansale/api/class/response/routeMobile/searchRefuelResp.dart';

import 'class/request/mobile/getCustomerOfBranchReq.dart';
import 'class/request/mobile/getVehicleResp.dart';
import 'class/response/routeMobile/MapRouteResp.dart';
import 'class/response/routeMobile/getCustomerOfBranchResp.dart';

class AllApiProxyMobile extends ApiProxyMobile {
  // +++++++++++++++++++++ Route +++++++++++++++++++++
  Future<List<RouteResp>> getRoute(String cRTENM, String cBRANCD) async {
    RouteReq req = RouteReq(cRTENM: cRTENM, cBRANCD: cBRANCD);

    // print('Request to apiRoute/getRoute');
    String result;
    result =
        await processPostRequest('apiRoute/getRoute', jsonEncode(req.toJson()));
    // print('API Response : ' + result);

    if (result != null) {
      List<RouteResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(RouteResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<RouteCusResp>> getRouteTransfer(String cRTECD,
      String shippingDate, String cGRPCD, String cBRANCD, bool cUSEDT) async {
    RouteCusReq req = RouteCusReq(
        cRTECD: cRTECD,
        dSHIPDATE: shippingDate,
        cGRPCD: cGRPCD,
        cBRANCD: cBRANCD,
        cUSEDT: cUSEDT);

    // print('Request to apiRoute/getRouteTransfers');
    String result;
    result = await processPostRequest(
        'apiRoute/getRouteTransfers', jsonEncode(req.toJson()));
    // print('API Response : ' + result);

    if (result != null) {
      List<RouteCusResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(RouteCusResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<PocdResp> getPocd(String cCUSTCD, String dSHIPDATE) async {
    PocdReq req = PocdReq(cCUSTCD: cCUSTCD, dSHIPDATE: dSHIPDATE);

    print('Request to apiRoute/getPOCD');
    String result;
    result =
        await processPostRequest('apiRoute/getPOCD', jsonEncode(req.toJson()));
    // print('API apiRoute/Response : ' + result);

    if ((result != null) && (result != '')) {
      PocdResp returnValue = PocdResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return PocdResp(cCUSTCD: cCUSTCD, cPOCD: '', dPODATE: '');
    }
  }

  Future<List<PoHDAndPoDTResp>> getBaskets(
      String custcd, String pocd, String cPRODNM, String cPRODCD) async {
    PoHDAndPoDTReq req = PoHDAndPoDTReq(
        custcd: custcd, pocd: pocd, cPRODNM: cPRODNM, cPRODCD: cPRODCD);

    print('Request to apiRoute/getPoHDAndPoDT');
    String result;
    result = await processPostRequest(
        'apiRoute/getPoHDAndPoDT', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<PoHDAndPoDTResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(PoHDAndPoDTResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<BasketReturnResp>> getBasketReturn(data) async {
    print('Request to apiStock/getBasketReturn');
    String result;
    result =
        await processPostRequest('apiStock/getBasketReturn', jsonEncode(data));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<BasketReturnResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(BasketReturnResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<QueryPodtResp>> getPodt(QueryPodtReq req) async {
    print('Request to apiRoute/queryPODTwithPOCD');
    String result;
    result = await processPostRequest(
        'apiRoute/queryPODTwithPOCD', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<QueryPodtResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(QueryPodtResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<CommonResp> updatePodt(
    String cPOCD,
    int iSEQ,
    String cPREPAIRSTATUS,
    double iPREPAIRAMOUT,
  ) async {
    UpdatePodtReq req = UpdatePodtReq(
        cPOCD: cPOCD,
        iSEQ: iSEQ,
        cPREPAIRSTATUS: cPREPAIRSTATUS,
        iPREPAIRAMOUT: iPREPAIRAMOUT);

    print('Request to apiRoute/updatePODT-PREPAIRSTATUS');
    String result;
    result = await processPostRequest(
        'apiRoute/updatePODT-PREPAIRSTATUS', jsonEncode(req.toJson()));
    // print('API apiRoute/updatePODT-PREPAIRSTATUS : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> updatePohd(
    String cPOCD,
    String cPREPAIRCFSTATUS,
    double iBASKETTOTAL,
  ) async {
    UpdatePohdReq req = UpdatePohdReq(
        cPOCD: cPOCD,
        cPREPAIRCFSTATUS: cPREPAIRCFSTATUS,
        iBASKETTOTAL: iBASKETTOTAL);

    print('Request to apiRoute/updatePOHD-PREPAIRCFSTATUS');
    String result;
    result = await processPostRequest(
        'apiRoute/updatePOHD-PREPAIRCFSTATUS', jsonEncode(req.toJson()));
    // print('API apiRoute/updatePOHD-PREPAIRCFSTATUS : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<LocationStoreResp> getLocationStore(String custcd) async {
    LocationStoreReq req = LocationStoreReq(cCUSTCD: custcd);

    print('Request to apiRoute/getLocationOfStore');
    String result;
    result = await processPostRequest(
        'apiRoute/getLocationOfStore', jsonEncode(req.toJson()));
    // print('API apiRoute/Response : ' + result);

    if (result != null && result != '') {
      LocationStoreResp returnValue =
          LocationStoreResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return LocationStoreResp(
          cGUID: '',
          cCUSTCD: custcd,
          cLATITUDE: '',
          cLONGTITUDE: '',
          dUPDADT: '',
          cUPDABY: '');
    }
  }

  Future<getRouteTodayResp> getRouteToday(
      String cVEHICD, String cBRANCD, String cRTENM) async {
    getRouteTodayReq req =
        getRouteTodayReq(cVEHICD: cVEHICD, cBRANCD: cBRANCD, cRTENM: cRTENM);

    // print('Request to apiRoute/getRouteToday');
    String result;
    result = await processPostRequest(
        'apiRoute/getRouteToday', jsonEncode(req.toJson()));
    // print('API apiRoute/Response : ' + result);

    if ((result != null) && (result != '')) {
      getRouteTodayResp returnValue =
          getRouteTodayResp.fromJson(jsonDecode(result));

      print('API Response : ' + result);

      return returnValue;
    } else {
      return getRouteTodayResp(cRTECD: '', cRTENM: '');
    }
  }

  Future<CommonResp> addAndUpdateCheckIn(AddCheckInReq req) async {
    // print('Request to apiRoute/addPOCheckIn');
    String result;
    result = await processPostRequest(
        'apiRoute/addPOCheckIn', jsonEncode(req.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> updateICLPro(String cPOCD, int iSEQ, int iINCOMPRO,
      int iCANCLEPRO, int iLOSSPRO, String cUPDABY) async {
    UpdateICLProReq req = UpdateICLProReq(
        cPOCD: cPOCD,
        iSEQ: iSEQ,
        iINCOMPRO: iINCOMPRO,
        iCANCLEPRO: iCANCLEPRO,
        iLOSSPRO: iLOSSPRO,
        cUPDABY: cUPDABY);

    print('Request to apiRoute/updateICLPro');
    String result;
    result = await processPostRequest(
        'apiRoute/updateICLPro', jsonEncode(req.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> addRTPRO(AddRTPROReq request) async {
    AddRTPROReq req = request;

    // print('Request to apiRoute/addRTPRO');
    String result;
    result =
        await processPostRequest('apiRoute/addRTPRO', jsonEncode(req.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> addLOSSPRO(AddLOSSPROReq request) async {
    AddLOSSPROReq req = request;

    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiRoute/addLOSSPRO', jsonEncode(req.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<List<GetBasketResp>> getBasket(SearchBasketReq request) async {
    SearchBasketReq req = request;

    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiRoute/searchBasket', jsonEncode(req.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      List<dynamic> json = jsonDecode(result);
      List<GetBasketResp> basketList = [];
      for (int i = 0; i < json.length; i++) {
        GetBasketResp returnValue = GetBasketResp.fromJson(json[i]);
        basketList.add(returnValue);
      }

      // print('API Response : ' + result);

      return basketList;
    } else {
      return [];
    }
  }

  Future<CommonResp> addBKR(AddBKRReq request) async {
    AddBKRReq req = request;

    // print('Request to apiRoute/addRTPRO');
    String result;
    result =
        await processPostRequest('apiRoute/addBKR', jsonEncode(req.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<List<ProTypeResp>> getProType() async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processGetRequest('apiRoute/getProType');
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      List<dynamic> json = jsonDecode(result);
      List<ProTypeResp> typeList = [];
      for (int i = 0; i < json.length; i++) {
        ProTypeResp returnValue = ProTypeResp.fromJson(json[i]);
        typeList.add(returnValue);
      }

      // print('API Response : ' + result);

      return typeList;
    } else {
      return [];
    }
  }

  Future<CommonResp> payment(PayReq request) async {
    PayReq req = request;

    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiRoute/mobilePayment', jsonEncode(req.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> deliveryPO(DeliveryPOReq request) async {
    DeliveryPOReq req = request;

    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiRoute/deliveryPO', jsonEncode(req.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> addSendMoney(AddSendMoneyReq req) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiRoute/addSendMoney', jsonEncode(req.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<GetSumMoneyResp> getSumMoney(RouteCusReq request) async {
    RouteCusReq req = request;

    // print('Request to apiRoute/getRouteTransfers');
    String result;
    result = await processPostRequest(
        'apiRoute/getSumMoney', jsonEncode(req.toJson()));
    // print('API Response : ' + result);

    if ((result != null) && (result != '')) {
      GetSumMoneyResp returnValue =
          GetSumMoneyResp.fromJson(jsonDecode(result));

      print('API Response : ' + result);

      return returnValue;
    } else {
      return GetSumMoneyResp(cBRANCD: '');
    }
  }

  Future<List<GetHisBasketResp>> getHisBasket(GetStoreDetailReq request) async {
    GetStoreDetailReq req = request;

    // print('Request to apiRoute/getRouteTransfers');
    String result;
    result = await processPostRequest(
        'apiRoute/getHisBasket', jsonEncode(req.toJson()));
    // print('API Response : ' + result);

    if ((result != null) && (result != '')) {
      List<dynamic> json = jsonDecode(result);
      List<GetHisBasketResp> typeList = [];
      for (int i = 0; i < json.length; i++) {
        GetHisBasketResp returnValue = GetHisBasketResp.fromJson(json[i]);
        typeList.add(returnValue);
      }

      // print('API Response : ' + result);

      return typeList;
    } else {
      return [];
    }
  }

  Future<GetStoreDetailResp> getStoreDetail(GetStoreDetailReq request) async {
    GetStoreDetailReq req = request;

    // print('Request to apiRoute/getRouteTransfers');
    String result;
    result = await processPostRequest(
        'apiRoute/getStoreDetail', jsonEncode(req.toJson()));
    // print('API Response : ' + result);

    if ((result != null) && (result != '')) {
      GetStoreDetailResp returnValue =
          GetStoreDetailResp.fromJson(jsonDecode(result));

      print('API Response : ' + result);

      return returnValue;
    } else {
      return GetStoreDetailResp(cCUSTCD: '');
    }
  }

  Future<List<GetHisProductResp>> getHisProduct(
      GetStoreDetailReq request) async {
    GetStoreDetailReq req = request;

    // print('Request to apiRoute/getRouteTransfers');
    String result;
    result = await processPostRequest(
        'apiRoute/getHisProduct', jsonEncode(req.toJson()));
    // print('API Response : ' + result);

    if ((result != null) && (result != '')) {
      List<dynamic> json = jsonDecode(result);
      List<GetHisProductResp> typeList = [];
      for (int i = 0; i < json.length; i++) {
        GetHisProductResp returnValue = GetHisProductResp.fromJson(json[i]);
        typeList.add(returnValue);
      }

      // print('API Response : ' + result);

      return typeList;
    } else {
      return [];
    }
  }

  Future<CommonResp> addStockCard(StockCardReq request) async {
    StockCardReq req = request;

    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiStock/addStockCard', jsonEncode(req.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> addStockBalance(StockBalanceReq request) async {
    StockBalanceReq req = request;

    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiStock/addStockBalance', jsonEncode(req.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> addReturnHD(AddReturnHDReq request) async {
    AddReturnHDReq req = request;

    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiStock/addReturnHD', jsonEncode(req.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> updateReturnHD(UpdateReturnHDReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiStock/updateReturnHD', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> addReturnDT(AddReturnDTReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiStock/addReturnDT', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> addBasketStockCard(AddBasketStockCardReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiStock/addBasketStockCard', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<List<GetSupplierOrderResp>> getSupplierOrder(
      GetSupplierOrderReq request) async {
    GetSupplierOrderReq req = request;

    // print('Request to apiRoute/getRouteTransfers');
    String result;
    result = await processPostRequest(
        'apiBranchStock/getSupplierOrder', jsonEncode(req.toJson()));
    // print('API Response : ' + result);

    if ((result != null) && (result != '')) {
      List<dynamic> json = jsonDecode(result);
      List<GetSupplierOrderResp> typeList = [];
      for (int i = 0; i < json.length; i++) {
        GetSupplierOrderResp returnValue =
            GetSupplierOrderResp.fromJson(json[i]);
        typeList.add(returnValue);
      }

      // print('API Response : ' + result);

      return typeList;
    } else {
      return [];
    }
  }

  Future<List<GetSPOrderDTResp>> getSPOrderDT(GetSPOrderDTReq request) async {
    GetSPOrderDTReq req = request;

    // print('Request to apiRoute/getRouteTransfers');
    String result;
    result = await processPostRequest(
        'apiBranchStock/getSPOrderDT', jsonEncode(req.toJson()));
    // print('API Response : ' + result);

    if ((result != null) && (result != '')) {
      List<dynamic> json = jsonDecode(result);
      List<GetSPOrderDTResp> typeList = [];
      for (int i = 0; i < json.length; i++) {
        GetSPOrderDTResp returnValue = GetSPOrderDTResp.fromJson(json[i]);
        typeList.add(returnValue);
      }

      // print('API Response : ' + result);

      return typeList;
    } else {
      return [];
    }
  }

  Future<CommonResp> addSupplierCredit(AddSupplierCreditReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiBranchStock/addSupplierCredit', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> addSupplierReceiveHD(
      AddSupplierReceiveHDReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiBranchStock/addSupplierReceiveHD', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> addSupplierReceiveDT(
      AddSupplierReceiveDTReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiBranchStock/addSupplierReceiveDT', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> supplierCreditPay(SupplierCreditPayReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiBranchStock/supplierCreditPay', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> addSupplierReceivBill(
      AddSupplierReceivBillReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiBranchStock/addSupplierReceivBill', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> updateStatusAPPOHD(UpdateStatusAPPOHDReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiBranchStock/updateStatusAPPOHD', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<List<GetCustomerPOHisResp>> getCustomerPOHis(
      GetCustomerPOHisReq req) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processPostRequest(
        'apiStore/getCustomerPOHis', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetCustomerPOHisResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetCustomerPOHisResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetCustomerPODTResp>> getCustomerPODT(
      GetCustomerPODTReq req) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processPostRequest(
        'apiStore/getCustomerPODT', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetCustomerPODTResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetCustomerPODTResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetGroupRouteResp>> getRouteGroup(GetGroupRouteReq req) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processPostRequest(
        'apiRoute/getRouteGroup', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetGroupRouteResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetGroupRouteResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetCustInRouteResp>> getCustInRoute(GetGroupRouteReq req) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processPostRequest(
        'apiRoute/getCustInRoute', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetCustInRouteResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetCustInRouteResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetCustHisWithDateResp>> getCustHisWithDate(
      GetCustHisWithDateReq req) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processPostRequest(
        'apiRoute/getCustHisWithDate', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetCustHisWithDateResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetCustHisWithDateResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetCustForSortingResp>> getCustForSorting(
      GetCustForSortingReq req) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processPostRequest(
        'apiRoute/getCustForSorting', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetCustForSortingResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetCustForSortingResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetCustomerOfBranchResp>> getCustomerOfBranch(
      GetCustomerOfBranchReq req) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processPostRequest(
        'apiRoute/getCustomerOfBranch', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetCustomerOfBranchResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetCustomerOfBranchResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetBranchAllResp>> getBranchAll() async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processGetRequest('apiRoute/getBranchAll');
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetBranchAllResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetBranchAllResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<MapRoute>> getMapRoute() async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processGetRequest('apiRoute/getMapRoute');
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<MapRoute> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(MapRoute.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<CommonResp> updateStroreSorting(UpdateStroreSortingReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiRoute/updateStroreSorting', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<List<GetCustomerResp>> getCustomer(String id) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processGetRequest('apiRoute/getCustomer/$id');
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetCustomerResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetCustomerResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetCustomerGroupResp>> getCustomerGroup(String id) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processGetRequest('apiRoute/getCustomerGroup/$id');
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetCustomerGroupResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetCustomerGroupResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<SearchRefuelResp>> searchRefuel(SearchRefuelReq req) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processPostRequest(
        'apiRoute/searchRefuel', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<SearchRefuelResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(SearchRefuelResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<CommonResp> addRefuel(AddRefuelReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiRoute/addRefuel', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<List<GetRefuelHisOfDayResp>> getRefuelHisOfDay(
      SearchRefuelReq req) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processPostRequest(
        'apiRoute/getRefuelHisOfDay', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetRefuelHisOfDayResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetRefuelHisOfDayResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<CommonResp> startStopWork(StartStopWorkReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiCommon/startStopWork', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<List<GetStartWorkResp>> getStartWork(GetStartWorkReq req) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processPostRequest(
        'apiCommon/getStartWork', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetStartWorkResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetStartWorkResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetProductStockResp>> getProductStock(
      GetProductStockReq req) async {
    // print('Request to apiRoute/getCustomerPOHis');
    String result;
    result = await processPostRequest(
        'apiStock/getProductStock', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetProductStockResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetProductStockResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<CommonResp> addCustomerOrder(AddCustomerOrderReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiStore/addCustomerOrder', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<List<GetProductBranchResp>> getProductBranch(
      GetProductBranchReq req) async {
    // print('Request to apiRoute/queryPODTwithPOCD');
    String result;
    result = await processPostRequest(
        'apiStore/getProductBranch', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetProductBranchResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetProductBranchResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<CommonResp> createPoByBeforePO(CreatePoByBeforePOReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiPoByBeforePO/createPoByBeforePO', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> canclePoByBeforePO(CanclePoByBeforePOReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiPoByBeforePO/canclePoByBeforePO', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<List<GetSupplierResp>> getSupplier() async {
    print('Request to apiRoute/queryPODTwithPOCD');
    String result;
    result = await processGetRequest('apiSupplier/getSupplier');
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetSupplierResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetSupplierResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetSupplierBasketResp>> getSupplierBasket(String id) async {
    print('Request to apiRoute/queryPODTwithPOCD');
    String result;
    result = await processGetRequest('apiSupplier/getSupplier/$id');
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetSupplierBasketResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetSupplierBasketResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetProductOfSupplierResp>> getProductOfSupplier(String id) async {
    print('Request to apiRoute/queryPODTwithPOCD');
    String result;
    result = await processGetRequest('apiSupplier/getProductOfSupplier/$id');
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetProductOfSupplierResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetProductOfSupplierResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetProductReturnOfRouteResp>> getProductReturnOfRoute(
      GetProductReturnOfRouteReq req) async {
    // print('Request to apiRoute/getRouteTransfers');
    String result;
    result = await processPostRequest(
        'apiSupplier/getProductReturnOfRoute', jsonEncode(req.toJson()));
    // print('API Response : ' + result);

    if ((result != null) && (result != '')) {
      List<dynamic> json = jsonDecode(result);
      List<GetProductReturnOfRouteResp> typeList = [];
      for (int i = 0; i < json.length; i++) {
        var returnValue = GetProductReturnOfRouteResp.fromJson(json[i]);
        typeList.add(returnValue);
      }

      // print('API Response : ' + result);

      return typeList;
    } else {
      return [];
    }
  }

  Future<List<GetBasketReturnOfRouteResp>> getBasketReturnOfRoute(
      GetProductReturnOfRouteReq req) async {
    // print('Request to apiRoute/getRouteTransfers');
    String result;
    result = await processPostRequest(
        'apiSupplier/getBasketReturnOfRoute', jsonEncode(req.toJson()));
    // print('API Response : ' + result);

    if ((result != null) && (result != '')) {
      List<dynamic> json = jsonDecode(result);
      List<GetBasketReturnOfRouteResp> typeList = [];
      for (int i = 0; i < json.length; i++) {
        var returnValue = GetBasketReturnOfRouteResp.fromJson(json[i]);
        typeList.add(returnValue);
      }

      // print('API Response : ' + result);

      return typeList;
    } else {
      return [];
    }
  }

  Future<List<GetProductOrBasketStockResp>> getProductOrBasketStock(
      GetProductOrBasketStockReq req) async {
    // print('Request to apiRoute/getRouteTransfers');
    String result;
    result = await processPostRequest(
        'apiStock/getProductOrBasketStock', jsonEncode(req.toJson()));
    // print('API Response : ' + result);

    if ((result != null) && (result != '')) {
      List<dynamic> json = jsonDecode(result);
      List<GetProductOrBasketStockResp> typeList = [];
      for (int i = 0; i < json.length; i++) {
        var returnValue = GetProductOrBasketStockResp.fromJson(json[i]);
        typeList.add(returnValue);
      }

      // print('API Response : ' + result);

      return typeList;
    } else {
      return [];
    }
  }

  Future<List<GetProductReturnResp>> getProductReturn(
      GetProductReturnReq req) async {
    // print('Request to apiRoute/getRouteTransfers');
    String result;
    result = await processPostRequest(
        'apiStock/getProductReturn', jsonEncode(req.toJson()));
    // print('API Response : ' + result);

    if ((result != null) && (result != '')) {
      List<dynamic> json = jsonDecode(result);
      List<GetProductReturnResp> typeList = [];
      for (int i = 0; i < json.length; i++) {
        var returnValue = GetProductReturnResp.fromJson(json[i]);
        typeList.add(returnValue);
      }

      // print('API Response : ' + result);

      return typeList;
    } else {
      return [];
    }
  }

  Future<CommonResp> addReturnProductToStock(
      AddReturnProductToStockReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiStock/addReturnProductToStock', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<CommonResp> addReturnBasketToStock(
      AddReturnBasketToStockReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiStock/addReturnBasketToStock', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<List<GetProductSalePriceResp>> getProductSalePrice() async {
    // print('Request to apiRoute/queryPODTwithPOCD');
    String result;
    result = await processGetRequest('apiStock/getProductSalePrice');
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetProductSalePriceResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetProductSalePriceResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<CommonResp> addRecheckStockProduct(
      AddRecheckStockProductReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiStock/addRecheckStockProduct', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<List<GetSaleStoreOrderResp>> getSaleStoreOrder(
      GetSaleStoreOrderReq req) async {
    // print('Request to apiRoute/queryPODTwithPOCD');
    String result;
    result = await processPostRequest(
        'apiSellRoot/getSaleStoreOrder', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetSaleStoreOrderResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetSaleStoreOrderResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetVehicleWithBranchResp>> getVehicleWithBranch(
      GetVehicleWithBranchReq req) async {
    // print('Request to apiRoute/queryPODTwithPOCD');
    String result;
    result = await processPostRequest(
        'apiSellRoot/getVehicleWithBranch', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetVehicleWithBranchResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetVehicleWithBranchResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<List<GetProductSetResp>> getProductSet(
      GetVehicleWithBranchReq req) async {
    // print('Request to apiRoute/queryPODTwithPOCD');
    String result;
    result = await processPostRequest(
        'apiSellRoot/getProductSet', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if (result != null) {
      List<GetProductSetResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetProductSetResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

  Future<CommonResp> addProductTransfer(AddProductTransferReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiStock/addProductTransfer', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<GetRefuelResp> getRefuel(GetRefuelReq req) async {
    // print('Request to apiRoute/queryPODTwithPOCD');
    String result;
    result = await processPostRequest(
        'apiRoute/getRefuel', jsonEncode(req.toJson()));
    // print('apiRoute/API Response : ' + result);

    if ((result != null) && (result != '')) {
      GetRefuelResp returnValue = GetRefuelResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return GetRefuelResp();
    }
  }

  Future<CommonResp> addProductIncreateCounter(
      AddProductIncreateCounterReq request) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processPostRequest(
        'apiRoute/addProductIncreateCounter', jsonEncode(request.toJson()));
    // print('API apiRoute/addPOCheckIn : ' + result);

    if ((result != null) && (result != '')) {
      CommonResp returnValue = CommonResp.fromJson(jsonDecode(result));

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return CommonResp(success: false, message: '', result: null);
    }
  }

  Future<List<GetVehicleResp>> getVehicle(String cVEHICD) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processGetRequest('apiStock/getVehicle/$cVEHICD');
    // print('API apiRoute/addPOCheckIn : ' + result);
    if (result != null) {
      List<GetVehicleResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetVehicleResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }

    Future<List<GetVehicleResp>> getVehicleInBranch(String cBRANCD) async {
    // print('Request to apiRoute/addRTPRO');
    String result;
    result = await processGetRequest('apiStock/getVehicleInBranch/$cBRANCD');
    // print('API apiRoute/addPOCheckIn : ' + result);
    if (result != null) {
      List<GetVehicleResp> returnValue = [];

      List<dynamic> json = jsonDecode(result);

      if (json.isNotEmpty) {
        for (var item in json) {
          returnValue.add(GetVehicleResp.fromJson(item));
        }
      }

      // print('API Response : ' + result);

      return returnValue;
    } else {
      return [];
    }
  }
}
