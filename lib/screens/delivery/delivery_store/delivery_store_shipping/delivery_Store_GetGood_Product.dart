import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addReturnDTReq.dart';
import 'package:vansale/api/class/request/mobile/addReturnHDReq.dart';
import 'package:vansale/api/class/request/mobile/addStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/getStoreDetailReq.dart';
import 'package:vansale/api/class/response/routeMobile/getHisProduct.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/screens/Supplier/models/delayTime.dart';
import 'package:vansale/screens/delivery/delivery_scanner.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_GetBad_Product.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_filter.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_good_product.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_store_image_product.dart';
import 'package:vansale/screens/delivery/delivery_store_footer.dart';

DelayTime delay = new DelayTime();

class DeliveryStoreGetGoodProduct extends StatefulWidget {
  final String typeMenuCode;
  final String routeName;
  DeliveryStoreGetGoodProduct(this.typeMenuCode, this.routeName);
  @override
  _DeliveryStoreGetGoodProductState createState() =>
      _DeliveryStoreGetGoodProductState();
}

class _DeliveryStoreGetGoodProductState
    extends State<DeliveryStoreGetGoodProduct> {
  double widthScreen;
  String cCUSTCD = GlobalParam.deliverySelectStore.cCUSTCD;
  String cPOCD = GlobalParam.deliveryStoreSum.cPOCD;
  List<QueryPodtResp> podtList = [];
  List<QueryPodtResp> podtListNstatus = [];
  List<PoHDAndPoDTResp> productList = [];

  String total = '0.0';
  final formatNum = new NumberFormat("#,###.##", "en_US");
  var totalProGoodList = [];
  List<TextEditingController> sController = [];
  List<TextEditingController> mController = [];
  List<TextEditingController> lController = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GlobalParam.deliveryUnitList = [];
    if (GlobalParam.deliveryRegetPODT == true) {
      getHisProduct('%%', '%%');
      GlobalParam.deliveryRegetPODT = false;
    }
    GlobalParam.deliveryReturnGoodPro = [];
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0.0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            'สินค้าดี',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Prompt',
            ),
          ),
          actions: [
            GlobalParam.subMenuCode == "003"
                ? IconButton(
                    onPressed: () {}, icon: Icon(LineAwesomeIcons.print))
                : Container()
          ],
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlobalParam.subMenuCode != "003"
                  ? Container(
                      alignment: Alignment.centerLeft,
                      color: HexColor('#6c7e9b'),
                      height: 60.0,
                      child: Row(
                        children: [
                          Container(
                            width: widthScreen * 0.74,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: TextField(
                                      onSubmitted: (value) {
                                        if (value != '' && value != null) {
                                          getShowHisProduct('%%', '%${value}%');
                                        } else {
                                          // getShowHisProduct('%%', '%%');
                                          GlobalParam.deliveryShowHisProduct =
                                              GlobalParam.deliveryHisProduct;
                                        }
                                      },
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                      ),
                                      textInputAction: TextInputAction.search,
                                      decoration: InputDecoration(
                                        hintText: "ค้นหา",
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 5.0, top: 5.0),
                                        prefixIcon: RotatedBox(
                                          quarterTurns: 1,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.search,
                                              color: HexColor('#6c7e9b'),
                                            ),
                                            onPressed: () {},
                                            iconSize: 25.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: IconButton(
                                      icon: const Icon(Icons.qr_code),
                                      iconSize: 25.0,
                                      color: Colors.black,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DeliveryQrScanner(
                                                      code: '005',
                                                      navigator: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                DeliveryStoreGetGoodProduct(
                                                                    GlobalParam
                                                                        .typeMenuCode,
                                                                    ''),
                                                          ),
                                                        );
                                                      },
                                                    )));
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: widthScreen * 0.2,
                            height: 48,
                            child: Card(
                              elevation: 0.0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FilterPage(
                                            pageNumber: '001',
                                          )));
                                },
                                child: Container(
                                  color: Colors.black12,
                                  height: 50.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'ประเภท',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      //fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              GlobalParam.subMenuCode == "003"
                  ? Container(
                      alignment: Alignment.centerLeft,
                      color: HexColor('#6c7e9b'),
                      height: 60.0,
                      child: Center(
                          child: Text(
                        widget.routeName,
                        style: TextStyle(fontSize: 18, fontFamily: "Prompt"),
                      )))
                  : Container(),
              Expanded(child: listOfProduct()),
            ],
          ),
        ),
        bottomNavigationBar: GlobalParam.subMenuCode != "003"
            ? DeliveryFooter(
                title1: 'บันทึกสินค้าดี',
                title2: '',
                item: double.parse('${GlobalParam.deliveryUnitList.length}'),
                navigated1: () {
                  // for (int i = 0;
                  //     i < GlobalParam.deliveryReturnGoodPro.length;
                  //     i++) {
                  //   print("++++++++++++++++++++++++++++++++++++++++++++++++");
                  //   print('${GlobalParam.deliveryReturnGoodPro[i].cPRODNM}');
                  //   print(
                  //       'S ${GlobalParam.deliveryReturnGoodPro[i].iSSIZEQTY}');
                  //   print(
                  //       "M ${GlobalParam.deliveryReturnGoodPro[i].iMSIZEQTY}");
                  //   print(
                  //       'L ${GlobalParam.deliveryReturnGoodPro[i].iLSIZEQTY}');
                  //   print(GlobalParam.deliveryReturnGoodPro[i].iCANCLEPRO);
                  // }
                  // // for (int i = 0;
                  //     i < GlobalParam.deliveryPodtList.length;
                  //     i++) {
                  //   updateICLPro(
                  //       GlobalParam.deliveryPodtList[i].cPOCD,
                  //       GlobalParam.deliveryPodtList[i].iSEQ,
                  //       GlobalParam.deliveryPodtList[i].iINCOMPRO,
                  //       GlobalParam.deliveryPodtList[i].iCANCLEPRO,
                  //       GlobalParam.deliveryPodtList[i].iLOSSPRO,
                  //       GlobalParam.deliveryPodtList[i].cUPDABY);
                  // }
                  addReturnHD();
                },
                navigated2: () {},
                icon1: Icon(
                  LineAwesomeIcons.check_circle,
                  color: Colors.green,
                  size: 25.0,
                ),
                icon2: Icon(
                  LineAwesomeIcons.check_circle,
                  color: Colors.green,
                  size: 25.0,
                ),
              )
            : Container(
                height: 0,
              ));
  }

  updateICLPro(String cPOCD, int iSEQ, int iINCOMPRO, int iCANCLEPRO,
      int iLOSSPRO, String cUPDABY) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.updateICLPro(
          cPOCD, iSEQ, iINCOMPRO, iCANCLEPRO, iLOSSPRO, cUPDABY);
      if (result.success == false) {
        wrongDialog(result.message);
      }
      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getHisProduct(String cPRODCD, String cPRODNM) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getHisProduct(GetStoreDetailReq(
          cCUSTCD: GlobalParam.deliverySelectStore.cCUSTCD,
          cPRODCD: cPRODCD,
          cPRODNM: cPRODNM));
      GlobalParam.deliveryHisProduct.clear();
      GlobalParam.deliveryShowHisProduct.clear();
      // ignore: deprecated_member_use
      List<GetHisProductResp> saveList = new List<GetHisProductResp>();
      if (result.isNotEmpty) {
        for (var item in result) {
          GetHisProductResp save = new GetHisProductResp(
              cBRNDCD: item.cBRNDCD,
              cBRNDNM: item.cBRNDCD,
              cCATECD: item.cCATECD,
              cCATENM: item.cCATENM,
              cLUOMCD: item.cLUOMCD,
              cLUOMNM: item.cLUOMNM,
              cMUOMCD: item.cMUOMCD,
              cMUOMNM: item.cMUOMNM,
              cPHOTONM: item.cPHOTONM,
              cPHOTOPATH: item.cPHOTOPATH,
              cPHOTOSERV: item.cPHOTOSERV,
              cPRODCD: item.cPRODCD,
              cPRODNM: item.cPRODNM,
              cSTATUS: item.cSTATUS,
              cSUBCATECD: item.cSUBCATECD,
              cSUBCATENM: item.cSUBCATENM,
              cSUOMCD: item.cSUOMCD,
              cSUOMNM: item.cSUOMNM,
              cTYPE: item.cTYPE,
              cTYPENM: item.cTYPENM,
              iCANCLEPRO: item.iCANCLEPRO,
              iINCOMPRO: item.iINCOMPRO,
              iLOSSPRO: item.iLOSSPRO,
              iLSIZEQTY: "0.0",
              iLUNITPRICE: item.iLUNITPRICE,
              iMSIZEQTY: "0.0",
              iMUNITPRICE: item.iMUNITPRICE,
              iSSIZEQTY: "0.0",
              iSUNITPRICE: item.iSUNITPRICE);
          saveList.add(save);
        }

        GlobalParam.deliveryHisProduct.addAll(saveList);
        GlobalParam.deliveryShowHisProduct = result;
        for (int i = 0; i < result.length; i++) {
          var data = {
            'proCode': result[i].cPRODCD,
            'proName': result[i].cPRODNM,
            'total': '0.0'
          };

          GlobalParam.totalProGoodList.add(data);
          GlobalParam.totalProBadList.add(data);
        }
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }

  getShowHisProduct(String cPRODCD, String cPRODNM) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getHisProduct(GetStoreDetailReq(
          cCUSTCD: GlobalParam.deliverySelectStore.cCUSTCD,
          cPRODCD: cPRODCD,
          cPRODNM: cPRODNM));

      GlobalParam.deliveryShowHisProduct.clear();
      if (result.isNotEmpty) {
        GlobalParam.deliveryShowHisProduct = result;
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }

  addReturnHD() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var checkReturn = 0;
      var sQty = 0.0;
      var mQty = 0.0;
      var lQty = 0.0;
      var sPrice = 0.0;
      var mPrice = 0.0;
      var lPrice = 0.0;
      var sTotal = 0.0;
      var mTotal = 0.0;
      var lTotal = 0.0;
      for (int i = 0; i < GlobalParam.deliveryHisProduct.length; i++) {
        if (GlobalParam.deliveryHisProduct[i].iINCOMPRO == null) {
          GlobalParam.deliveryHisProduct[i].iINCOMPRO = 0;
        }

        if (double.parse(GlobalParam.deliveryHisProduct[i].iSSIZEQTY) > 0) {
          sQty = double.parse(GlobalParam.deliveryHisProduct[i].iSSIZEQTY);
          sPrice = double.parse(GlobalParam.deliveryHisProduct[i].iSUNITPRICE);
          sTotal += sQty * sPrice;
        }

        if (double.parse(GlobalParam.deliveryHisProduct[i].iMSIZEQTY) > 0) {
          mQty = double.parse(GlobalParam.deliveryHisProduct[i].iMSIZEQTY);
          mPrice = double.parse(GlobalParam.deliveryHisProduct[i].iMUNITPRICE);
          mTotal += mQty * mPrice;
        }

        if (double.parse(GlobalParam.deliveryHisProduct[i].iLSIZEQTY) > 0) {
          lQty = double.parse(GlobalParam.deliveryHisProduct[i].iLSIZEQTY);
          lPrice = double.parse(GlobalParam.deliveryHisProduct[i].iLUNITPRICE);
          lTotal += lQty * lPrice;
        }
      }

      if ((sTotal + mTotal + lTotal) > 0) {
        AddReturnHDReq req = AddReturnHDReq(
            cBRANCD: GlobalParam.VEHICLE["cBRANCD"],
            cGRPCD: GlobalParam.deliveryRouteToday['cGRPCD'],
            cRTECD: GlobalParam.deliveryRouteToday['cRTECD'],
            cVEHICD: GlobalParam.VEHICLE['cVEHICD'],
            cDRIVER: GlobalParam.VEHICLE['cDRIVER'],
            cCUSTCD: GlobalParam.deliverySelectStore.cCUSTCD,
            cCUSTNM: GlobalParam.deliverySelectStore.cCUSTNM,
            cREMARK: '',
            iTOTAL: '${sTotal + mTotal + lTotal}',
            cREFDOC: GlobalParam.deliveryProductList[0].cPOCD,
            cRETYP: 'RG',
            cPAYST: 'N',
            cCREABY: GlobalParam.userID);
        // print(req);
        var result = await proxy.addReturnHD(req);

        if (result.success == false) {
          wrongDialog('${result.message}');
        } else {
          GlobalParam.deliveryReturnProRef = result.result;
          for (int i = 0; i < GlobalParam.deliveryHisProduct.length; i++) {
            if ((double.parse(GlobalParam.deliveryHisProduct[i].iSSIZEQTY) +
                    double.parse(GlobalParam.deliveryHisProduct[i].iMSIZEQTY) +
                    double.parse(GlobalParam.deliveryHisProduct[i].iLSIZEQTY)) >
                0) {
              AddReturnDTReq data = AddReturnDTReq(
                  cRETCD: result.result,
                  iSEQ: "${i + 1}",
                  cPRODCD: GlobalParam.deliveryHisProduct[i].cPRODCD,
                  cPRODNM: GlobalParam.deliveryHisProduct[i].cPRODNM,
                  cBRNDCD: GlobalParam.deliveryHisProduct[i].cBRNDCD,
                  cBRNDNM: GlobalParam.deliveryHisProduct[i].cBRNDNM,
                  iSSIZEQTY: GlobalParam.deliveryHisProduct[i].iSSIZEQTY,
                  iMSIZEQTY: GlobalParam.deliveryHisProduct[i].iMSIZEQTY,
                  iLSIZEQTY: GlobalParam.deliveryHisProduct[i].iLSIZEQTY,
                  cSUOMCD: GlobalParam.deliveryHisProduct[i].cSUOMCD,
                  cSUOMNM: GlobalParam.deliveryHisProduct[i].cSUOMNM,
                  cMUOMCD: GlobalParam.deliveryHisProduct[i].cMUOMCD,
                  cMUOMNM: GlobalParam.deliveryHisProduct[i].cMUOMNM,
                  cLUOMCD: GlobalParam.deliveryHisProduct[i].cLUOMCD,
                  cLUOMNM: GlobalParam.deliveryHisProduct[i].cLUOMNM,
                  iSUNITPRICE: GlobalParam.deliveryHisProduct[i].iSUNITPRICE,
                  iMUNITPRICE: GlobalParam.deliveryHisProduct[i].iMUNITPRICE,
                  iLUNITPRICE: GlobalParam.deliveryHisProduct[i].iLUNITPRICE,
                  cCREABY: GlobalParam.userID);
              // print(
              //     '--------------------${GlobalParam.deliveryHisProduct[i].cPRODNM} ${GlobalParam.deliveryHisProduct[i].iSSIZEQTY}');
              addReturnDT(data);
            }
          }
        }
      } else {
        GlobalParam.deliveryRegetPODT = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                DeliveryStoreGetBadProduct(GlobalParam.typeMenuCode, ''),
          ),
        );
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }

  addReturnDT(AddReturnDTReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.addReturnDT(req);

      if (result.success == false) {
        wrongDialog('${result.message}');
      } else {
        addStockCard();
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }

  addStockCard() async {
    // print(
    //     '**********${GlobalParam.deliveryPodtList.length} : ${GlobalParam.deliveryHisProduct.length}************');
    try {
      List<StockCardReq> stockCardReqList = [];

      for (int i = 0; i < GlobalParam.deliveryHisProduct.length; i++) {
        if (GlobalParam.deliveryHisProduct[i].iINCOMPRO != 0) {
          String cUOMCD = '';
          if (double.parse(GlobalParam.deliveryHisProduct[i].iSSIZEQTY) != 0) {
            cUOMCD = GlobalParam.deliveryHisProduct[i].cSUOMCD;
          }
          if (double.parse(GlobalParam.deliveryHisProduct[i].iMSIZEQTY) != 0) {
            cUOMCD = GlobalParam.deliveryHisProduct[i].cMUOMCD;
          }
          if (double.parse(GlobalParam.deliveryHisProduct[i].iLSIZEQTY) != 0) {
            cUOMCD = GlobalParam.deliveryHisProduct[i].cLUOMCD;
          }
          StockCardReq reGood = StockCardReq(
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cPRODCD: GlobalParam.deliveryHisProduct[i].cPRODCD,
              cUOMCD: cUOMCD,
              cWH: 'TRG',
              cREFDOC: GlobalParam.deliveryProductList[0].cPOCD,
              iRECEIVEQTY: '${GlobalParam.deliveryHisProduct[i].iINCOMPRO}',
              iISSUEQTY: '0',
              cREMARK: '',
              cLOTNO: '',
              cCREABY: GlobalParam.userID);

          stockCardReqList.add(reGood);
        }
      }

      AllApiProxyMobile proxy = AllApiProxyMobile();

      for (int i = 0; i < stockCardReqList.length; i++) {
        // print('********** $i ************');
        // print(stockCardReqList[i].cBRANCD);
        // print(stockCardReqList[i].cPRODCD);
        // print(stockCardReqList[i].cUOMCD);
        // print(stockCardReqList[i].cWH);
        // print(stockCardReqList[i].cREFDOC);
        // print(stockCardReqList[i].iRECEIVEQTY);
        // print(stockCardReqList[i].iISSUEQTY);
        // print(stockCardReqList[i].cREMARK);
        // print(stockCardReqList[i].cLOTNO);
        var result = await proxy.addStockCard(stockCardReqList[i]);
        if (result.success == false) {
          wrongDialog('${result.message}');
        }
      }
      GlobalParam.deliveryRegetPODT = false;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              DeliveryStoreGetBadProduct(GlobalParam.typeMenuCode, ''),
        ),
      );
      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  wrongDialog(String msg) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('Information'),
        content: Text(
          msg,
          style: const TextStyle(fontSize: 11.0),
        ),
        actions: <Widget>[
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.8,
          ),
          Container(
            height: 50.0,

            //color: Colors.amber,

            alignment: Alignment.centerRight,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listOfProduct() {
    return GlobalParam.deliveryShowHisProduct.length != 0
        ? ListView.builder(
            itemCount: GlobalParam.deliveryShowHisProduct.length,
            itemBuilder: (BuildContext context, int index) {
              sController.add(new TextEditingController());
              mController.add(new TextEditingController());
              lController.add(new TextEditingController());
              double unitPrice = 0.0;
              var unitCode = '';

              if (double.parse(
                      GlobalParam.deliveryShowHisProduct[index].iSSIZEQTY) !=
                  0) {
                unitPrice = double.parse(
                    GlobalParam.deliveryShowHisProduct[index].iSUNITPRICE);
                unitCode = GlobalParam.deliveryShowHisProduct[index].cSUOMCD;
              }
              if (double.parse(
                      GlobalParam.deliveryShowHisProduct[index].iMSIZEQTY) !=
                  0) {
                unitPrice = double.parse(
                    GlobalParam.deliveryShowHisProduct[index].iMUNITPRICE);
                unitCode = GlobalParam.deliveryShowHisProduct[index].cMUOMCD;
              }
              if (double.parse(
                      GlobalParam.deliveryShowHisProduct[index].iLSIZEQTY) !=
                  0) {
                unitPrice = double.parse(
                    GlobalParam.deliveryShowHisProduct[index].iLUNITPRICE);
                unitCode = GlobalParam.deliveryShowHisProduct[index].cLUOMCD;
              }

              for (var item in GlobalParam.deliveryCustPOHisBtnCheck) {
                if (item["cPRODCD"] ==
                    GlobalParam.deliveryShowHisProduct[index].cPRODCD) {
                  if (item["CPROGD"] == true) {
                    if (item["cUOMCD"] ==
                        GlobalParam.deliveryShowHisProduct[index].cSUOMCD) {
                      sController[index].text = '${item['iQTY']}';
                      for (int i = 0;
                          i < GlobalParam.deliveryHisProduct.length;
                          i++) {
                        // ignore: unrelated_type_equality_checks
                        if (GlobalParam.deliveryHisProduct[i].cPRODCD ==
                            item["cPRODCD"]) {
                          GlobalParam.deliveryHisProduct[index].iSSIZEQTY =
                              '${item['iQTY']}';
                        }
                      }
                    }

                    if (item["cUOMCD"] ==
                        GlobalParam.deliveryShowHisProduct[index].cMUOMCD) {
                      mController[index].text = '${item['iQTY']}';
                      for (int i = 0;
                          i < GlobalParam.deliveryHisProduct.length;
                          i++) {
                        // ignore: unrelated_type_equality_checks
                        if (GlobalParam.deliveryHisProduct[i].cPRODCD ==
                            item["cPRODCD"]) {
                          GlobalParam.deliveryHisProduct[index].iMSIZEQTY =
                              '${item['iQTY']}';
                        }
                      }
                    }
                    if (item["cUOMCD"] ==
                        GlobalParam.deliveryShowHisProduct[index].cLUOMCD) {
                      lController[index].text = '${item['iQTY']}';
                      for (int i = 0;
                          i < GlobalParam.deliveryHisProduct.length;
                          i++) {
                        // ignore: unrelated_type_equality_checks
                        if (GlobalParam.deliveryHisProduct[i].cPRODCD ==
                            item["cPRODCD"]) {
                          GlobalParam.deliveryHisProduct[index].iLSIZEQTY =
                              '${item['iQTY']}';
                        }
                      }
                    }
                  }
                }
              }

              return Container(
                color: HexColor("#F2F3F4"),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 128.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                image: GlobalParam.deliveryShowHisProduct[index]
                                            .cPHOTOPATH !=
                                        ''
                                    ? DecorationImage(
                                        image: new NetworkImage(
                                          'http://${GlobalParam.deliveryShowHisProduct[index].cPHOTOSERV}/${GlobalParam.deliveryShowHisProduct[index].cPHOTOPATH}',
                                        ),
                                        scale: 1.0,
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: new AssetImage(
                                          "assets/images/no_image.png",
                                        ),
                                        scale: 1.0,
                                        fit: BoxFit.cover,
                                      ),
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                border: Border.all(color: Colors.grey)),
                          ),
                          //----------------------1
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: widthScreen * 0.8,
                                    height: 24,
                                    child: Text(
                                      GlobalParam.deliveryShowHisProduct[index]
                                          .cPRODNM,
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  //--------------------2
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 36,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        double.parse(GlobalParam
                                                    .deliveryShowHisProduct[
                                                        index]
                                                    .iLSIZEQTY) !=
                                                0
                                            ? Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Center(
                                                    child: Text(
                                                      GlobalParam
                                                          .deliveryShowHisProduct[
                                                              index]
                                                          .cLUOMNM,
                                                      style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),

                                        double.parse(GlobalParam
                                                    .deliveryShowHisProduct[
                                                        index]
                                                    .iMSIZEQTY) !=
                                                0
                                            ? Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Center(
                                                    child: Text(
                                                      GlobalParam
                                                          .deliveryShowHisProduct[
                                                              index]
                                                          .cMUOMNM,
                                                      style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        // ignore: unrelated_type_equality_checks
                                        double.parse(GlobalParam
                                                    .deliveryShowHisProduct[
                                                        index]
                                                    .iSSIZEQTY) !=
                                                0
                                            ? Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Center(
                                                    child: Text(
                                                      GlobalParam
                                                          .deliveryShowHisProduct[
                                                              index]
                                                          .cSUOMNM,
                                                      style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  //----------------------------3
                                  Container(
                                    height: 36,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // ignore: unrelated_type_equality_checks
                                        double.parse(GlobalParam
                                                    .deliveryShowHisProduct[
                                                        index]
                                                    .iLSIZEQTY) !=
                                                0
                                            ? Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5.0, right: 5.0),
                                                  height: 30.0,
                                                  width: 80.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5),
                                                      topRight:
                                                          Radius.circular(5),
                                                      bottomLeft:
                                                          Radius.circular(5),
                                                      bottomRight:
                                                          Radius.circular(5),
                                                    ),
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 8, 0, 0),
                                                    child: TextField(
                                                      controller:
                                                          lController[index],
                                                      onChanged: (value) {
                                                        int iINCOMPRO = 0;
                                                        setState(() {
                                                          if (value == '' ||
                                                              value == null) {
                                                            for (int j = 0;
                                                                j <
                                                                    GlobalParam
                                                                        .deliveryUnitList
                                                                        .length;
                                                                j++) {
                                                              if (GlobalParam
                                                                          .deliveryUnitList[j]
                                                                      [
                                                                      "cPRODCD"] ==
                                                                  GlobalParam
                                                                      .deliveryShowHisProduct[
                                                                          index]
                                                                      .cPRODCD) {
                                                                if (GlobalParam
                                                                            .deliveryUnitList[j]
                                                                        [
                                                                        "cUOMCD"] ==
                                                                    GlobalParam
                                                                        .deliveryShowHisProduct[
                                                                            index]
                                                                        .cLUOMCD) {
                                                                  GlobalParam
                                                                      .deliveryUnitList
                                                                      .removeAt(
                                                                          j);
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            iINCOMPRO =
                                                                int.parse(
                                                                    value);
                                                            var data = {
                                                              "cPRODCD": GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cPRODCD,
                                                              "cUOMCD": GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cLUOMCD,
                                                              "cUOMNM": GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cLUOMNM,
                                                              "iPRICE": double
                                                                  .parse(GlobalParam
                                                                      .deliveryShowHisProduct[
                                                                          index]
                                                                      .iLUNITPRICE),
                                                              "iTOTAL":
                                                                  double.parse(
                                                                      '$iINCOMPRO')
                                                            };
                                                            GlobalParam
                                                                .deliveryUnitList
                                                                .add(data);
                                                          }
                                                        });

                                                        for (int i = 0;
                                                            i <
                                                                GlobalParam
                                                                    .deliveryShowHisProduct
                                                                    .length;
                                                            i++) {
                                                          // ignore: unrelated_type_equality_checks
                                                          if (GlobalParam
                                                                  .deliveryHisProduct[
                                                                      i]
                                                                  .cPRODCD ==
                                                              GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cPRODCD) {
                                                            GlobalParam
                                                                    .deliveryHisProduct[
                                                                        index]
                                                                    .iLSIZEQTY =
                                                                '$iINCOMPRO';
                                                          }
                                                        }

                                                        for (int i = 0;
                                                            i <
                                                                GlobalParam
                                                                    .deliveryPodtList
                                                                    .length;
                                                            i++) {
                                                          if (GlobalParam
                                                                  .deliveryPodtList[
                                                                      i]
                                                                  .cPRODCD ==
                                                              GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cPRODCD) {
                                                            if (GlobalParam
                                                                    .deliveryPodtList[
                                                                        i]
                                                                    .cLUOMCD ==
                                                                GlobalParam
                                                                    .deliveryShowHisProduct[
                                                                        index]
                                                                    .cLUOMCD)
                                                              GlobalParam
                                                                      .deliveryPodtList[
                                                                          index]
                                                                      .iINCOMPRO =
                                                                  iINCOMPRO;
                                                          }
                                                        }

                                                        for (int i = 0;
                                                            i <
                                                                GlobalParam
                                                                    .totalProGoodList
                                                                    .length;
                                                            i++) {
                                                          if (GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cPRODCD ==
                                                              GlobalParam
                                                                      .totalProGoodList[i]
                                                                  ['proCode']) {
                                                            GlobalParam.totalProGoodList[
                                                                        i]
                                                                    ['total'] =
                                                                '${iINCOMPRO * unitPrice}';
                                                          }
                                                        }
                                                        addReturnGood(
                                                            GlobalParam
                                                                    .deliveryPodtList[
                                                                index],
                                                            iINCOMPRO,
                                                            "L");
                                                      },
                                                      enabled: GlobalParam
                                                                  .subMenuCode !=
                                                              "003"
                                                          ? true
                                                          : false,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            HexColor('#00cb39'),
                                                        fontFamily: 'Prompt',
                                                      ),
                                                      cursorColor: Colors.black,
                                                      decoration:
                                                          new InputDecoration(
                                                        //hintText: "1",
                                                        hintStyle: TextStyle(
                                                            color: HexColor(
                                                                '#00cb39')),
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        // contentPadding:
                                                        //     EdgeInsets.only(
                                                        //         left: 15,
                                                        //         bottom: 10,
                                                        //         top: 0,
                                                        //         right: 15),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        // ignore: unrelated_type_equality_checks
                                        double.parse(GlobalParam
                                                    .deliveryShowHisProduct[
                                                        index]
                                                    .iMSIZEQTY) !=
                                                0
                                            ? Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5.0, right: 5.0),
                                                  height: 30.0,
                                                  width: 80.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5),
                                                      topRight:
                                                          Radius.circular(5),
                                                      bottomLeft:
                                                          Radius.circular(5),
                                                      bottomRight:
                                                          Radius.circular(5),
                                                    ),
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 8, 0, 0),
                                                    child: TextField(
                                                      controller:
                                                          mController[index],
                                                      onChanged: (value) {
                                                        int iINCOMPRO = 0;
                                                        setState(() {
                                                          if (value == '' ||
                                                              value == null) {
                                                            for (int j = 0;
                                                                j <
                                                                    GlobalParam
                                                                        .deliveryUnitList
                                                                        .length;
                                                                j++) {
                                                              if (GlobalParam
                                                                          .deliveryUnitList[j]
                                                                      [
                                                                      "cPRODCD"] ==
                                                                  GlobalParam
                                                                      .deliveryShowHisProduct[
                                                                          index]
                                                                      .cPRODCD) {
                                                                if (GlobalParam
                                                                            .deliveryUnitList[j]
                                                                        [
                                                                        "cUOMCD"] ==
                                                                    GlobalParam
                                                                        .deliveryShowHisProduct[
                                                                            index]
                                                                        .cMUOMCD) {
                                                                  GlobalParam
                                                                      .deliveryUnitList
                                                                      .removeAt(
                                                                          j);
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            iINCOMPRO =
                                                                int.parse(
                                                                    value);
                                                            var data = {
                                                              "cPRODCD": GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cPRODCD,
                                                              "cUOMCD": GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cMUOMCD,
                                                              "cUOMNM": GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cMUOMNM,
                                                              "iPRICE": double
                                                                  .parse(GlobalParam
                                                                      .deliveryShowHisProduct[
                                                                          index]
                                                                      .iMUNITPRICE),
                                                              "iTOTAL":
                                                                  double.parse(
                                                                      '$iINCOMPRO')
                                                            };
                                                            GlobalParam
                                                                .deliveryUnitList
                                                                .add(data);
                                                          }
                                                        });

                                                        for (int i = 0;
                                                            i <
                                                                GlobalParam
                                                                    .deliveryShowHisProduct
                                                                    .length;
                                                            i++) {
                                                          // ignore: unrelated_type_equality_checks
                                                          if (GlobalParam
                                                                  .deliveryHisProduct[
                                                                      i]
                                                                  .cPRODCD ==
                                                              GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cPRODCD) {
                                                            GlobalParam
                                                                    .deliveryHisProduct[
                                                                        index]
                                                                    .iMSIZEQTY =
                                                                '$iINCOMPRO';
                                                          }
                                                        }

                                                        for (int i = 0;
                                                            i <
                                                                GlobalParam
                                                                    .totalProGoodList
                                                                    .length;
                                                            i++) {
                                                          if (GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cPRODCD ==
                                                              GlobalParam
                                                                      .totalProGoodList[i]
                                                                  ['proCode']) {
                                                            GlobalParam.totalProGoodList[
                                                                        i]
                                                                    ['total'] =
                                                                '${iINCOMPRO * unitPrice}';
                                                          }
                                                        }

                                                        for (int i = 0;
                                                            i <
                                                                GlobalParam
                                                                    .deliveryPodtList
                                                                    .length;
                                                            i++) {
                                                          if (GlobalParam
                                                                  .deliveryPodtList[
                                                                      i]
                                                                  .cPRODCD ==
                                                              GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cPRODCD) {
                                                            if (GlobalParam
                                                                    .deliveryPodtList[
                                                                        i]
                                                                    .cMUOMCD ==
                                                                GlobalParam
                                                                    .deliveryShowHisProduct[
                                                                        index]
                                                                    .cMUOMCD)
                                                              GlobalParam
                                                                      .deliveryPodtList[
                                                                          index]
                                                                      .iINCOMPRO =
                                                                  iINCOMPRO;
                                                          }
                                                        }

                                                        addReturnGood(
                                                            GlobalParam
                                                                    .deliveryPodtList[
                                                                index],
                                                            iINCOMPRO,
                                                            "M");
                                                      },
                                                      enabled: GlobalParam
                                                                  .subMenuCode !=
                                                              "003"
                                                          ? true
                                                          : false,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            HexColor('#00cb39'),
                                                        fontFamily: 'Prompt',
                                                      ),
                                                      cursorColor: Colors.black,
                                                      decoration:
                                                          new InputDecoration(
                                                        //hintText: "1",
                                                        hintStyle: TextStyle(
                                                            color: HexColor(
                                                                '#00cb39')),
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        // contentPadding:
                                                        //     EdgeInsets.only(
                                                        //         left: 15,
                                                        //         bottom: 10,
                                                        //         top: 0,
                                                        //         right: 15),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        // ignore: unrelated_type_equality_checks
                                        double.parse(GlobalParam
                                                    .deliveryShowHisProduct[
                                                        index]
                                                    .iSSIZEQTY) !=
                                                0
                                            ? Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5.0, right: 5.0),
                                                  height: 30.0,
                                                  width: 80.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5),
                                                      topRight:
                                                          Radius.circular(5),
                                                      bottomLeft:
                                                          Radius.circular(5),
                                                      bottomRight:
                                                          Radius.circular(5),
                                                    ),
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 8, 0, 0),
                                                      child: TextField(
                                                        controller:
                                                            sController[index],
                                                        onChanged: (value) {
                                                          int iINCOMPRO = 0;
                                                          setState(() {
                                                            if (value == '' ||
                                                                value == null) {
                                                              for (int j = 0;
                                                                  j <
                                                                      GlobalParam
                                                                          .deliveryUnitList
                                                                          .length;
                                                                  j++) {
                                                                if (GlobalParam
                                                                            .deliveryUnitList[j]
                                                                        [
                                                                        "cPRODCD"] ==
                                                                    GlobalParam
                                                                        .deliveryShowHisProduct[
                                                                            index]
                                                                        .cPRODCD) {
                                                                  if (GlobalParam
                                                                              .deliveryUnitList[j]
                                                                          [
                                                                          "cUOMCD"] ==
                                                                      GlobalParam
                                                                          .deliveryShowHisProduct[
                                                                              index]
                                                                          .cSUOMCD) {
                                                                    GlobalParam
                                                                        .deliveryUnitList
                                                                        .removeAt(
                                                                            j);
                                                                  }
                                                                }
                                                              }
                                                            } else {
                                                              iINCOMPRO =
                                                                  int.parse(
                                                                      value);
                                                              var data = {
                                                                "cPRODCD": GlobalParam
                                                                    .deliveryShowHisProduct[
                                                                        index]
                                                                    .cPRODCD,
                                                                "cUOMCD": GlobalParam
                                                                    .deliveryShowHisProduct[
                                                                        index]
                                                                    .cSUOMCD,
                                                                "cUOMNM": GlobalParam
                                                                    .deliveryShowHisProduct[
                                                                        index]
                                                                    .cSUOMNM,
                                                                "iPRICE": double
                                                                    .parse(GlobalParam
                                                                        .deliveryShowHisProduct[
                                                                            index]
                                                                        .iSUNITPRICE),
                                                                "iTOTAL": double
                                                                    .parse(
                                                                        '$iINCOMPRO')
                                                              };
                                                              GlobalParam
                                                                  .deliveryUnitList
                                                                  .add(data);
                                                            }
                                                          });

                                                          for (int i = 0;
                                                              i <
                                                                  GlobalParam
                                                                      .deliveryShowHisProduct
                                                                      .length;
                                                              i++) {
                                                            // ignore: unrelated_type_equality_checks
                                                            if (GlobalParam
                                                                    .deliveryHisProduct[
                                                                        i]
                                                                    .cPRODCD ==
                                                                GlobalParam
                                                                    .deliveryShowHisProduct[
                                                                        index]
                                                                    .cPRODCD) {
                                                              GlobalParam
                                                                      .deliveryHisProduct[
                                                                          index]
                                                                      .iSSIZEQTY =
                                                                  '$iINCOMPRO';

                                                              // print(
                                                              //     "++++++++++++ ${iINCOMPRO}");
                                                            }
                                                          }

                                                          for (int i = 0;
                                                              i <
                                                                  GlobalParam
                                                                      .totalProGoodList
                                                                      .length;
                                                              i++) {
                                                            if (GlobalParam
                                                                    .deliveryShowHisProduct[
                                                                        index]
                                                                    .cPRODCD ==
                                                                GlobalParam
                                                                        .totalProGoodList[i]
                                                                    [
                                                                    'proCode']) {
                                                              GlobalParam.totalProGoodList[
                                                                          i][
                                                                      'total'] =
                                                                  '${iINCOMPRO * unitPrice}';
                                                            }
                                                          }

                                                          for (int i = 0;
                                                              i <
                                                                  GlobalParam
                                                                      .deliveryPodtList
                                                                      .length;
                                                              i++) {
                                                            if (GlobalParam
                                                                    .deliveryPodtList[
                                                                        i]
                                                                    .cPRODCD ==
                                                                GlobalParam
                                                                    .deliveryShowHisProduct[
                                                                        index]
                                                                    .cPRODCD) {
                                                              if (GlobalParam
                                                                      .deliveryPodtList[
                                                                          i]
                                                                      .cSUOMCD ==
                                                                  GlobalParam
                                                                      .deliveryShowHisProduct[
                                                                          index]
                                                                      .cSUOMCD)
                                                                GlobalParam
                                                                        .deliveryPodtList[
                                                                            index]
                                                                        .iINCOMPRO =
                                                                    iINCOMPRO;
                                                            }
                                                          }
                                                          addReturnGood(
                                                              GlobalParam
                                                                      .deliveryPodtList[
                                                                  index],
                                                              iINCOMPRO,
                                                              "S");
                                                        },
                                                        enabled: GlobalParam
                                                                    .subMenuCode !=
                                                                "003"
                                                            ? true
                                                            : false,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: HexColor(
                                                              '#00cb39'),
                                                          fontFamily: 'Prompt',
                                                        ),
                                                        cursorColor:
                                                            Colors.black,
                                                        decoration:
                                                            new InputDecoration(
                                                          //hintText: "1",
                                                          hintStyle: TextStyle(
                                                              color: HexColor(
                                                                  '#00cb39')),
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          errorBorder:
                                                              InputBorder.none,
                                                          disabledBorder:
                                                              InputBorder.none,
                                                          // contentPadding:
                                                          // EdgeInsets.only(
                                                          //     left: 15,
                                                          //     bottom: 10,โ
                                                          //     top: 0,
                                                          //     right: 15),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //     alignment: Alignment.centerRight,
                                  //     width: widthScreen * 0.68,
                                  //     child: SubstringPrice(
                                  //       '$unitPrice',
                                  //       14.0,
                                  //       12.0,
                                  //       Colors.black,
                                  //       Colors.black,
                                  //       'Prompt',
                                  //       'Prompt',
                                  //       FontWeight.bold,
                                  //       FontWeight.bold,
                                  //       '฿',
                                  //       12.0,
                                  //       Colors.black,
                                  //       'Prompt',
                                  //       FontWeight.bold,
                                  //       FontStyle.normal,
                                  //       FontStyle.normal,
                                  //       FontStyle.normal,
                                  //     )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                      child: Container(
                        height: 24,
                        child: Row(
                          children: [
                            Spacer(),
                            Text(
                              'ต่อหน่วย ${formatNum.format(unitPrice)} ฿ รวม ${formatNum.format(double.parse(GlobalParam.totalProGoodList[index]['total']))} ฿',
                              style:
                                  TextStyle(fontFamily: 'Prompt', fontSize: 14),
                            ),
                            // Container(
                            //     alignment: Alignment.centerRight,
                            //     width: widthScreen * 0.68,
                            //     child: SubstringPrice(
                            //       '$unitPrice',
                            //       14.0,
                            //       12.0,
                            //       Colors.black,
                            //       Colors.black,
                            //       'Prompt',
                            //       'Prompt',
                            //       FontWeight.bold,
                            //       FontWeight.bold,
                            //       '฿',
                            //       12.0,
                            //       Colors.black,
                            //       'Prompt',
                            //       FontWeight.bold,
                            //       FontStyle.normal,
                            //       FontStyle.normal,
                            //       FontStyle.normal,
                            //     )),
                          ],
                        ),
                      ),
                    ),
                    DottedLine(
                      dashColor: Colors.grey,
                    ),
                  ],
                ),
              );
            })
        : Container();
  }

  addReturnGood(QueryPodtResp data, int miss, String size) {
    var iSSIZEQTY = '0.0';
    var iMSIZEQTY = '0.0';
    var iLSIZEQTY = '0.0';

    if (miss > 0) {
      if (size == "S") {
        QueryPodtResp incom = new QueryPodtResp(
            cGUID: data.cGUID,
            cPOCD: data.cPOCD,
            iSEQ: data.iSEQ,
            cPRODCD: data.cPRODCD,
            cPRODNM: data.cPRODNM,
            cTYPE: data.cTYPE,
            cTYPENM: data.cTYPENM,
            cCATECD: data.cCATECD,
            cCATENM: data.cCATENM,
            cSUBCATECD: data.cSUBCATECD,
            cSUBCATENM: data.cSUBCATENM,
            cBRNDCD: data.cBRNDCD,
            cBRNDNM: data.cBRNDNM,
            iSSIZEQTY: '$miss',
            iMSIZEQTY: iMSIZEQTY,
            iLSIZEQTY: iLSIZEQTY,
            cSUOMNM: data.cSUOMNM,
            cMUOMNM: data.cMUOMNM,
            cLUOMNM: data.cLUOMNM,
            cPROMO: data.cPROMO,
            iDISCOUNT: data.iDISCOUNT,
            cDISCOUNT: data.cDISCOUNT,
            iFREE: data.iFREE,
            iTOTAL: data.iTOTAL,
            cBASKCD: data.cBASKCD,
            cBASKNM: data.cBASKNM,
            cSTATUS: data.cSTATUS,
            dCREADT: data.dCREADT,
            cCREABY: data.cCREABY,
            dUPDADT: data.dUPDADT,
            cUPDABY: data.cUPDABY,
            cINSERTYPE: data.cINSERTYPE,
            iSUNITPRICE: data.iSUNITPRICE,
            iMUNITPRICE: data.iMUNITPRICE,
            iLUNITPRICE: data.iLUNITPRICE,
            cPREPAIRSTATUS: data.cPREPAIRSTATUS,
            iPREPAIRAMOUT: data.iPREPAIRAMOUT,
            cPHOTOSERV: data.cPHOTOSERV,
            cPHOTOPATH: data.cPHOTOPATH,
            iNETTOTAL: data.iNETTOTAL,
            iINCOMPRO: data.iINCOMPRO,
            iCANCLEPRO: miss,
            iLOSSPRO: data.iLOSSPRO,
            cSUOMCD: data.cSUOMCD,
            cMUOMCD: data.cMUOMCD,
            cLUOMCD: data.cLUOMCD);
        GlobalParam.deliveryReturnGoodPro.add(incom);
      }

      if (size == "M") {
        QueryPodtResp incom = new QueryPodtResp(
            cGUID: data.cGUID,
            cPOCD: data.cPOCD,
            iSEQ: data.iSEQ,
            cPRODCD: data.cPRODCD,
            cPRODNM: data.cPRODNM,
            cTYPE: data.cTYPE,
            cTYPENM: data.cTYPENM,
            cCATECD: data.cCATECD,
            cCATENM: data.cCATENM,
            cSUBCATECD: data.cSUBCATECD,
            cSUBCATENM: data.cSUBCATENM,
            cBRNDCD: data.cBRNDCD,
            cBRNDNM: data.cBRNDNM,
            iSSIZEQTY: iSSIZEQTY,
            iMSIZEQTY: '$miss',
            iLSIZEQTY: iLSIZEQTY,
            cSUOMNM: data.cSUOMNM,
            cMUOMNM: data.cMUOMNM,
            cLUOMNM: data.cLUOMNM,
            cPROMO: data.cPROMO,
            iDISCOUNT: data.iDISCOUNT,
            cDISCOUNT: data.cDISCOUNT,
            iFREE: data.iFREE,
            iTOTAL: data.iTOTAL,
            cBASKCD: data.cBASKCD,
            cBASKNM: data.cBASKNM,
            cSTATUS: data.cSTATUS,
            dCREADT: data.dCREADT,
            cCREABY: data.cCREABY,
            dUPDADT: data.dUPDADT,
            cUPDABY: data.cUPDABY,
            cINSERTYPE: data.cINSERTYPE,
            iSUNITPRICE: data.iSUNITPRICE,
            iMUNITPRICE: data.iMUNITPRICE,
            iLUNITPRICE: data.iLUNITPRICE,
            cPREPAIRSTATUS: data.cPREPAIRSTATUS,
            iPREPAIRAMOUT: data.iPREPAIRAMOUT,
            cPHOTOSERV: data.cPHOTOSERV,
            cPHOTOPATH: data.cPHOTOPATH,
            iNETTOTAL: data.iNETTOTAL,
            iINCOMPRO: data.iINCOMPRO,
            iCANCLEPRO: miss,
            iLOSSPRO: data.iLOSSPRO,
            cSUOMCD: data.cSUOMCD,
            cMUOMCD: data.cMUOMCD,
            cLUOMCD: data.cLUOMCD);
        GlobalParam.deliveryReturnGoodPro.add(incom);
      }
      if (size == "L") {
        QueryPodtResp incom = new QueryPodtResp(
            cGUID: data.cGUID,
            cPOCD: data.cPOCD,
            iSEQ: data.iSEQ,
            cPRODCD: data.cPRODCD,
            cPRODNM: data.cPRODNM,
            cTYPE: data.cTYPE,
            cTYPENM: data.cTYPENM,
            cCATECD: data.cCATECD,
            cCATENM: data.cCATENM,
            cSUBCATECD: data.cSUBCATECD,
            cSUBCATENM: data.cSUBCATENM,
            cBRNDCD: data.cBRNDCD,
            cBRNDNM: data.cBRNDNM,
            iSSIZEQTY: iSSIZEQTY,
            iMSIZEQTY: iMSIZEQTY,
            iLSIZEQTY: '$miss',
            cSUOMNM: data.cSUOMNM,
            cMUOMNM: data.cMUOMNM,
            cLUOMNM: data.cLUOMNM,
            cPROMO: data.cPROMO,
            iDISCOUNT: data.iDISCOUNT,
            cDISCOUNT: data.cDISCOUNT,
            iFREE: data.iFREE,
            iTOTAL: data.iTOTAL,
            cBASKCD: data.cBASKCD,
            cBASKNM: data.cBASKNM,
            cSTATUS: data.cSTATUS,
            dCREADT: data.dCREADT,
            cCREABY: data.cCREABY,
            dUPDADT: data.dUPDADT,
            cUPDABY: data.cUPDABY,
            cINSERTYPE: data.cINSERTYPE,
            iSUNITPRICE: data.iSUNITPRICE,
            iMUNITPRICE: data.iMUNITPRICE,
            iLUNITPRICE: data.iLUNITPRICE,
            cPREPAIRSTATUS: data.cPREPAIRSTATUS,
            iPREPAIRAMOUT: data.iPREPAIRAMOUT,
            cPHOTOSERV: data.cPHOTOSERV,
            cPHOTOPATH: data.cPHOTOPATH,
            iNETTOTAL: data.iNETTOTAL,
            iINCOMPRO: data.iINCOMPRO,
            iCANCLEPRO: miss,
            iLOSSPRO: data.iLOSSPRO,
            cSUOMCD: data.cSUOMCD,
            cMUOMCD: data.cMUOMCD,
            cLUOMCD: data.cLUOMCD);
        GlobalParam.deliveryReturnGoodPro.add(incom);
      }
    } else {
      for (int i = 0; i < GlobalParam.deliveryReturnGoodPro.length; i++) {
        // ignore: unrelated_type_equality_checks
        if (GlobalParam.deliveryReturnGoodPro[i].cPRODCD == data.cPRODCD) {
          if (size == "S") {
            if (double.parse(GlobalParam.deliveryReturnGoodPro[i].iSSIZEQTY) >
                0) {
              GlobalParam.deliveryReturnGoodPro.removeAt(i);
            }
          }

          if (size == "M") {
            if (double.parse(GlobalParam.deliveryReturnGoodPro[i].iMSIZEQTY) >
                0) {
              GlobalParam.deliveryReturnGoodPro.removeAt(i);
            }
          }
          if (size == "L") {
            if (double.parse(GlobalParam.deliveryReturnGoodPro[i].iLSIZEQTY) >
                0) {
              GlobalParam.deliveryReturnGoodPro.removeAt(i);
            }
          }
        }
      }
    }

    for (int i = 0; i < GlobalParam.deliveryHisProduct.length; i++) {
      if (data.cPRODCD == GlobalParam.deliveryHisProduct[i].cPRODCD) {
        if (size == 'S') {
          GlobalParam.deliveryHisProduct[i].iSSIZEQTY = '$miss';
        } else if (size == 'M') {
          GlobalParam.deliveryHisProduct[i].iMSIZEQTY = '$miss';
        } else if (size == 'L') {
          GlobalParam.deliveryHisProduct[i].iLSIZEQTY = '$miss';
        }
      }
    }
  }
}
