import 'dart:io';

// import 'package:blue_print_pos/models/blue_device.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vansale/api/class/request/mobile/addBKRReq.dart';
import 'package:vansale/api/class/request/mobile/addCustomerOrderReq.dart';
import 'package:vansale/api/class/request/mobile/getProductReturnOfRouteReq.dart';
import 'package:vansale/api/class/request/mobile/payReq.dart';
import 'package:vansale/api/class/response/routeMobile/BasketReturnResp.dart';
import 'package:vansale/api/class/response/routeMobile/MapRouteResp.dart';
import 'package:vansale/api/class/response/routeMobile/addSendMoneyReq.dart';
import 'package:vansale/api/class/response/routeMobile/getBasketResp.dart';
import 'package:vansale/api/class/response/routeMobile/getCustomerPOhisResp.dart';
import 'package:vansale/api/class/response/routeMobile/getHisBasketResp.dart';
import 'package:vansale/api/class/response/routeMobile/getHisProduct.dart';
import 'package:vansale/api/class/response/routeMobile/getProductBranchResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductSetResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductStockResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSPOrderDTResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSaleStoreOrderResp.dart';
import 'package:vansale/api/class/response/routeMobile/getStartWorkResp.dart';
import 'package:vansale/api/class/response/routeMobile/getStoreDetailResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSupplierOrderResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSupplierResp.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/proTypeResp.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';
import 'package:vansale/api/class/response/routeMobile/searchRefuelResp.dart';
import 'package:vansale/api/class/response/routeMobile/userDataResp.dart';
import 'package:vansale/database/class/blueDevice.dart';
import 'package:vansale/screens/Pay/cashCheck_main.dart';

import 'response/routeMobile/getHisProductResp.dart';
import 'response/routeMobile/getSumMoneyResp.dart';

class GlobalParam {
  static String appVersion = "V.5.1";
  static String userID = "VP-DEV-0001";
  //Delivery image
  static File? deliveryImage;
  static List<File> imageStoreList = [];
  static String? typeMenuCode;
  static String? subMenuCode;
  static var VEHICLE = {
    'cVEHINM': 'หมายเลขรถ 1001',
    'cPLATE': 'บย 5826',
    'cVEHICD': 'V-1001',
    'cDRIVER': '0001',
    "cBRANCD": "BCH-0072",
    "cBRANNM": "สาขา ชะอำ",
    'cPPROVINCE': "เพชรบุรี"
  };

  static double? deliveryLocationStoreLatitude;
  static double? deliveryLocationStoreLongitude;
  static LatLng? currentLocationCheckIn;
  static var deliveryRouteToday = {
    "cRTECD": "",
    "cRTENM": "",
    "cGRPCD": '',
    "cBRANCD": ''
  };
  static List<PoHDAndPoDTResp> PoHDAndPoDT = [];
  static var basketReturn = {
    "basketReturnCount": 0,
    "basketReturnTotaliQTY": 0,
    "basketReturnPrice": 0.0,
    "xbasketReturnTotaliQTY": 0
  };
  static List<RouteCusResp> deliveryListStores = [];
  static RouteCusResp deliverySelectStore = RouteCusResp();
  static PoHDAndPoDTResp deliveryStoreSum = PoHDAndPoDTResp();
  static PoHDAndPoDTResp? deliveryStoreReturn;
  static List<QueryPodtResp> deliveryPodtList = [];
  static List<PoHDAndPoDTResp> deliveryProductList = [];
  static List<QueryPodtResp> deliveryPodtShow = [];
  static List<PoHDAndPoDTResp> deliveryProductShow = [];
  static List<GetCustHisWithDateResp> deliveryCustPOHisDate = [];
  static var deliveryCustPOHisBtnCheck = [];
  static var deliveryUnitList = [];
  static bool deliveryRegetPODT = true;
  static List<GetBasketResp> deliveryBasketList = [];
  static List<GetBasketResp> deliveryBasketShow = [];
  static List<AddBKRReq> deliveryBasketReq = [];
  static var deliveryBasketSum = {"item": '0', "total": '0.0'};
  static PayReq deliveryPayReq = PayReq(iDEBIT: 0.0);
  static GetStoreDetailResp deliveryStoreDetail = GetStoreDetailResp(
      cCUSTCD: '',
      cPOCD: '',
      iTOTAL: '0.0',
      dSUCCDT: '',
      dCANDT: '',
      iCREDLIM: '0',
      iCREDTERM: '0',
      iPAID: '0',
      iPOTOTAL: '0');
  static List<GetHisBasketResp> deliveryHisBasket = [];
  static List<GetHisProductResp> deliveryHisProduct = [];
  static List<GetHisProductResp> deliveryShowHisProduct = [];
  static List<QueryPodtResp> deliveryProIncom = [];
  static List<QueryPodtResp> deliveryPodCancel = [];
  static List<QueryPodtResp> deliveryReturnGoodPro = [];
  static List<QueryPodtResp> deliveryReturnBadPro = [];
  static double deliveryDebt = 0.0;
  static double deliveryRemainCredit = 0.0;
  static var deliveryCashCheck = {
    "bank": '',
    "checkType": '',
    "checkNum": '',
    "checkDate": '',
  };

