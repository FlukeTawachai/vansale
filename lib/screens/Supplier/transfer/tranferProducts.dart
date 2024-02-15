import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/deliveryPO.dart';
import 'package:vansale/api/class/response/routeMobile/pocdResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';

class TranferProducts extends StatefulWidget {
  final String? typeMenuCode;
  const TranferProducts({
    Key? key,
    this.typeMenuCode,
  }) : super(key: key);

  @override
  State<TranferProducts> createState() => _TranferProductsState();
}

class _TranferProductsState extends State<TranferProducts> {
  DateTime dateNow = DateTime.now();
  List<RouteCusResp> routeCusList = [];
  List<PocdResp> pocdResp = [];
  var stores = [
    {'name': 'ร้านที่ 01', 'status': false, 'no': 1},
    {'name': 'ร้านที่ 0222222', 'status': false, 'no': 2},
    {'name': 'ร้านที่ 03333333333', 'status': false, 'no': 3},
    {'name': 'ร้านที่ 04444444444444444', 'status': false, 'no': 4},
    {'name': 'ร้านที่ 0555555555555555555555', 'status': false, 'no': 5},
    {'name': 'ร้านที่ 0666666666666666666666666666', 'status': false, 'no': 6},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRouteTransfers();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0.0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            'ขึ้นสินค้า',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Prompt',
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '${routeCusList.length} ร้าน',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Prompt',
                    ),
                  )),
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              Row(children: [
                Container(
                    width: widthScreen * 0.2,
                    child: Center(
                        child: Text('ลำดับ', style: TextStyle(fontSize: 16)))),
                Container(
                    width: widthScreen * 0.7,
                    child: Center(
                        child:
                            Text('ชื่อร้าน', style: TextStyle(fontSize: 16))))
              ]),
              Divider(color: Colors.black),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: routeCusList.length,
                  itemBuilder: (context, index) {
                    return routeCusList[index].cPOSTATUS == '2'
                        ? ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                              child: Text('${routeCusList[index].iSEQROUTE}',
                                  textAlign: TextAlign.center),
                            ),
                            title: AutoSizeText(
                              routeCusList[index].cCUSTNM!,
                              style: TextStyle(fontSize: 16),
                              minFontSize: 12,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // Text('${stores[index]['name']}'),
                            trailing: InkWell(
                              onTap: () {
                                confirmDialog(
                                    'ขึ้นสินค้าของ "${routeCusList[index].cCUSTNM}" เรียบร้อยแล้ว',
                                    index);
                              },
                              child: Container(
                                  height: 48.0,
                                  width: 64.0,
                                  decoration: BoxDecoration(
                                    // color: Colors.green,
                                    border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text("รอขึ้น",
                                          style:
                                              TextStyle(color: Colors.red)))),
                            ),
                          )
                        : Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  confirmDialog(String msg, int index) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('ยืนยันขึ้นแล้ว'),
        content: Text(msg, style: TextStyle(fontSize: 16)),
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
                    Navigator.pop(context, 'ยกเลิก');
                  },
                  child:
                      const Text('ยกเลิก', style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: () {
                    for (int i = 0; i < pocdResp.length; i++) {
                      if (routeCusList[index].cCUSTCD == pocdResp[i].cCUSTCD) {
                        deliveryPO(DeliveryPOReq(
                            cPOCD: pocdResp[i].cPOCD,
                            cUPDABY: GlobalParam.userID));
                        setState(() {
                          routeCusList.removeAt(index);
                        });
                      }
                    }

                    Navigator.pop(context, 'ยืนยัน');
                  },
                  child: const Text('ยืนยัน',
                      style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getRouteTransfers() async {
    if (GlobalParam.deliveryRouteToday['cRTECD'] != '') {
      try {
        AllApiProxyMobile proxy = AllApiProxyMobile();

        var outputFormat = DateFormat('yyyy-MM-dd');
        var outputDate = outputFormat.format(new DateTime.now());
        // print(outputDate);

        var result = await proxy.getRouteTransfer(
            GlobalParam.deliveryRouteToday['cRTECD']!,
            '2022-09-15',
            GlobalParam.deliveryRouteToday['cGRPCD']!,
            GlobalParam.deliveryRouteToday['cBRANCD']!,true);
        if (result.isNotEmpty) {
          routeCusList.clear();
          GlobalParam.deliveryListStores.clear();

          for (int i = 0; i < result.length; i++) {
            if (result[i].cPOSTATUS == "2" &&
                result[i].cPREPAIRCFSTATUS == 'Y') {
              routeCusList.add(result[i]);
            }

            // GlobalParam.deliveryListStores.add(result[i]);
            // if (result[i].cPOSTATUS == '4') {
            // } else {
            //   if (result[i].cPREPAIRCFSTATUS == 'Y') {}
            // }
            // print(result[i].cADDRESS);
          }

          for (int i = 0; i < routeCusList.length; i++) {
            getPocdOfcustomer(routeCusList[i].cCUSTCD!);
          }

          setState(() {});
        } else {
          routeCusList.clear();
        }
      } on SocketException catch (e) {
        wrongDialog(e.message);
      } on Exception catch (e) {
        wrongDialog(e.toString());
      }
    } else {
      wrongDialog('กรุณาระบุชื่อสาย');
    }
  }

  getPocdOfcustomer(String custcd) async {
    if (custcd != '') {
      if (custcd != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();
          var outputFormat = DateFormat('yyyy-MM-dd');
          var outputDate = outputFormat.format(new DateTime.now());
          // print(outputDate);

          var result = await proxy.getPocd(custcd, "2022-09-15");
          if ((result.cPOCD != '')) {
            // print("+++++++++++++++++ ${result.cPOCD} +++++++++++++++++");
            setState(() {
              pocdResp.add(result);
            });
          } else {
            // print("+++++++++++++++++ null +++++++++++++++++");
            setState(() {
              pocdResp[0] = PocdResp(
                  cCUSTCD: custcd, cPOCD: '', dPODATE: '', dSHIPDATE: '');
            });
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
  }

  deliveryPO(DeliveryPOReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.deliveryPO(req);
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
