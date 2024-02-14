import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addBKRReq.dart';
import 'package:vansale/api/class/request/mobile/getProductBranchReq.dart';
import 'package:vansale/api/class/request/mobile/getSPOrderDTReq.dart';
import 'package:vansale/api/class/request/mobile/getStoreDetailReq.dart';
import 'package:vansale/api/class/request/mobile/queryPodtReq.dart';
import 'package:vansale/api/class/request/mobile/searchBasket.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryCheckMiles.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivert_Store_Product_Miss.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_GetBad_Product.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_Product_check.dart';

class DeliveryQrScanner extends StatefulWidget {
  final Function navigator;
  final String code;
  const DeliveryQrScanner({Key key, this.navigator, this.code})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DeliveryQrScannerState();
}

class _DeliveryQrScannerState extends State<DeliveryQrScanner> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  BuildContext scaffoldContext;
  bool success = false;
  int counter = 0;
  String code = '';
  String cCUSTCD = '';
  String cPOCD = '';
  List<QueryPodtResp> podtList = [];
  List<QueryPodtResp> podtListNstatus = [];
  List<PoHDAndPoDTResp> productList = [];

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  void initState() {
    super.initState();
    // discovered == false;
    if (widget.code == '003') {
      cCUSTCD = GlobalParam.deliveryProductList[0].cCUSTCD;
      cPOCD = GlobalParam.deliveryProductList[0].cPOCD;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "สะแกนบาร์โค้ด",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        // leading: Container(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 225.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // setState(() {
      //   result = scanData;
      //   code = scanData.code;
      // });
      code = scanData.code;
      if (widget.code == '004') {
        getBasket(SearchBasketReq(cBASKCD: '%$code%', cBASKNM: '%%'));
      } else if (widget.code == '005' || widget.code == '002') {
        getHisProduct('$code', '%%');
      } else if (widget.code == '006') {
        getSPOrderDTShow(GlobalParam.supplierSelectOrder.cPOCD, '', '$code');
      } else if (widget.code == '007') {
        storeGetPodtSearch('$code');
      } else if (widget.code == '008') {
        searchProductBranch('$code');
      } else {
        if (code != '' && code != null) {
          getPodt(cPOCD, '', code);
        } else {
          getPodt(cPOCD, '', '');
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  searchProductBranch(String code) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var result = await proxy.getProductBranch(GetProductBranchReq(
        cBRANCD: GlobalParam.customer['cBRANCD'],
        cCUSTTYPE: GlobalParam.customer['cCUSTTYPE'],
        cPRICECD: GlobalParam.customer['cPRICECD'],
        cPRODCD: "%$code%",
        cPRODNM: "%%",
      ));
      GlobalParam.customerShowProList = [];

      if (result.isNotEmpty) {
        GlobalParam.customerShowProList.addAll(result);
      }

      if (counter < 1) {
        setState(() {
          success = true;
          counter++;
        });
      } else {
        success = false;
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }

    if (success == true) {
      widget.navigator();
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
            for (int i = 0; i < result.length; i++) {
              sumItem += double.parse(result[i].iSSIZEQTY) +
                  double.parse(result[i].iMSIZEQTY) +
                  double.parse(result[i].iLSIZEQTY);
              podtList.add(result[i]);

              if (result[i].cPREPAIRSTATUS == 'N') {
                podtListNstatus.add(result[i]);
              }
            }
            // if (success != true) {
            //   GlobalParam.deliveryPodtList = podtList;
            // }
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
        // setState(() {});
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
            // setState(() {
            //   productList = result;
            //   GlobalParam.deliveryProductList = result;
            // });
            productList = result;

            // GlobalParam.deliveryProductList = result;
          }
          // print('++++++++++++ ${sumOfStore.length} ++++++++++++');

          // Navigator.of(context).pop();
          if (counter < 1) {
            setState(() {
              success = true;
              counter++;
            });
          } else {
            success = false;
          }
        } on SocketException catch (e) {
          wrongDialog(e.message);
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
      }
    } else {
      wrongDialog("custcd is null.");
    }
    if (success == true) {
      GlobalParam.deliveryProductShow = productList;
      GlobalParam.deliveryPodtShow = podtList;
      GlobalParam.deliveryRegetPODT = false;
      widget.navigator();
    }
  }

  getBasket(SearchBasketReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getBasket(req);
      // GlobalParam.deliveryBasketList = result;
      GlobalParam.deliveryBasketShow = result;

      // for (int i = 0; i < result.length; i++) {
      //   var data = AddBKRReq(
      //       cPOCD: GlobalParam.deliveryPodtList[0].cPOCD,
      //       cCUSTCD: GlobalParam.deliverySelectStore.cCUSTCD,
      //       cBASKCD: result[i].cBASKCD,
      //       cCREABY: GlobalParam.userID);
      //   GlobalParam.deliveryBasketReq.add(data);
      // }

      if (counter < 1) {
        setState(() {
          success = true;
          counter++;
        });
      } else {
        success = false;
      }

      if (result.isEmpty) {
        wrongDialog('ไม่พบรายการตะกร้า');
      }
      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }

    if (success == true) {
      GlobalParam.deliveryRegetPODT = false;
      widget.navigator();
    }
  }

  storeGetPodtSearch(String cPRODCD) async {
    try {
      List<QueryPodtResp> podtList = [];

      var unitList = [];
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var result = await proxy.getPodt(QueryPodtReq(
          cPOCD: GlobalParam.customerPOHDSelect.cPOCD,
          cPRODCD: '%$cPRODCD%',
          cPRODNM: '%%',
          cCUSTTYPE: GlobalParam.customer['cCUSTTYPE']));

      if (result.isNotEmpty) {
        GlobalParam.customerProductList = [];
        GlobalParam.customerProductList.addAll(result);
        for (int i = 0; i < result.length; i++) {
          // sumItem += double.parse(result[i].iSSIZEQTY) +
          //     double.parse(result[i].iMSIZEQTY) +
          //     double.parse(result[i].iLSIZEQTY);

          if (double.parse(result[i].iSSIZEQTY) > 0) {
            var data = {
              "cPRODCD": result[i].cPRODCD,
              "cUOMNM": result[i].cSUOMNM,
              "iPRICE": double.parse(result[i].iSUNITPRICE),
              "iTOTAL": double.parse(result[i].iSSIZEQTY)
            };
            unitList.add(data);
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
              iCANCLEPRO: 0,
              iDISCOUNT: result[i].iDISCOUNT,
              iFREE: result[i].iFREE,
              iINCOMPRO: 0,
              iLOSSPRO: 0,
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
              "iPRICE": double.parse(result[i].iMUNITPRICE),
              "iTOTAL": double.parse(result[i].iMSIZEQTY)
            };
            unitList.add(data);
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
              iCANCLEPRO: 0,
              iDISCOUNT: result[i].iDISCOUNT,
              iFREE: result[i].iFREE,
              iINCOMPRO: 0,
              iLOSSPRO: 0,
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
              "iPRICE": double.parse(result[i].iLUNITPRICE),
              "iTOTAL": double.parse(result[i].iLSIZEQTY)
            };
            unitList.add(data);
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
              iCANCLEPRO: 0,
              iDISCOUNT: result[i].iDISCOUNT,
              iFREE: result[i].iFREE,
              iINCOMPRO: 0,
              iLOSSPRO: 0,
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
        }
        GlobalParam.deliveryPodtShow = [];
        for (int i = 0; i < podtList.length; i++) {
          GlobalParam.deliveryPodtShow.add(podtList[i]);
        }
      } else {
        GlobalParam.deliveryPodtShow = [];
      }

      if (counter < 1) {
        setState(() {
          success = true;
          counter++;
        });
      } else {
        success = false;
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }

    if (success == true) {
      GlobalParam.deliveryRegetPODT = false;
      widget.navigator();
    }
  }

  getHisProduct(String cPRODCD, String cPRODNM) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getHisProduct(GetStoreDetailReq(
          cCUSTCD: GlobalParam.deliverySelectStore.cCUSTCD,
          cPRODCD: cPRODCD,
          cPRODNM: cPRODNM));
      GlobalParam.deliveryShowHisProduct.clear();
      if (result.isNotEmpty) {
        GlobalParam.deliveryShowHisProduct = result;
        if (counter < 1) {
          setState(() {
            success = true;
            counter++;
          });
        } else {
          success = false;
        }
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    if (success == true) {
      GlobalParam.deliveryRegetPODT = false;
      widget.navigator();
    }
  }

  getSPOrderDTShow(String cPOCD, String cPRODNM, String cPRODCD) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getSPOrderDT(GetSPOrderDTReq(
          cPOCD: cPOCD, cPRODNM: '%$cPRODNM%', cPRODCD: '%$cPRODCD%'));

      if (result.isNotEmpty) {
        GlobalParam.supplierOrProductShowList = [];
        for (int i = 0; i < result.length; i++) {
          GlobalParam.supplierOrProductShowList.add(result[i]);
        }
        if (counter < 1) {
          setState(() {
            success = true;
            counter++;
          });
        } else {
          success = false;
        }
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    if (success == true) {
      GlobalParam.deliveryRegetPODT = false;
      widget.navigator();
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
}