  static AddSendMoneyReq deliveryAddSendMoney =
      AddSendMoneyReq(iTOTAL: 0.0, iCOST: 0.0);
  static GetSumMoneyResp sumSendMony = GetSumMoneyResp();
  static List<ProTypeResp> deliveryProType = [];
  static String deliveryReturnProRef = '';
  static bool bluetoothConnect = false;
  // static BlueDevice? selectDevice;
  static List<BluetoothDevice> blueListDevice = [];
  static var totalProGoodList = [];
  static var totalProBadList = [];
  static List<GetSupplierOrderResp> supplierOrderList = [];
  static List<GetSPOrderDTResp> supplierOrProductList = [];
  static List<GetSPOrderDTResp> supplierOrProductShowList = [];
  static GetSupplierOrderResp? supplierSelectOrder;
  static var supplierCheckProList = [];
  static int supplierCheckCounter = 0;
  static var supplierIncomProList = [];
  static var supplierReceive_NO = '';

  static var customer = {
    "cCUSTCD": "CUST-793",
    "cBRANCD": "BCH002",
    "cPRICECD": "007",
    "cCUSTTYPE": "Retail"
  };
  static GetCustomerPOHisResp? customerPOHDSelect;
  static List<GetCustomerPOHisResp> customerPOHDList = [];
  static List<QueryPodtResp> customerPODTList = [];
  static List<QueryPodtResp> customerProductList = [];
  static List<GetProductStockResp> customerStockProductList = [];
  static var customerPROmove = [];
  static String updateCustomerID = '';
  static List<SearchRefuelResp> refuelList = [];
  static String refuelRff = '';
  static UserDataResp userData = UserDataResp(
    cGUID: "",
    cUSRNM: "vpadmin",
    cEMPNM: "ผู้ดูแลระบบ",
    cPASSWRD: '',
    cPHOTOSERV: "",
    cPHOTOPATH: "",
    cISPHOTO: "Y",
    cBRANCD: "BCH001",
    cPOSNM: "0001",
    cPMSCD: "0001",
    cSTATUS: "Y",
  );
  static List<GetStartWorkResp> startWorkList = [];
  static List<GetProductBranchResp> customerProList = [];
  static List<GetProductBranchResp> customerShowProList = [];
  static List<GetProductBranchResp> customerGoodProList = [];
  static List<GetProductBranchResp> customerShowGoodProList = [];
  static List<GetProductBranchResp> customerBadProList = [];
  static List<GetProductBranchResp> customerShowBadProList = [];
  static List<GetProductBranchResp> customerReturnProList = [];
  static List<GetProductBranchResp> customerShowReturnProList = [];
  static List<GetProductBranchResp> customerRecheckPROStockList = [];
  static List<GetProductBranchResp> customerShowRecheckPROStockList = [];
  static List<MapRoute> mapRoute = [];
  static GetSupplierResp stockSupSelect = GetSupplierResp();
  static GetProductReturnOfRouteReq stockTransferReq =
      GetProductReturnOfRouteReq();

  static var stockRouteSelect = {
    "cRTECD": "",
    "cRTENM": "",
    "cGRPCD": '',
    "cBRANCD": ''
  };
  static List<GetProductSetResp> saleProductSetList = [];
  static List<GetProductSetResp> saleProductSetTransferList = [];
  static int stockReturnBasketItem = 0;
  static double stockReturnBasketTotal = 0;
  static GetSaleStoreOrderResp surveyStore = GetSaleStoreOrderResp();
  static AddCustomerOrderReq saleOrder = AddCustomerOrderReq();
  static List<GetSaleStoreOrderResp> saleList = [];
  static List<GetSaleStoreOrderResp> notSaleList = [];
}
