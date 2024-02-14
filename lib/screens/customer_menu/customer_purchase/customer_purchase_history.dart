import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getCustomerPOhisReq.dart';
import 'package:vansale/api/class/request/mobile/getProductStockReq.dart';
import 'package:vansale/api/class/request/mobile/queryPodtReq.dart';
import 'package:vansale/api/class/response/routeMobile/getCustomerPOhisResp.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/screens/customer_menu/customer_purchase/customer_list_purchase_history.dart';

class CustomerPurchaseHistory extends StatefulWidget {
  final String typeMenuCode;
  CustomerPurchaseHistory(this.typeMenuCode);

  @override
  State<CustomerPurchaseHistory> createState() =>
      _CustomerPurchaseHistoryState();
}

class _CustomerPurchaseHistoryState extends State<CustomerPurchaseHistory> {
  var search = TextEditingController();
  bool show = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustomerPOHis(GetCustomerPOHisReq(
        cCUSTCD: GlobalParam.customer['cCUSTCD'], cPOCD: '%%'));
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        show = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'ประวัติการสั่ง',
          style: TextStyle(
            color: Colors.black,
            //color: Color.fromRGBO(0, 157, 181, 5),
            fontFamily: 'Prompt',
            fontSize: 18.0,
          ),
        ),
      ),
      body: show == true?Container(
        child: Column(
          children: [
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
                          controller: search,
                          style: TextStyle(
                            fontFamily: 'Prompt',
                          ),
                          onSubmitted: (value) {
                            setState(() {
                              search.text = value;
                            });
                            getCustomerPOHis(GetCustomerPOHisReq(
                                cCUSTCD: GlobalParam.customer['cCUSTCD'],
                                cPOCD: '%$value%'));
                          },
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: "ค้นหาเลขที่บิล",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 5.0, top: 5.0),
                            prefixIcon: RotatedBox(
                              quarterTurns: 1,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: HexColor('#6c7e9b'),
                                ),
                                onPressed: () {
                                  getCustomerPOHis(GetCustomerPOHisReq(
                                      cCUSTCD: GlobalParam.customer['cCUSTCD'],
                                      cPOCD: '%${search.text}%'));
                                },
                                iconSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: Colors.green,
                onRefresh: () async {
                  return await Future.delayed(Duration(seconds: 1));
                },
                child: CustomerListPurchaseHistory(widget.typeMenuCode),
              ),
            ),
          ],
        ),
      ):Container(),
    );
  }

  getCustomerPOHis(GetCustomerPOHisReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var result = await proxy.getCustomerPOHis(req);
      GlobalParam.customerPOHDList = [];
      GlobalParam.customerPODTList = [];

      if (result.isNotEmpty) {
        for (int i = 0; i < result.length; i++) {
          if (double.parse(result[i].iTOTAL) > 0) {
            GlobalParam.customerPOHDList.add(result[i]);
            getPodt(result[i].cPOCD);
          }
        }
      } else {
        wrongDialog('ไม่พบประวัติการสั่งซื้อ');
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getPodt(String cPOCD) async {
    try {
      List<QueryPodtResp> podtList = [];

      var unitList = [];
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var result = await proxy.getPodt(QueryPodtReq(
          cPOCD: cPOCD,
          cPRODCD: '%%',
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
              cSUOMCD: result[i].cSUOMCD,
              cSUOMNM: result[i].cSUOMNM,
              cLUOMCD: '',
              cLUOMNM: '',
              cMUOMCD: '',
              cMUOMNM: '',
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
              cSUOMCD: '',
              cSUOMNM: '',
              cLUOMCD: '',
              cLUOMNM: '',
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
              cSUOMCD: '',
              cSUOMNM: '',
              cLUOMCD: result[i].cLUOMCD,
              cLUOMNM: result[i].cLUOMNM,
              cMUOMCD: '',
              cMUOMNM: '',
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

        for (int i = 0; i < podtList.length; i++) {
          GlobalParam.customerPODTList.add(podtList[i]);
        }
      } else {
        wrongDialog('$cPOCD ไม่พบประวัติการสั่งซื้อ');
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  wrongDialog(var msg) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('Information'),
        content: Text(
          '$msg',
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
