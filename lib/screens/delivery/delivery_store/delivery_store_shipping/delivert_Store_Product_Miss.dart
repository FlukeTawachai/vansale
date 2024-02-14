import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';

import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addRTPROReq.dart';
import 'package:vansale/api/class/request/mobile/addStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/getCustHisWithDateReq.dart';
import 'package:vansale/api/class/request/mobile/queryPodtReq.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';

import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/delivery/delivery_scanner.dart';

import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_GetBad_Product.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_GetGood_Product.dart';

import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_Miss_List.dart';
import 'package:vansale/screens/delivery/delivery_store_footer.dart';
import 'package:vansale/screens/shipping/return_product.dart';

class DeliveryStoreProductMiss extends StatefulWidget {
  final String typeMenuCode;

  DeliveryStoreProductMiss(this.typeMenuCode);

  @override
  State<DeliveryStoreProductMiss> createState() =>
      _DeliveryStoreProductMissState();
}

class _DeliveryStoreProductMissState extends State<DeliveryStoreProductMiss> {
  double productMiss = 0;
  String cCUSTCD = GlobalParam.deliveryProductList[0].cCUSTCD;
  String cPOCD = GlobalParam.deliveryProductList[0].cPOCD;
  List<QueryPodtResp> podtList = [];
  List<QueryPodtResp> podtListNstatus = [];
  List<PoHDAndPoDTResp> productList = [];
  var IncomPro = TextEditingController();
  double widthScreen = 0;
  var numberFormat = NumberFormat("###.0#", "en_US");
  List<TextEditingController> controller = [];
  List<AddRTPROReq> reqReturnList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GlobalParam.deliveryUnitList = [];
    if (GlobalParam.deliveryRegetPODT == true) {
      getPodt(cPOCD, '', '');
      GlobalParam.deliveryRegetPODT = false;
    }

    final moonLanding = DateTime.now();

    var newDate = moonLanding.subtract(Duration(days: 7));

    getCustHisWithDate(GetCustHisWithDateReq(
        cCUSTCD: GlobalParam.deliverySelectStore.cCUSTCD,
        dSHIPDATE: '$newDate'));

