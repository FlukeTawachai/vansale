// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/queryPodtReq.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/function/substring_price.dart';

class DeliveryStoreShippingList extends StatefulWidget {
  @override
  State<DeliveryStoreShippingList> createState() =>
      _DeliveryStoreShippingListState();
}

class _DeliveryStoreShippingListState extends State<DeliveryStoreShippingList> {
  List<QueryPodtResp> podtList = [];
  List<QueryPodtResp> podtListNstatus = [];
  List<PoHDAndPoDTResp> productList = [];
  var unitList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPodt(GlobalParam.deliveryStoreSum.cPOCD!);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: podtList.length,
      itemBuilder: (BuildContext context, int index) {
        double item = double.parse(podtList[index].iSSIZEQTY!) +
            double.parse(podtList[index].iMSIZEQTY!) +
            double.parse(podtList[index].iLSIZEQTY!);
        var unit = '';
        if (double.parse(podtList[index].iSSIZEQTY!) > 0) {
          unit = podtList[index].cSUOMNM!;
        }
        if (double.parse(podtList[index].iMSIZEQTY!) > 0) {
          unit = podtList[index].cMUOMNM!;
        }
        if (double.parse(podtList[index].iLSIZEQTY!) > 0) {
          unit = podtList[index].cLUOMNM!;
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
                          image: podtList[index].cPHOTOPATH != ''
                              ? DecorationImage(
                                  image: NetworkImage(
                                    'http://${podtList[index].cPHOTOSERV}/${podtList[index].cPHOTOPATH}',
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
                              podtList[index].cPRODNM!,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: item > 0
                                            ? Text(
                                                '${item.toStringAsFixed(0)} $unit',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Prompt',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0),
                                              )
                                            : const Text(
                                                '0 ตะกร้า',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Prompt',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0),
                                              ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          podtList[index].cPRODCD!,
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
                              SizedBox(
                                width: 100.0,
                                child: SubstringPrice(
                                  podtList[index].iTOTAL,
                                  16.0,
                                  14.0,
                                  Colors.black,
                                  Colors.black,
                                  'Prompt',
                                  'Prompt',
                                  FontWeight.bold,
                                  FontWeight.bold,
                                  '฿',
                                  14.0,
                                  Colors.black,
                                  'Prompt',
                                  FontWeight.bold,
                                  FontStyle.normal,
                                  FontStyle.normal,
                                  FontStyle.normal,
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
    );
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

  getPodt(String cPOCD) async {
    double sumItem = 0;
    if (cPOCD != '') {
      if (cPOCD != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result = await proxy.getPodt(QueryPodtReq(
              cPOCD: cPOCD,
              cPRODCD: '%%',
              cPRODNM: '%%',
              cCUSTTYPE: GlobalParam.customer['cCUSTTYPE']));
          if (result.isNotEmpty) {
            //  print('+++++++++++++++++++ query TBT_PODT success +++++++++++++++++++');
            podtList.clear();
            for (int i = 0; i < result.length; i++) {
              sumItem += double.parse(result[i].iSSIZEQTY!) +
                  double.parse(result[i].iMSIZEQTY!) +
                  double.parse(result[i].iLSIZEQTY!);

              if (double.parse(result[i].iSSIZEQTY!) > 0) {
                var data = {
                  "cPRODCD": result[i].cPRODCD,
                  "cUOMNM": result[i].cSUOMNM,
                  "iPRICE": double.parse(result[i].iSUNITPRICE!),
                  "iTOTAL": double.parse(result[i].iSSIZEQTY!)
                };
                unitList.add(data);
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
                  iCANCLEPRO: result[i].iCANCLEPRO ?? 0,
                  iDISCOUNT: result[i].iDISCOUNT,
                  iFREE: result[i].iFREE,
                  iINCOMPRO: result[i].iCANCLEPRO ?? 0,
                  iLOSSPRO: result[i].iCANCLEPRO ?? 0,
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
                  "cUOMNM": result[i].cMUOMNM,
                  "iPRICE": double.parse(result[i].iMUNITPRICE!),
                  "iTOTAL": double.parse(result[i].iMSIZEQTY!)
                };
                unitList.add(data);
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
                  iCANCLEPRO: result[i].iCANCLEPRO ?? 0,
                  iDISCOUNT: result[i].iDISCOUNT,
                  iFREE: result[i].iFREE,
                  iINCOMPRO: result[i].iCANCLEPRO ?? 0,
                  iLOSSPRO: result[i].iCANCLEPRO ?? 0,
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
                  "cUOMNM": result[i].cLUOMNM,
                  "iPRICE": double.parse(result[i].iLUNITPRICE!),
                  "iTOTAL": double.parse(result[i].iLSIZEQTY!)
                };
                unitList.add(data);
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
                  iCANCLEPRO: result[i].iCANCLEPRO ?? 0,
                  iDISCOUNT: result[i].iDISCOUNT,
                  iFREE: result[i].iFREE,
                  iINCOMPRO: result[i].iCANCLEPRO ?? 0,
                  iLOSSPRO: result[i].iCANCLEPRO ?? 0,
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
            GlobalParam.deliveryPodtList = podtList;
            GlobalParam.deliveryPodtShow = podtList;
            GlobalParam.deliveryUnitList = unitList;
            getBasketsofCustomer(GlobalParam.deliverySelectStore.cCUSTCD!,
                GlobalParam.deliveryStoreSum.cPOCD!);
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

  getBasketsofCustomer(String custcd, String pocd) async {
    if (custcd != '') {
      if (custcd != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result = await proxy.getBaskets(custcd, pocd, '%%', '%%');
          if ((result.isNotEmpty)) {
            // print("+++++++++++++++++ ${result.cPOCD} +++++++++++++++++");
            setState(() {
              productList = result;
              GlobalParam.deliveryProductList = result;
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
}
