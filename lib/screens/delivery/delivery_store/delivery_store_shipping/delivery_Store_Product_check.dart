import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/queryPodtReq.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/delivery/delivery_scanner.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivert_Store_Product_Miss.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_Check_List.dart';
import 'package:vansale/screens/delivery/delivery_store_footer.dart';

class DeliveryStoreProductCheck extends StatefulWidget {
  final String typeMenuCode;
  DeliveryStoreProductCheck(this.typeMenuCode);

  @override
  State<DeliveryStoreProductCheck> createState() =>
      _DeliveryStoreProductCheckState();
}

class _DeliveryStoreProductCheckState extends State<DeliveryStoreProductCheck> {
  var IncomPro = TextEditingController();
  String cCUSTCD = GlobalParam.deliveryProductList[0].cCUSTCD!;
  String cPOCD = GlobalParam.deliveryProductList[0].cPOCD!;
  List<QueryPodtResp> podtList = [];
  List<QueryPodtResp> podtListNstatus = [];
  List<PoHDAndPoDTResp> productList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GlobalParam.deliveryUnitList = [];
    if (GlobalParam.deliveryRegetPODT == true) {
      getPodt(cPOCD, '', '');
      GlobalParam.deliveryRegetPODT = false;
    }
    GlobalParam.deliveryProIncom = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สินค้าขาด'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Container(
              child: listOfProduct(),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            color: HexColor('#6c7e9b'),
            height: 60.0,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
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
                            getPodt(cPOCD, value, '');
                          } else {
                            GlobalParam.deliveryProductShow =
                                GlobalParam.deliveryProductList;
                            GlobalParam.deliveryPodtShow =
                                GlobalParam.deliveryPodtList;
                          }
                        },
                        style: const TextStyle(
                          fontFamily: 'Prompt',
                        ),
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: "ค้นหา",
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.only(left: 5.0, top: 5.0),
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
                                    code: '001',
                                    navigator: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DeliveryStoreProductCheck(
                                                      GlobalParam
                                                          .typeMenuCode!)));
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
        ],
      ),
      bottomNavigationBar: DeliveryFooter(
        title1: 'บันทึกสินค้าขาด',
        title2: '',
        item: double.parse('${GlobalParam.deliveryUnitList.length}'),
        navigated1: () {
          for (int i = 0; i < GlobalParam.deliveryProIncom.length; i++) {
            updateICLPro(
                GlobalParam.deliveryProIncom[i].cPOCD!,
                GlobalParam.deliveryProIncom[i].iSEQ!,
                GlobalParam.deliveryProIncom[i].iINCOMPRO!,
                GlobalParam.deliveryProIncom[i].iCANCLEPRO!,
                GlobalParam.deliveryProIncom[i].iLOSSPRO!,
                GlobalParam.deliveryProIncom[i].cUPDABY!);
          }
          GlobalParam.deliveryRegetPODT = true;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  DeliveryStoreProductMiss(widget.typeMenuCode),
            ),
          );
          addStockCard();
        },
        navigated2: () {},
        icon1: const Icon(
          LineAwesomeIcons.check_circle,
          color: Colors.green,
          size: 25.0,
        ),
        icon2: const Icon(
          LineAwesomeIcons.check_circle,
          color: Colors.green,
          size: 25.0,
        ),
      ),
    );
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
              total += double.parse(result[i].iTOTAL!);
              sumItem += double.parse(result[i].iSSIZEQTY!) +
                  double.parse(result[i].iMSIZEQTY!) +
                  double.parse(result[i].iLSIZEQTY!);

              if (double.parse(result[i].iSSIZEQTY!) > 0) {
                var data = {
                  "cPRODCD": result[i].cPRODCD,
                  "cUOMNM": result[i].cSUOMNM,
                  "iPRICE": result[i].iSUNITPRICE,
                  "iTOTAL": result[i].iTOTAL
                };

                QueryPodtResp product = QueryPodtResp(
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
                  cPREPAIRSTATUS: result[i].cPREPAIRSTATUS ?? 'N',
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
                  iCANCLEPRO: 0,
                  iDISCOUNT: result[i].iDISCOUNT,
                  iFREE: result[i].iFREE,
                  iINCOMPRO: 0,
                  iLOSSPRO: 0,
                  iLSIZEQTY: '0.0',
                  iLUNITPRICE: result[i].iLUNITPRICE,
                  iMSIZEQTY: '0.0',
                  iMUNITPRICE: result[i].iMUNITPRICE,
                  iNETTOTAL: result[i].iNETTOTAL ?? '0',
                  iPREPAIRAMOUT: result[i].iPREPAIRAMOUT ?? '0',
                  iSEQ: result[i].iSEQ,
                  iSSIZEQTY: result[i].iSSIZEQTY,
                  iSUNITPRICE: result[i].iSUNITPRICE,
                  iTOTAL:
                      "${double.parse(result[i].iSSIZEQTY!) * double.parse(result[i].iSUNITPRICE!)}",
                );

                podtList.add(product);
              }
              if (double.parse(result[i].iMSIZEQTY!) > 0) {
                var data = {
                  "cPRODCD": result[i].cPRODCD,
                  "cUOMNM": result[i].cMUOMNM,
                  "iPRICE": result[i].iMUNITPRICE,
                  "iTOTAL": result[i].iTOTAL
                };

                QueryPodtResp product = QueryPodtResp(
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
                  cPREPAIRSTATUS: result[i].cPREPAIRSTATUS ?? 'N',
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
                  iCANCLEPRO: 0,
                  iDISCOUNT: result[i].iDISCOUNT,
                  iFREE: result[i].iFREE,
                  iINCOMPRO: 0,
                  iLOSSPRO: 0,
                  iLSIZEQTY: '0.0',
                  iLUNITPRICE: result[i].iLUNITPRICE,
                  iMSIZEQTY: result[i].iMSIZEQTY,
                  iMUNITPRICE: result[i].iMUNITPRICE,
                  iNETTOTAL: result[i].iNETTOTAL ?? '0',
                  iPREPAIRAMOUT: result[i].iPREPAIRAMOUT ?? '0',
                  iSEQ: result[i].iSEQ,
                  iSSIZEQTY: '0.0',
                  iSUNITPRICE: result[i].iSUNITPRICE,
                  iTOTAL:
                      "${double.parse(result[i].iMSIZEQTY!) * double.parse(result[i].iMUNITPRICE!)}",
                );

                podtList.add(product);
              }
              if (double.parse(result[i].iLSIZEQTY!) > 0) {
                var data = {
                  "cPRODCD": result[i].cPRODCD,
                  "cUOMNM": result[i].cLUOMNM,
                  "iPRICE": result[i].iLUNITPRICE,
                  "iTOTAL": result[i].iTOTAL
                };

                QueryPodtResp product = QueryPodtResp(
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
                  cPREPAIRSTATUS: result[i].cPREPAIRSTATUS ?? 'N',
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
                  iCANCLEPRO: 0,
                  iDISCOUNT: result[i].iDISCOUNT,
                  iFREE: result[i].iFREE,
                  iINCOMPRO: 0,
                  iLOSSPRO: 0,
                  iLSIZEQTY: result[i].iLSIZEQTY,
                  iLUNITPRICE: result[i].iLUNITPRICE,
                  iMSIZEQTY: '0.0',
                  iMUNITPRICE: result[i].iMUNITPRICE,
                  iNETTOTAL: result[i].iNETTOTAL ?? '0',
                  iPREPAIRAMOUT: result[i].iPREPAIRAMOUT ?? '0',
                  iSEQ: result[i].iSEQ,
                  iSSIZEQTY: '0.0',
                  iSUNITPRICE: result[i].iSUNITPRICE,
                  iTOTAL:
                      "${double.parse(result[i].iLSIZEQTY!) * double.parse(result[i].iLUNITPRICE!)}",
                );

                podtList.add(product);
              }

              if (result[i].cPREPAIRSTATUS == 'N') {
                podtListNstatus.add(result[i]);
              }
            }

            GlobalParam.deliveryPodtShow = podtList;
            GlobalParam.deliveryStoreSum.iTOTAL = total.toString();
            getBasketsofCustomer(cCUSTCD, cPOCD, '%$cPRODNM%', '%$cPRODCD%');
            // print('+++++++++++++++++++ ${podtList.length} +++++++++++++++++++');
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
              GlobalParam.deliveryProductList = result;
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

        if (GlobalParam.deliveryPodtList[i].iINCOMPRO != 0) {
          String cUOMCD = '';
          if (double.parse(GlobalParam.deliveryPodtList[i].iSSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryPodtList[i].cSUOMCD!;
          }
          if (double.parse(GlobalParam.deliveryPodtList[i].iMSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryPodtList[i].cMUOMCD!;
          }
          if (double.parse(GlobalParam.deliveryPodtList[i].iLSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryPodtList[i].cLUOMCD!;
          }
          StockCardReq inCom = StockCardReq(
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cPRODCD: GlobalParam.deliveryPodtList[i].cPRODCD,
              cUOMCD: cUOMCD,
              cWH: 'FG',
              cREFDOC: GlobalParam.deliveryProductList[0].cPOCD,
              iRECEIVEQTY: '${GlobalParam.deliveryPodtList[i].iINCOMPRO}',
              iISSUEQTY: '0',
              cREMARK: '',
              cLOTNO: '',
              cCREABY: GlobalParam.userID);

          stockCardReqList.add(inCom);
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

  Widget listOfProduct() {
    return GlobalParam.deliveryPodtShow.isNotEmpty
        ? ListView.builder(
            reverse: false,
            padding: const EdgeInsets.all(5),
            itemCount: GlobalParam.deliveryPodtShow.length,
            itemBuilder: (BuildContext context, int index) {
              double item = double.parse(
                      GlobalParam.deliveryPodtShow[index].iSSIZEQTY!) +
                  double.parse(GlobalParam.deliveryPodtShow[index].iMSIZEQTY!) +
                  double.parse(GlobalParam.deliveryPodtShow[index].iLSIZEQTY!);
              var unit = '';
              var unitCode = '';
              var unitPrice = '';
              var size = '';
              if (double.parse(GlobalParam.deliveryPodtShow[index].iSSIZEQTY!) >
                  0) {
                unit = GlobalParam.deliveryPodtShow[index].cSUOMNM!;
                unitPrice = GlobalParam.deliveryPodtShow[index].iSUNITPRICE!;
                unitCode = GlobalParam.deliveryPodtShow[index].cSUOMCD!;
                size = 'S';
              }
              if (double.parse(GlobalParam.deliveryPodtShow[index].iMSIZEQTY!) >
                  0) {
                unit = GlobalParam.deliveryPodtShow[index].cMUOMNM!;
                unitPrice = GlobalParam.deliveryPodtShow[index].iMUNITPRICE!;
                unitCode = GlobalParam.deliveryPodtShow[index].cMUOMCD!;
                size = 'M';
              }
              if (double.parse(GlobalParam.deliveryPodtShow[index].iLSIZEQTY!) >
                  0) {
                unit = GlobalParam.deliveryPodtShow[index].cLUOMNM!;
                unitPrice = GlobalParam.deliveryPodtShow[index].iLUNITPRICE!;
                unitCode = GlobalParam.deliveryPodtShow[index].cLUOMCD!;
                size = 'L';
              }
              return Container(
                color: HexColor("#F2F3F4"),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      height: 110.0,
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
                                        image: NetworkImage(
                                          'http://${GlobalParam.deliveryPodtShow[index].cPHOTOSERV}/${GlobalParam.deliveryPodtShow[index].cPHOTOPATH}',
                                        ),
                                        scale: 1.0,
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(
                                          "assets/images/no_image.png",
                                        ),
                                        scale: 1.0,
                                        fit: BoxFit.cover,
                                      ),
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
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
                                    GlobalParam
                                        .deliveryPodtShow[index].cPRODNM!,
                                    style: const TextStyle(
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
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: GlobalParam
                                                      .deliveryPodtShow
                                                      .isNotEmpty
                                                  ? Text(
                                                      '${item.toStringAsFixed(0)} $unit',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Prompt',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.0),
                                                    )
                                                  : const Text(
                                                      ' ตะกร้า',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Prompt',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.0),
                                                    ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                GlobalParam
                                                    .deliveryPodtShow[index]
                                                    .cPOCD!,
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'Prompt',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      width: 100.0,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 36.0,
                                            width: 64.0,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'สินค้าขาด',
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
                                            width: 96.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.only(
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
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 8, 0, 0),
                                                child: TextField(
                                                  // controller: IncomPro,
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                    color: HexColor('#00cb39'),
                                                    fontFamily: 'Prompt',
                                                  ),
                                                  cursorColor: Colors.black,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                  ),
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
                                                                  ["cPRODCD"] ==
                                                              GlobalParam
                                                                  .deliveryPodtShow[
                                                                      index]
                                                                  .cPRODCD) {
                                                            if (GlobalParam
                                                                        .deliveryUnitList[j]
                                                                    [
                                                                    "cUOMCD"] ==
                                                                unitCode) {
                                                              GlobalParam
                                                                  .deliveryUnitList
                                                                  .removeAt(j);
                                                            }
                                                          }
                                                        }
                                                      } else {
                                                        iINCOMPRO =
                                                            int.parse(value);
                                                        var data = {
                                                          "cPRODCD": GlobalParam
                                                              .deliveryPodtShow[
                                                                  index]
                                                              .cPRODCD,
                                                          "cUOMCD": unitCode,
                                                          "cUOMNM": unit,
                                                          "iPRICE":
                                                              double.parse(
                                                                  unitPrice),
                                                          "iTOTAL":
                                                              double.parse(
                                                                  '$iINCOMPRO')
                                                        };
                                                        GlobalParam
                                                            .deliveryUnitList
                                                            .add(data);
                                                      }
                                                    });

                                                    addProIncom(
                                                        GlobalParam
                                                                .deliveryPodtShow[
                                                            index],
                                                        iINCOMPRO,
                                                        size);
                                                  },
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
                    const DottedLine(
                      dashColor: Colors.grey,
                    ),
                  ],
                ),
              );
            },
          )
        : Container();
  }

  addProIncom(QueryPodtResp data, int iINCOMPRO, String size) {
    QueryPodtResp incom = QueryPodtResp(
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
        iINCOMPRO: iINCOMPRO,
        iCANCLEPRO: data.iCANCLEPRO,
        iLOSSPRO: data.iLOSSPRO,
        cSUOMCD: data.cSUOMCD,
        cMUOMCD: data.cMUOMCD,
        cLUOMCD: data.cLUOMCD);
    if (iINCOMPRO > 0) {
      if (size == "S") {
        if (double.parse(data.iSSIZEQTY!) > 0) {
          GlobalParam.deliveryProIncom.add(incom);
        }
      }

      if (size == "M") {
        if (double.parse(data.iMSIZEQTY!) > 0) {
          GlobalParam.deliveryProIncom.add(incom);
        }
      }
      if (size == "L") {
        if (double.parse(data.iLSIZEQTY!) > 0) {
          GlobalParam.deliveryProIncom.add(incom);
        }
      }
    } else {
      for (int i = 0; i < GlobalParam.deliveryProIncom.length; i++) {
        // ignore: unrelated_type_equality_checks
        if (GlobalParam.deliveryProIncom[i].cPRODCD == data.cPRODCD) {
          if (size == "S") {
            if (double.parse(data.iSSIZEQTY!) > 0) {
              GlobalParam.deliveryProIncom.removeAt(i);
            }
          }

          if (size == "M") {
            if (double.parse(data.iMSIZEQTY!) > 0) {
              GlobalParam.deliveryProIncom.removeAt(i);
            }
          }
          if (size == "L") {
            if (double.parse(data.iLSIZEQTY!) > 0) {
              GlobalParam.deliveryProIncom.removeAt(i);
            }
          }
        }
      }
    }
  }
}
