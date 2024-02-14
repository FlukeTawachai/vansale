import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/queryPodtReq.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';

class Warehouse3ListProduct extends StatefulWidget {
  get mode => null;
  final bool isCheck;
  final String pocd;

  const Warehouse3ListProduct({Key key, this.isCheck, this.pocd})
      : super(key: key);

  @override
  State<Warehouse3ListProduct> createState() => _Warehouse3ListProductState();
}

class _Warehouse3ListProductState extends State<Warehouse3ListProduct> {
  List<QueryPodtResp> podtList = [];
  List<QueryPodtResp> podtListNstatus = [];
  double widthScreen = 0;

  @override
  void initState() {
    getPodt(widget.pocd);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formatNum = new NumberFormat("#,###", "en_US");
    widthScreen = MediaQuery.of(context).size.width;
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: podtList.length,
      itemBuilder: (BuildContext context, int index) {
        var unitNM = '';
        if (double.parse(podtList[index].iSSIZEQTY) != 0) {
          unitNM = podtList[index].cSUOMNM;
        }
        if (double.parse(podtList[index].iMSIZEQTY) != 0) {
          unitNM = podtList[index].cMUOMNM;
        }
        if (double.parse(podtList[index].iLSIZEQTY) != 0) {
          unitNM = podtList[index].cLUOMNM;
        }
        double totalItem = double.parse(podtList[index].iSSIZEQTY) +
            double.parse(podtList[index].iMSIZEQTY) +
            double.parse(podtList[index].iLSIZEQTY);

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
                      width: 100.0,
                      height: 150.0,
                      margin: const EdgeInsets.all(5.0),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        image: DecorationImage(
                          image: podtList[index].cPHOTOSERV == '' ||
                                  podtList[index].cPHOTOPATH == ''
                              ? new AssetImage(
                                  // order[index]['image'],
                                  "assets/images/no_image.png",
                                )
                              : NetworkImage(
                                  'http://${podtList[index].cPHOTOSERV}/${podtList[index].cPHOTOPATH}'),
                          scale: 3.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //----------------------1
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        (index + 1).toString() +
                                            "." +
                                            podtList[index].cPRODNM,
                                        style: TextStyle(
                                            fontFamily: 'Prompt',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  /*Container(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {},
                                      iconSize: 30.0,
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                            //--------------------2
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: widthScreen * 0.4,
                                    padding: const EdgeInsets.all(5.0),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Text(
                                          'จำนวน',
                                          style: TextStyle(
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (podtList[index].cPREPAIRSTATUS ==
                                          'N') {
                                        setState(() {
                                          // print(
                                          //     '======================== update cPREPAIRSTATUS ========================');
                                          updatePodtTable(
                                              podtList[index].cPOCD,
                                              podtList[index].iSEQ,
                                              'Y',
                                              double.parse(
                                                  podtList[index].iTOTAL));
                                        });
                                      } else {
                                        setState(() {
                                          // print(
                                          //     '======================== update cPREPAIRSTATUS ========================');
                                          updatePodtTable(podtList[index].cPOCD,
                                              podtList[index].iSEQ, 'N', 0.00);
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: widthScreen * 0.2,
                                      alignment: Alignment.center,
                                      child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 5.0, right: 5.0),
                                          height: 30.0,
                                          width: 80.0,
                                          decoration: BoxDecoration(
                                            // color: Colors.green,
                                            border:
                                                Border.all(color: Colors.green),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5),
                                            ),
                                          ),
                                          child: Center(
                                              child: Text("จัดแล้ว",
                                                  style: TextStyle(
                                                      color: Colors.green)))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //--------------------3
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Center(
                                    child: Text(
                                        // "${widget.podtList[index].iSSIZEQTY}")
                                        "${formatNum.format(totalItem)} $unitNM"),
                                  )),
                                  Container()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
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
              sumItem += double.parse(result[i].iSSIZEQTY) +
                  double.parse(result[i].iMSIZEQTY) +
                  double.parse(result[i].iLSIZEQTY);
              podtList.add(result[i]);
              if (result[i].cPREPAIRSTATUS == 'N') {
                podtListNstatus.add(result[i]);
              }
            }
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

  updatePodtTable(
    String cPOCD,
    int iSEQ,
    String cPREPAIRSTATUS,
    double iPREPAIRAMOUT,
  ) async {
    if (cPOCD != '') {
      if (cPOCD != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result = await proxy.updatePodt(
            cPOCD,
            iSEQ,
            cPREPAIRSTATUS,
            iPREPAIRAMOUT,
          );
          if (result.success == true) {
            print('${result.success}\n${result.message}\n${result.result}');
          } else {
            print('${result.success}\n${result.message}\n${result.result}');
          }
        } on SocketException catch (e) {
          wrongDialog(e.message);
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
        getPodt(widget.pocd);
        setState(() {});
      }
    } else {
      wrongDialog("custcd is null.");
    }
  }
}