    GlobalParam.deliveryCustPOHisBtnCheck = [];
    for (var item in GlobalParam.deliveryPodtShow) {
      var unitCode = "";
      if (double.parse(item.iSSIZEQTY) > 0) {
        unitCode = item.cSUOMCD;
      }
      if (double.parse(item.iMSIZEQTY) > 0) {
        unitCode = item.cMUOMCD;
      }
      if (double.parse(item.iLSIZEQTY) > 0) {
        unitCode = item.cLUOMCD;
      }
      var data = {
        "cPRODCD": item.cPRODCD,
        "cUOMCD": unitCode,
        "CPROGD": false,
        "CPROBD": false,
        "iQTY": 0
      };
      GlobalParam.deliveryCustPOHisBtnCheck.add(data);
    }
    GlobalParam.deliveryPodCancel = [];
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('สินค้าคืน/เหลือ'),
          centerTitle: true,
        ),
        body: Stack(children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: listOfProduct()),
          Container(
            alignment: Alignment.centerLeft,
            color: HexColor('#6c7e9b'),
            height: 60.0,
            child: Container(
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
                          GlobalParam.deliveryRegetPODT = false;
                          if (value != '' && value != null) {
                            getPodtShow(cPOCD, value, '');
                          } else {
                            // getPodt(cPOCD, '', '');
                            GlobalParam.deliveryProductShow =
                                GlobalParam.deliveryProductList;
                            GlobalParam.deliveryPodtShow =
                                GlobalParam.deliveryPodtList;
                          }
                        },
                        style: TextStyle(
                          fontFamily: 'Prompt',
                        ),
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: "ค้นหา",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 5.0, top: 5.0),
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DeliveryQrScanner(
                                    code: '003',
                                    navigator: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DeliveryStoreProductMiss(
                                                      GlobalParam
                                                          .typeMenuCode)));
                                    },
                                  )));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
        bottomNavigationBar: DeliveryFooter(
          title1: 'บันทึกสินค้าคืน/เหลือ',
          title2: '',
          item: double.parse('${GlobalParam.deliveryUnitList.length}'),
          navigated1: () {
            // for (int i = 0; i < GlobalParam.deliveryPodCancel.length; i++){
            //   print("++++++++++++++++++++++++++++++++++++++++++++++++");
            //   print('S ${GlobalParam.deliveryPodCancel[i].iSSIZEQTY}');
            //   print("M ${GlobalParam.deliveryPodCancel[i].iMSIZEQTY}");
            //   print('L ${GlobalParam.deliveryPodCancel[i].iLSIZEQTY}');
            //   print(GlobalParam.deliveryPodCancel[i].iCANCLEPRO);
            // }
            int index = 0, iINCOMPRO = 0;
            for (int i = 0; i < GlobalParam.deliveryPodCancel.length; i++) {
              if (GlobalParam.deliveryPodCancel[i].iCANCLEPRO == null) {
                GlobalParam.deliveryPodCancel[i].iCANCLEPRO = 0;
              }
              updateICLPro(
                  GlobalParam.deliveryPodCancel[i].cPOCD,
                  GlobalParam.deliveryPodCancel[i].iSEQ,
                  GlobalParam.deliveryPodCancel[i].iINCOMPRO,
                  GlobalParam.deliveryPodCancel[i].iCANCLEPRO,
                  GlobalParam.deliveryPodCancel[i].iLOSSPRO,
                  GlobalParam.deliveryPodCancel[i].cUPDABY);

              // if (GlobalParam.deliveryPodCancel[i].iCANCLEPRO != 0) {
              //   double price = 0.0;
              //   if (GlobalParam.deliveryPodCancel[i].iSSIZEQTY != 0.0) {
              //     price = double.parse(
              //         GlobalParam.deliveryPodCancel[i].iSUNITPRICE);
              //   } else if (GlobalParam.deliveryPodCancel[i].iMSIZEQTY != 0.0) {
              //     price = double.parse(
              //         GlobalParam.deliveryPodCancel[i].iMUNITPRICE);
              //   } else if (GlobalParam.deliveryPodCancel[i].iLSIZEQTY != 0.0) {
              //     price = double.parse(
              //         GlobalParam.deliveryPodCancel[i].iLUNITPRICE);
              //   }
              //   returnProduct(AddRTPROReq(
              //       cPOCD: GlobalParam.deliveryPodCancel[i].cPOCD,
              //       cCUSTCD: GlobalParam.deliverySelectStore.cCUSTCD,
              //       cPRODCD: GlobalParam.deliveryPodCancel[i].cPRODCD,
              //       iQTY: '${GlobalParam.deliveryPodCancel[i].iCANCLEPRO}',
              //       iTOTAL:
              //           '${GlobalParam.deliveryPodCancel[i].iCANCLEPRO * price}',
              //       cSTATUS: "N",
              //       cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              //       cCREABY: GlobalParam.userID));
              // }
            }

            for (int i = 0; i < reqReturnList.length; i++) {
              returnProduct(reqReturnList[i]);
            }
            addStockCard();

            GlobalParam.deliveryRegetPODT = true;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DeliveryStoreGetGoodProduct(GlobalParam.typeMenuCode, ''),
              ),
            );
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

  returnProduct(AddRTPROReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.addRTPRO(req);
      if (result.success == false) {
        wrongDialog('${result.message}');
      }
      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getPodt(String cPOCD, String cPRODNM, String cPRODCD) async {
    double sumItem = 0;
    if (cPOCD != '') {
      if (cPOCD != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result = await proxy.getPodt(QueryPodtReq(
              cPOCD: cPOCD,
              cPRODCD: '%$cPRODCD%',
              cPRODNM: '%$cPRODNM%',
              cCUSTTYPE: GlobalParam.customer['cCUSTTYPE']));
          if (result.isNotEmpty) {
            //  print('+++++++++++++++++++ query TBT_PODT success +++++++++++++++++++');
            podtList.clear();
            double total = 0;
            for (int i = 0; i < result.length; i++) {
              if (result[i].iNETTOTAL == null) {
                result[i].iNETTOTAL = '0.0';
              }
              sumItem += double.parse(result[i].iSSIZEQTY) +
                  double.parse(result[i].iMSIZEQTY) +
                  double.parse(result[i].iLSIZEQTY);
              total += double.parse(result[i].iTOTAL);
              if (double.parse(result[i].iSSIZEQTY) > 0) {
                var data = {
                  "cUOMNM": result[i].cSUOMNM,
                  "iPRICE": result[i].iSUNITPRICE,
                  "iTOTAL": result[i].iTOTAL
                };

                QueryPodtResp product = new QueryPodtResp(
                  cBASKCD: result[i].cBASKCD,
                  cBASKNM: result[i].cBASKNM,
                  cBRNDCD: result[i].cBRNDCD,
                  cBRNDNM: result[i].cBRNDNM,
                  cCATECD: result[i].cCATECD,
                  cCATENM: result[i].cCATENM,
                  cCREABY: result[i].cCREABY,
                  cDISCOUNT: result[i].cDISCOUNT,
                  cINSERTYPE: result[i].cINSERTYPE,
                  cLUOMCD: result[i].cLUOMCD,
                  cLUOMNM: result[i].cLUOMNM,
                  cMUOMCD: result[i].cMUOMCD,
                  cMUOMNM: result[i].cMUOMNM,
                  cPHOTOPATH: result[i].cPHOTOPATH,
                  cPHOTOSERV: result[i].cPHOTOSERV,
                  cPOCD: result[i].cPOCD,
                  cPREPAIRSTATUS: result[i].cPREPAIRSTATUS == null
                      ? 'N'
                      : result[i].cPREPAIRSTATUS,
                  cPRODCD: result[i].cPRODCD,
                  cPRODNM: result[i].cPRODNM,
                  cPROMO: result[i].cPROMO,
                  cSTATUS: result[i].cSTATUS,
                  cSUBCATECD: result[i].cSUBCATECD,
                  cSUBCATENM: result[i].cSUBCATENM,
                  cSUOMCD: result[i].cSUOMCD,
                  cSUOMNM: result[i].cSUOMNM,
                  cTYPE: result[i].cTYPE,
                  cTYPENM: result[i].cTYPENM,
                  cUPDABY: result[i].cUPDABY,
                  dCREADT: result[i].dCREADT,
                  dUPDADT: result[i].dUPDADT,
                  iCANCLEPRO:
                      result[i].iCANCLEPRO == null ? 0 : result[i].iCANCLEPRO,
                  iDISCOUNT: result[i].iDISCOUNT,
                  iFREE: result[i].iFREE,
                  iINCOMPRO:
                      result[i].iCANCLEPRO == null ? 0 : result[i].iCANCLEPRO,
                  iLOSSPRO:
                      result[i].iCANCLEPRO == null ? 0 : result[i].iCANCLEPRO,
                  iLSIZEQTY: '0.0',
                  iLUNITPRICE: result[i].iLUNITPRICE,
                  iMSIZEQTY: '0.0',
                  iMUNITPRICE: result[i].iMUNITPRICE,
                  iNETTOTAL:
                      result[i].iNETTOTAL == null ? '0' : result[i].iNETTOTAL,
                  iPREPAIRAMOUT: result[i].iPREPAIRAMOUT == null
                      ? '0'
                      : result[i].iPREPAIRAMOUT,
                  iSEQ: result[i].iSEQ,
                  iSSIZEQTY: result[i].iSSIZEQTY,
                  iSUNITPRICE: result[i].iSUNITPRICE,
                  iTOTAL:
                      "${double.parse(result[i].iSSIZEQTY) * double.parse(result[i].iSUNITPRICE)}",
                );

                podtList.add(product);
              }
              if (double.parse(result[i].iMSIZEQTY) > 0) {
                var data = {
                  "cUOMNM": result[i].cMUOMNM,
                  "iPRICE": result[i].iMUNITPRICE,
                  "iTOTAL": result[i].iTOTAL
                };

                QueryPodtResp product = new QueryPodtResp(
                  cBASKCD: result[i].cBASKCD,
                  cBASKNM: result[i].cBASKNM,
                  cBRNDCD: result[i].cBRNDCD,
                  cBRNDNM: result[i].cBRNDNM,
                  cCATECD: result[i].cCATECD,
                  cCATENM: result[i].cCATENM,
                  cCREABY: result[i].cCREABY,
                  cDISCOUNT: result[i].cDISCOUNT,
                  cINSERTYPE: result[i].cINSERTYPE,
                  cLUOMCD: result[i].cLUOMCD,
                  cLUOMNM: result[i].cLUOMNM,
                  cMUOMCD: result[i].cMUOMCD,
                  cMUOMNM: result[i].cMUOMNM,
                  cPHOTOPATH: result[i].cPHOTOPATH,
                  cPHOTOSERV: result[i].cPHOTOSERV,
                  cPOCD: result[i].cPOCD,
                  cPREPAIRSTATUS: result[i].cPREPAIRSTATUS == null
                      ? 'N'
                      : result[i].cPREPAIRSTATUS,
                  cPRODCD: result[i].cPRODCD,
                  cPRODNM: result[i].cPRODNM,
                  cPROMO: result[i].cPROMO,
                  cSTATUS: result[i].cSTATUS,
                  cSUBCATECD: result[i].cSUBCATECD,
                  cSUBCATENM: result[i].cSUBCATENM,
                  cSUOMCD: result[i].cSUOMCD,
                  cSUOMNM: result[i].cSUOMNM,
                  cTYPE: result[i].cTYPE,
                  cTYPENM: result[i].cTYPENM,
                  cUPDABY: result[i].cUPDABY,
                  dCREADT: result[i].dCREADT,
                  dUPDADT: result[i].dUPDADT,
                  iCANCLEPRO:
                      result[i].iCANCLEPRO == null ? 0 : result[i].iCANCLEPRO,
                  iDISCOUNT: result[i].iDISCOUNT,
                  iFREE: result[i].iFREE,
                  iINCOMPRO:
                      result[i].iCANCLEPRO == null ? 0 : result[i].iCANCLEPRO,
                  iLOSSPRO:
                      result[i].iCANCLEPRO == null ? 0 : result[i].iCANCLEPRO,
                  iLSIZEQTY: '0.0',
                  iLUNITPRICE: result[i].iLUNITPRICE,
                  iMSIZEQTY: result[i].iMSIZEQTY,
                  iMUNITPRICE: result[i].iMUNITPRICE,
                  iNETTOTAL:
                      result[i].iNETTOTAL == null ? '0' : result[i].iNETTOTAL,
                  iPREPAIRAMOUT: result[i].iPREPAIRAMOUT == null
                      ? '0'
                      : result[i].iPREPAIRAMOUT,
                  iSEQ: result[i].iSEQ,
                  iSSIZEQTY: '0.0',
                  iSUNITPRICE: result[i].iSUNITPRICE,
                  iTOTAL:
                      "${double.parse(result[i].iMSIZEQTY) * double.parse(result[i].iMUNITPRICE)}",
                );

                podtList.add(product);
              }
              if (double.parse(result[i].iLSIZEQTY) > 0) {
                var data = {
                  "cUOMNM": result[i].cLUOMNM,
                  "iPRICE": result[i].iLUNITPRICE,
                  "iTOTAL": result[i].iTOTAL
                };

                QueryPodtResp product = new QueryPodtResp(
                  cBASKCD: result[i].cBASKCD,
                  cBASKNM: result[i].cBASKNM,
                  cBRNDCD: result[i].cBRNDCD,
                  cBRNDNM: result[i].cBRNDNM,
                  cCATECD: result[i].cCATECD,
                  cCATENM: result[i].cCATENM,
                  cCREABY: result[i].cCREABY,
                  cDISCOUNT: result[i].cDISCOUNT,
                  cINSERTYPE: result[i].cINSERTYPE,
                  cLUOMCD: result[i].cLUOMCD,
                  cLUOMNM: result[i].cLUOMNM,
                  cMUOMCD: result[i].cMUOMCD,
                  cMUOMNM: result[i].cMUOMNM,
                  cPHOTOPATH: result[i].cPHOTOPATH,
                  cPHOTOSERV: result[i].cPHOTOSERV,
                  cPOCD: result[i].cPOCD,
                  cPREPAIRSTATUS: result[i].cPREPAIRSTATUS == null
                      ? 'N'
                      : result[i].cPREPAIRSTATUS,
                  cPRODCD: result[i].cPRODCD,
                  cPRODNM: result[i].cPRODNM,
                  cPROMO: result[i].cPROMO,
                  cSTATUS: result[i].cSTATUS,
                  cSUBCATECD: result[i].cSUBCATECD,
                  cSUBCATENM: result[i].cSUBCATENM,
                  cSUOMCD: result[i].cSUOMCD,
                  cSUOMNM: result[i].cSUOMNM,
                  cTYPE: result[i].cTYPE,
                  cTYPENM: result[i].cTYPENM,
                  cUPDABY: result[i].cUPDABY,
                  dCREADT: result[i].dCREADT,
                  dUPDADT: result[i].dUPDADT,
                  iCANCLEPRO:
                      result[i].iCANCLEPRO == null ? 0 : result[i].iCANCLEPRO,
                  iDISCOUNT: result[i].iDISCOUNT,
                  iFREE: result[i].iFREE,
                  iINCOMPRO:
                      result[i].iCANCLEPRO == null ? 0 : result[i].iCANCLEPRO,
                  iLOSSPRO:
                      result[i].iCANCLEPRO == null ? 0 : result[i].iCANCLEPRO,
                  iLSIZEQTY: result[i].iLSIZEQTY,
                  iLUNITPRICE: result[i].iLUNITPRICE,
                  iMSIZEQTY: '0.0',
                  iMUNITPRICE: result[i].iMUNITPRICE,
                  iNETTOTAL:
                      result[i].iNETTOTAL == null ? '0' : result[i].iNETTOTAL,
                  iPREPAIRAMOUT: result[i].iPREPAIRAMOUT == null
                      ? '0'
                      : result[i].iPREPAIRAMOUT,
                  iSEQ: result[i].iSEQ,
                  iSSIZEQTY: '0.0',
                  iSUNITPRICE: result[i].iSUNITPRICE,
                  iTOTAL:
                      "${double.parse(result[i].iLSIZEQTY) * double.parse(result[i].iLUNITPRICE)}",
                );

                podtList.add(product);
              }

              if (result[i].cPREPAIRSTATUS == 'N') {
                podtListNstatus.add(result[i]);
              }
            }
            if (GlobalParam.deliveryRegetPODT == true) {
              GlobalParam.deliveryPodtList = podtList;
            }
            GlobalParam.deliveryPodtShow = podtList;
            GlobalParam.deliveryStoreSum.iTOTAL = total.toString();
            getBasketsofCustomer(cCUSTCD, cPOCD, '%$cPRODNM%', '%$cPRODCD%');
          } else {
            // print('+++++++++++++++++++ query TBT_PODT fail +++++++++++++++++++');
            podtList.clear();
          }
        } on SocketException catch (e) {
          wrongDialog(e.message);
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
        setState(() {});
      }
    } else {
      wrongDialog("custcd is null.");
    }
  }

  addStockCard() async {
    // print(
    //     '**********${GlobalParam.deliveryPodtList.length} : ${GlobalParam.deliveryHisProduct.length}************');
    try {
      List<StockCardReq> stockCardReqList = [];
      for (int i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
        // if (stockCardReqList.length > 0) {
        //   print('**********************');
        //   print(stockCardReqList[i].cBRANCD);
        //   print(stockCardReqList[i].cPRODCD);
        //   print(stockCardReqList[i].cUOMCD);
        //   print(stockCardReqList[i].cWH);
        //   print(stockCardReqList[i].cREFDOC);
        //   print(stockCardReqList[i].iRECEIVEQTY);
        //   print(stockCardReqList[i].iISSUEQTY);
        //   print(stockCardReqList[i].cREMARK);
        //   print(stockCardReqList[i].cLOTNO);
        // }

        if (GlobalParam.deliveryPodtList[i].iCANCLEPRO != 0) {
          // if (stockCardReqList.length > 0) {
          //   print('**********************');
          //   print(stockCardReqList[i].cBRANCD);
          //   print(stockCardReqList[i].cPRODCD);
          //   print(stockCardReqList[i].cUOMCD);
          //   print(stockCardReqList[i].cWH);
          //   print(stockCardReqList[i].cREFDOC);
          //   print(stockCardReqList[i].iRECEIVEQTY);
          //   print(stockCardReqList[i].iISSUEQTY);
          //   print(stockCardReqList[i].cREMARK);
          //   print(stockCardReqList[i].cLOTNO);
          // }
          String cUOMCD = '';
          if (double.parse(GlobalParam.deliveryPodtList[i].iSSIZEQTY) != 0) {
            cUOMCD = GlobalParam.deliveryPodtList[i].cSUOMCD;
          }
          if (double.parse(GlobalParam.deliveryPodtList[i].iMSIZEQTY) != 0) {
            cUOMCD = GlobalParam.deliveryPodtList[i].cMUOMCD;
          }
          if (double.parse(GlobalParam.deliveryPodtList[i].iLSIZEQTY) != 0) {
            cUOMCD = GlobalParam.deliveryPodtList[i].cLUOMCD;
          }
          StockCardReq cancel = StockCardReq(
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cPRODCD: GlobalParam.deliveryPodtList[i].cPRODCD,
              cUOMCD: cUOMCD,
              cWH: 'TRR',
              cREFDOC: GlobalParam
                  .deliveryProductList[0].cPOCD, //RG-สาขา-YYMMDD-0000
              iRECEIVEQTY: '${GlobalParam.deliveryPodtList[i].iCANCLEPRO}',
              iISSUEQTY: '0',
              cREMARK: '',
              cLOTNO: '',
              cCREABY: GlobalParam.userID);

          stockCardReqList.add(cancel);
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
          wrongDialog(result.message);
        }
      }

      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getPodtShow(String cPOCD, String cPRODNM, String cPRODCD) async {
    double sumItem = 0;
    if (cPOCD != '') {
      if (cPOCD != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result = await proxy.getPodt(QueryPodtReq(
              cPOCD: cPOCD,
              cPRODCD: '%$cPRODCD%',
              cPRODNM: '%$cPRODNM%',
              cCUSTTYPE: GlobalParam.customer['cCUSTTYPE']));
          if (result.isNotEmpty) {
            //  print('+++++++++++++++++++ query TBT_PODT success +++++++++++++++++++');
            podtList.clear();
            double total = 0;
            for (int i = 0; i < result.length; i++) {
              if (result[i].iNETTOTAL == null) {
                result[i].iNETTOTAL = '0.0';
              }
              sumItem += double.parse(result[i].iSSIZEQTY) +
                  double.parse(result[i].iMSIZEQTY) +
                  double.parse(result[i].iLSIZEQTY);
              podtList.add(result[i]);
              total += double.parse(result[i].iNETTOTAL);

              // if (double.parse(result[i].iSSIZEQTY) != 0.0) {
              //   var data = {
              //     "cUOMNM": result[i].cSUOMNM,
              //     "iPRICE": result[i].iSUNITPRICE,
              //     "iTOTAL": result[i].iTOTAL
              //   };
              //   unitList.add(data);
              // } else if (double.parse(result[i].iMSIZEQTY) != 0.0) {
              //   var data = {
              //     "cUOMNM": result[i].cMUOMNM,
              //     "iPRICE": result[i].iMUNITPRICE,
              //     "iTOTAL": result[i].iTOTAL
              //   };
              //   unitList.add(data);
              // } else if (double.parse(result[i].iMSIZEQTY) != 0.0) {
              //   var data = {
              //     "cUOMNM": result[i].cLUOMNM,
              //     "iPRICE": result[i].iLUNITPRICE,
              //     "iTOTAL": result[i].iTOTAL
              //   };
              //   unitList.add(data);
              // } else {
              //   var data = {
              //     "cUOMNM": '',
              //     "iPRICE": '0.0',
              //     "iTOTAL": '0.0',
              //   };
              //   unitList.add(data);
              // }

              if (result[i].cPREPAIRSTATUS == 'N') {
                podtListNstatus.add(result[i]);
              }
            }
            GlobalParam.deliveryPodtShow = podtList;

            getBasketsofCustomer(cCUSTCD, cPOCD, '%$cPRODNM%', '%$cPRODCD%');
          } else {
            // print('+++++++++++++++++++ query TBT_PODT fail +++++++++++++++++++');
            podtList.clear();
          }
        } on SocketException catch (e) {
          wrongDialog(e.message);
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
        setState(() {});
      }
    } else {
      wrongDialog("custcd is null.");
    }
  }

  getBasketsofCustomer(
      String custcd, String pocd, String cPRODNM, String cPRODCD) async {
    if (custcd != '') {
      if (custcd != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result =
              await proxy.getBaskets(custcd, pocd, '%$cPRODNM%', '%$cPRODCD%');
          if ((result.isNotEmpty)) {
            // print("+++++++++++++++++ ${result.cPOCD} +++++++++++++++++");
            setState(() {
              productList = result;
              GlobalParam.deliveryProductShow = result;
            });
          }
          // print('++++++++++++ ${sumOfStore.length} ++++++++++++');
        } on SocketException catch (e) {
          wrongDialog(e.message);
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
      }
    } else {
      wrongDialog("custcd is null.");
    }
  }

  getCustHisWithDate(GetCustHisWithDateReq req) async {
    if (req.cCUSTCD != '') {
      if (req.dSHIPDATE != '') {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result = await proxy.getCustHisWithDate(req);
          if ((result.isNotEmpty)) {
            GlobalParam.deliveryCustPOHisDate = result;
          }
        } on SocketException catch (e) {
          wrongDialog(e.message);
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
      } else {
        wrongDialog("dSHIPDATE is null.");
      }
    } else {
      wrongDialog("cCUSTCD is null.");
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
    return GlobalParam.deliveryPodtShow.length > 0
        ? ListView.builder(
            reverse: false,
            padding: const EdgeInsets.all(5),
            itemCount: GlobalParam.deliveryPodtList.length,
            itemBuilder: (BuildContext context, int index) {
              double item = double.parse(
                      GlobalParam.deliveryPodtShow[index].iSSIZEQTY) +
                  double.parse(GlobalParam.deliveryPodtShow[index].iMSIZEQTY) +
                  double.parse(GlobalParam.deliveryPodtShow[index].iLSIZEQTY);
              var unit = '';
              var unitCode = '';
              var size = '';
              var hisPro = '0';
              var currentPro = '0';
              var unitPrice = 0.0;
              var total = 0.0;
              bool goodCheck = false;
              bool badCheck = false;
              controller.add(new TextEditingController());

              if (double.parse(GlobalParam.deliveryPodtShow[index].iSSIZEQTY) >
                  0) {
                unitCode = GlobalParam.deliveryPodtShow[index].cSUOMCD;
                unit = GlobalParam.deliveryPodtShow[index].cSUOMNM;
                currentPro =
                    double.parse(GlobalParam.deliveryPodtShow[index].iSSIZEQTY)
                        .toStringAsFixed(0);
                unitPrice = double.parse(
                    GlobalParam.deliveryPodtShow[index].iSUNITPRICE);
                total = double.parse(
                        GlobalParam.deliveryPodtShow[index].iSUNITPRICE) *
                    double.parse(GlobalParam.deliveryPodtShow[index].iSSIZEQTY);
                size = "S";
              }
              if (double.parse(GlobalParam.deliveryPodtShow[index].iMSIZEQTY) >
                  0) {
                unitCode = GlobalParam.deliveryPodtShow[index].cMUOMCD;
                unit = GlobalParam.deliveryPodtShow[index].cMUOMNM;
                currentPro =
                    double.parse(GlobalParam.deliveryPodtShow[index].iMSIZEQTY)
                        .toStringAsFixed(0);
                unitPrice = double.parse(
                    GlobalParam.deliveryPodtShow[index].iMUNITPRICE);
                total = double.parse(
                        GlobalParam.deliveryPodtShow[index].iMUNITPRICE) *
                    double.parse(GlobalParam.deliveryPodtShow[index].iMSIZEQTY);
                size = "M";
              }
              if (double.parse(GlobalParam.deliveryPodtShow[index].iLSIZEQTY) >
                  0) {
                unitCode = GlobalParam.deliveryPodtShow[index].cLUOMCD;
                unit = GlobalParam.deliveryPodtShow[index].cLUOMNM;
                currentPro =
                    double.parse(GlobalParam.deliveryPodtShow[index].iLSIZEQTY)
                        .toStringAsFixed(0);
                unitPrice = double.parse(
                    GlobalParam.deliveryPodtShow[index].iLUNITPRICE);
                total = double.parse(
                        GlobalParam.deliveryPodtShow[index].iLUNITPRICE) *
                    double.parse(GlobalParam.deliveryPodtShow[index].iLSIZEQTY);
                size = "L";
              }
              for (var item in GlobalParam.deliveryCustPOHisDate) {
                if (item.cPRODCD ==
                    GlobalParam.deliveryPodtShow[index].cPRODCD) {
                  if (double.parse(
                          GlobalParam.deliveryPodtShow[index].iSSIZEQTY) >
                      0) {
                    hisPro = item.iSSIZEQTY;
                  }
                  if (double.parse(
                          GlobalParam.deliveryPodtShow[index].iMSIZEQTY) >
                      0) {
                    hisPro = item.iMSIZEQTY;
                  }
                  if (double.parse(
                          GlobalParam.deliveryPodtShow[index].iLSIZEQTY) >
                      0) {
                    hisPro = item.iLSIZEQTY;
                  }
                }
              }

              for (var item in GlobalParam.deliveryCustPOHisBtnCheck) {
                if (item["cPRODCD"] ==
                    GlobalParam.deliveryPodtShow[index].cPRODCD) {
                  if (item["cUOMCD"] == unitCode) {
                    goodCheck = item['CPROGD'];
                    badCheck = item['CPROBD'];
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
                      height: 136.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            width: 100.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                                image: GlobalParam.deliveryPodtShow[index]
                                            .cPHOTOPATH !=
                                        ''
                                    ? DecorationImage(
                                        image: new NetworkImage(
                                          'http://${GlobalParam.deliveryPodtShow[index].cPHOTOSERV}/${GlobalParam.deliveryPodtShow[index].cPHOTOPATH}',
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
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${item.toStringAsFixed(0)} ${GlobalParam.deliveryPodtShow[index].cPRODNM}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Prompt',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 32,
                                      width: widthScreen * 0.25,
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: GlobalParam.deliveryPodtShow
                                                        .length >
                                                    0
                                                ? Text(
                                                    '$unit',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: 'Prompt',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.0),
                                                  )
                                                : Text(
                                                    '',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: 'Prompt',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.0),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (goodCheck == true) {
                                            goodCheck = false;
                                          } else {
                                            goodCheck = true;
                                          }

                                          print('Good : $goodCheck');
                                        });

                                        for (var i = 0;
                                            i <
                                                GlobalParam
                                                    .deliveryCustPOHisBtnCheck
                                                    .length;
                                            i++) {
                                          if (GlobalParam
                                                      .deliveryCustPOHisBtnCheck[
                                                  i]["cPRODCD"] ==
                                              GlobalParam
                                                  .deliveryPodtShow[index]
                                                  .cPRODCD) {
                                            if (GlobalParam
                                                        .deliveryCustPOHisBtnCheck[
                                                    i]["cUOMCD"] ==
                                                unitCode) {
                                              GlobalParam
                                                      .deliveryCustPOHisBtnCheck[
                                                  i]['CPROGD'] = goodCheck;
                                              GlobalParam
                                                      .deliveryCustPOHisBtnCheck[
                                                  i]['CPROBD'] = false;
                                            }
                                          }
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        // padding: const EdgeInsets.all(5.0),
                                        height: 30.0,
                                        width: widthScreen * 0.18,
                                        decoration: BoxDecoration(
                                            color: goodCheck == false
                                                ? Colors.white
                                                : Colors.green.shade100,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5),
                                            ),
                                            border: Border.all(
                                                color: Colors.green)),
                                        child: Center(
                                            child: Text('สินค้าดี',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: 'Prompt',
                                                    fontSize: 14.0),
                                                textAlign: TextAlign.center)),
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (badCheck == true) {
                                            badCheck = false;
                                          } else {
                                            badCheck = true;
                                          }

                                          print('Bad: $badCheck');
                                        });

                                        for (var i = 0;
                                            i <
                                                GlobalParam
                                                    .deliveryCustPOHisBtnCheck
                                                    .length;
                                            i++) {
                                          if (GlobalParam
                                                      .deliveryCustPOHisBtnCheck[
                                                  i]["cPRODCD"] ==
                                              GlobalParam
                                                  .deliveryPodtShow[index]
                                                  .cPRODCD) {
                                            if (GlobalParam
                                                        .deliveryCustPOHisBtnCheck[
                                                    i]["cUOMCD"] ==
                                                unitCode) {
                                              GlobalParam
                                                      .deliveryCustPOHisBtnCheck[
                                                  i]['CPROGD'] = false;
                                              GlobalParam
                                                      .deliveryCustPOHisBtnCheck[
                                                  i]['CPROBD'] = badCheck;
                                            }
                                          }
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        // padding: const EdgeInsets.all(5.0),
                                        height: 30.0,
                                        width: widthScreen * 0.18,
                                        decoration: BoxDecoration(
                                            color: badCheck == false
                                                ? Colors.white
                                                : Colors.red.shade100,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5),
                                            ),
                                            border:
                                                Border.all(color: Colors.red)),
                                        child: Center(
                                            child: Text('สินค้าเสีย',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontFamily: 'Prompt',
                                                    fontSize: 14.0),
                                                textAlign: TextAlign.center)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 32.0,
                                            width: widthScreen * 0.2,
                                            alignment: Alignment.center,
                                            child: Text(
                                              'รอบก่อน',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Prompt',
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            // padding: const EdgeInsets.all(5.0),
                                            height: 30.0,
                                            width: widthScreen * 0.2,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5),
                                                ),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Center(
                                                child: Text(hisPro,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Prompt',
                                                        fontSize: 14.0),
                                                    textAlign:
                                                        TextAlign.center)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 32.0,
                                            width: widthScreen * 0.2,
                                            alignment: Alignment.center,
                                            child: Text(
                                              'รอบนี้',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Prompt',
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            // padding: const EdgeInsets.all(5.0),
                                            height: 30.0,
                                            width: widthScreen * 0.2,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5),
                                                ),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Center(
                                                child: Text(currentPro,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Prompt',
                                                        fontSize: 14.0),
                                                    textAlign:
                                                        TextAlign.center)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 32.0,
                                            width: widthScreen * 0.2,
                                            alignment: Alignment.center,
                                            child: Text(
                                              'คืน/เหลือ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Prompt',
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            // padding: const EdgeInsets.all(5.0),
                                            height: 30.0,
                                            width: widthScreen * 0.2,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5),
                                                ),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Center(
                                              child: TextField(
                                                controller: controller[index],
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                  color: HexColor('#00cb39'),
                                                  fontFamily: 'Prompt',
                                                ),
                                                onChanged: (value) {
                                                  int iCANCLEPRO = 0;

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
                                                                    .deliveryUnitList[
                                                                j]["cPRODCD"] ==
                                                            GlobalParam
                                                                .deliveryPodtShow[
                                                                    index]
                                                                .cPRODCD) {
                                                          if (GlobalParam
                                                                      .deliveryUnitList[
                                                                  j]["cUOMCD"] ==
                                                              unitCode) {
                                                            GlobalParam
                                                                .deliveryUnitList
                                                                .removeAt(j);
                                                          }
                                                        }
                                                      }
                                                    } else {
                                                      iCANCLEPRO =
                                                          int.parse(value);
                                                      var data = {
                                                        "cPRODCD": GlobalParam
                                                            .deliveryPodtShow[
                                                                index]
                                                            .cPRODCD,
                                                        "cUOMCD": unitCode,
                                                        "cUOMNM": unit,
                                                        "iPRICE": unitPrice,
                                                        "iTOTAL": double.parse(
                                                            '$iCANCLEPRO')
                                                      };
                                                      GlobalParam
                                                          .deliveryUnitList
                                                          .add(data);
                                                    }
                                                  });
                                                  if (iCANCLEPRO >
                                                      double.parse(
                                                          currentPro)) {
                                                    wrongDialog(
                                                        "คืนสินค้าได้ไม่เกินจำนวนสินค้ารอบนี้");
                                                    setState(() {
                                                      controller[index].text =
                                                          "0";
                                                    });
                                                  } else {
                                                    for (int i = 0;
                                                        i <
                                                            GlobalParam
                                                                .deliveryPodtList
                                                                .length;
                                                        i++) {
                                                      // ignore: unrelated_type_equality_checks
                                                      if (GlobalParam
                                                              .deliveryPodtList[
                                                                  i]
                                                              .iSEQ ==
                                                          GlobalParam
                                                              .deliveryPodtShow[
                                                                  index]
                                                              .iSEQ) {
                                                        GlobalParam
                                                                .deliveryPodtList[i]
                                                                .iCANCLEPRO =
                                                            iCANCLEPRO;

                                                        // print('---------------${GlobalParam
                                                        //     .deliveryPodtList[i]
                                                        //     .iCANCLEPRO}');
                                                      }
                                                    }
                                                    for (var item in GlobalParam
                                                        .deliveryCustPOHisBtnCheck) {
                                                      if (item["cPRODCD"] ==
                                                          GlobalParam
                                                              .deliveryPodtShow[
                                                                  index]
                                                              .cPRODCD) {
                                                        if (item["cUOMCD"] ==
                                                            unitCode) {
                                                          item['iQTY'] =
                                                              iCANCLEPRO;
                                                        }
                                                      }
                                                    }
                                                  }
                                                  addProMiss(
                                                      GlobalParam
                                                              .deliveryPodtShow[
                                                          index],
                                                      iCANCLEPRO,
                                                      size);
                                                },
                                                cursorColor: Colors.black,
                                                decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          width: widthScreen * 0.2,
                          child: Text(
                            "ต่อหน่วย",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Prompt',
                                fontSize: 14.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          width: widthScreen * 0.22,
                          child: Text(
                            "${numberFormat.format(unitPrice)} ฿",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Prompt',
                                fontSize: 14.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          width: widthScreen * 0.1,
                          child: Text(
                            "รวม",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Prompt',
                                fontSize: 14.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          width: widthScreen * 0.22,
                          child: Text(
                            "${numberFormat.format(total)} ฿",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Prompt',
                                fontSize: 14.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    DottedLine(
                      dashColor: Colors.grey,
                    ),
                  ],
                ),
              );
            },
          )
        : Container();
  }

  addProMiss(QueryPodtResp data, int miss, String size) {
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
        iSSIZEQTY: data.iSSIZEQTY,
        iMSIZEQTY: data.iMSIZEQTY,
        iLSIZEQTY: data.iLSIZEQTY,
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
    double price = 0;
    String unitCode = '';
    if (miss > 0) {
      if (size == "S") {
        if (double.parse(data.iSSIZEQTY) > 0) {
          GlobalParam.deliveryPodCancel.add(incom);
          price = double.parse(data.iSUNITPRICE);
          unitCode = data.cSUOMCD;
        }
      }

      if (size == "M") {
        if (double.parse(data.iMSIZEQTY) > 0) {
          GlobalParam.deliveryPodCancel.add(incom);
          price = double.parse(data.iMUNITPRICE);
          unitCode = data.cMUOMCD;
        }
      }
      if (size == "L") {
        if (double.parse(data.iLSIZEQTY) > 0) {
          GlobalParam.deliveryPodCancel.add(incom);
          price = double.parse(data.iLUNITPRICE);
          unitCode = data.cLUOMCD;
        }
      }

      AddRTPROReq req = AddRTPROReq(
        cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
        cPOCD: data.cPOCD,
        cCUSTCD: GlobalParam.deliverySelectStore.cCUSTCD,
        cPRODCD: data.cPRODCD,
        iQTY: '$miss',
        iTOTAL: '${miss * price}',
        cSTATUS: "N",
        cUOMCD: unitCode,
        cCREABY: GlobalParam.userData.cUSRNM,
      );

      reqReturnList.add(req);
    } else {
      for (int i = 0; i < GlobalParam.deliveryPodCancel.length; i++) {
        String unitCode = '';
        // ignore: unrelated_type_equality_checks
        if (GlobalParam.deliveryPodCancel[i].cPRODCD == data.cPRODCD) {
          if (size == "S") {
            if (double.parse(data.iSSIZEQTY) > 0) {
              GlobalParam.deliveryPodCancel.removeAt(i);
              unitCode = data.cSUOMCD;
            }
          }

          if (size == "M") {
            if (double.parse(data.iMSIZEQTY) > 0) {
              GlobalParam.deliveryPodCancel.removeAt(i);
              unitCode = data.cMUOMCD;
            }
          }
          if (size == "L") {
            if (double.parse(data.iLSIZEQTY) > 0) {
              GlobalParam.deliveryPodCancel.removeAt(i);
              unitCode = data.cLUOMCD;
            }
          }

          for (int j = 0; j < reqReturnList.length; j++) {
            if (reqReturnList[j].cPRODCD == data.cPRODCD &&
                reqReturnList[j].cUOMCD == unitCode) {
              reqReturnList.removeAt(j);
            }
          }
        }
      }
    }
    setState(() {});
  }
}
