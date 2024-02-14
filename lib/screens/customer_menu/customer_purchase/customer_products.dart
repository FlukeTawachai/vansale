// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getProductStockReq.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/function/substring_price.dart';

class CustomerHistoryProduct extends StatefulWidget {
  //const CustomerHistory({ Key? key }) : super(key: key);
  final String typeMenuCode;
  CustomerHistoryProduct(this.typeMenuCode);
  @override
  _CustomerHistoryProductState createState() => _CustomerHistoryProductState();
}

class _CustomerHistoryProductState extends State<CustomerHistoryProduct> {
  // ignore: deprecated_member_use
  List<TextEditingController> incleaseCon = new List();
  // ignore: deprecated_member_use
  List<TextEditingController> decleaseCon = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GlobalParam.customerStockProductList = [];
    for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
      getProductStock(GetProductStockReq(
          cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
          cPRODCD: '%${GlobalParam.customerProductList[i].cPRODCD}%',
          cWH: '%FG%'));
    }
  }

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: GlobalParam.deliveryPodtShow.length,
                itemBuilder: (BuildContext context, int index) {
                  double unitPrice = 0.0;
                  double qty = 0.0;
                  double stock = 0.0;
                  String unitCode = '';
                  String unitName = '';
                  String size = '';
                  incleaseCon.add(new TextEditingController());
                  decleaseCon.add(new TextEditingController());
                  if (GlobalParam.deliveryPodtShow[index].iSSIZEQTY == '') {
                    GlobalParam.deliveryPodtShow[index].iSSIZEQTY = '0';
                  }
                  if (GlobalParam.deliveryPodtShow[index].iMSIZEQTY == '') {
                    GlobalParam.deliveryPodtShow[index].iMSIZEQTY = '0';
                  }
                  if (GlobalParam.deliveryPodtShow[index].iLSIZEQTY == '') {
                    GlobalParam.deliveryPodtShow[index].iLSIZEQTY = '0';
                  }
                  if (double.parse(
                          GlobalParam.deliveryPodtShow[index].iSSIZEQTY ??
                              '0') >
                      0) {
                    qty = double.parse(
                        GlobalParam.deliveryPodtShow[index].iSSIZEQTY ?? '0');
                    unitPrice = double.parse(
                        GlobalParam.deliveryPodtShow[index].iSUNITPRICE ?? '0');
                    unitName =
                        GlobalParam.deliveryPodtShow[index].cSUOMNM ?? '';
                    unitCode =
                        GlobalParam.deliveryPodtShow[index].cSUOMCD ?? '';
                    size = "S";
                  }
                  if (double.parse(
                          GlobalParam.deliveryPodtShow[index].iMSIZEQTY ??
                              '0') >
                      0) {
                    qty = double.parse(
                        GlobalParam.deliveryPodtShow[index].iMSIZEQTY ?? '0');
                    unitPrice = double.parse(
                        GlobalParam.deliveryPodtShow[index].iMUNITPRICE ?? '0');
                    unitName =
                        GlobalParam.deliveryPodtShow[index].cMUOMNM ?? '';
                    unitCode =
                        GlobalParam.deliveryPodtShow[index].cMUOMCD ?? '';
                    size = "M";
                  }
                  if (double.parse(
                          GlobalParam.deliveryPodtShow[index].iLSIZEQTY ??
                              '0') >
                      0) {
                    qty = double.parse(
                        GlobalParam.deliveryPodtShow[index].iLSIZEQTY ?? '0');
                    unitPrice = double.parse(
                        GlobalParam.deliveryPodtShow[index].iLUNITPRICE ?? '0');
                    unitName =
                        GlobalParam.deliveryPodtShow[index].cLUOMNM ?? '';
                    unitCode =
                        GlobalParam.deliveryPodtShow[index].cLUOMCD ?? '';
                    size = "L";
                  }

                  for (var item in GlobalParam.customerStockProductList) {
                    if (GlobalParam.deliveryPodtShow[index].cPRODCD ==
                        item.cPRODCD) {
                      if (item.cUOMCD == unitCode) {
                        stock = double.parse(item.iQTY ?? '0');
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
                          height: 110.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                width: 100.0,
                                height: 100.0,
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
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: 128,
                                                child: Text(
                                                  GlobalParam
                                                          .customerPODTList[
                                                              index]
                                                          .cPRODNM ??
                                                      '',
                                                  style: const TextStyle(
                                                      fontFamily: 'Prompt',
                                                      fontSize: 18),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: IconButton(
                                                icon: const Icon(
                                                  LineAwesomeIcons.trash,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    incleaseCon[index].text =
                                                        0.toString();
                                                    decleaseCon[index].text =
                                                        0.toString();
                                                  });
                                                },
                                                iconSize: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //--------------------2
                                      Expanded(
                                        child: Container(
                                          // width: 128,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "สต็อก ${stock.toStringAsFixed(0)} ${unitName}",
                                            style: const TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 14,
                                                color: Colors.green),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      //--------------------3
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: 80.0,
                                                // padding: const EdgeInsets.all(5.0),
                                                alignment: Alignment.centerLeft,
                                                child: const Center(
                                                  child: Text(
                                                    "ยอดสั่งซื้อ",
                                                    style: TextStyle(
                                                        fontFamily: 'Prompt',
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: 80.0,
                                                alignment: Alignment.centerLeft,
                                                child: const Center(
                                                  child: Text(
                                                    "ลด",
                                                    style: TextStyle(
                                                        fontFamily: 'Prompt',
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: 80.0,
                                                alignment: Alignment.centerLeft,
                                                child: const Center(
                                                  child: Text(
                                                    "เพิ่ม",
                                                    style: TextStyle(
                                                        fontFamily: 'Prompt',
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Expanded(
                                            //   child: Container(
                                            //     alignment: Alignment.centerLeft,
                                            //     child: Text(
                                            //       "คงค้าง",
                                            //       style: TextStyle(
                                            //           fontFamily: 'Prompt',
                                            //           color: Colors.blue),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      //----------------------------4
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // ----------------------5
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                height: 30.0,
                                                width: 80.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade400,
                                                    borderRadius:
                                                        const BorderRadius.only(
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
                                                        color: Colors.grey)),
                                                child: Center(
                                                  child: Text(
                                                      '${qty.toStringAsFixed(0)}',
                                                      style: const TextStyle(
                                                          fontFamily: 'Prompt',
                                                          fontSize: 16)),
                                                ),
                                              ),
                                            ),
                                            // -------------2
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                height: 30.0,
                                                width: 80.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.only(
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
                                                        color: Colors.grey)),
                                                child: Center(
                                                  child: TextFormField(
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.red),
                                                    controller:
                                                        incleaseCon[index],
                                                    onChanged: (value) {
                                                      if (value != '' &&
                                                          value != null) {
                                                        decleaseProductOrder(
                                                            size,
                                                            double.parse(value),
                                                            GlobalParam
                                                                    .customerPODTList[
                                                                index]);
                                                      }
                                                    },
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
                                                      // contentPadding: EdgeInsets.only(
                                                      //     left: 15,
                                                      //     bottom: 11,
                                                      //     top: 15,
                                                      //     right: 15),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // -------------3
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                height: 30.0,
                                                width: 80.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.only(
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
                                                        color: Colors.grey)),
                                                child: Center(
                                                  child: TextField(
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.green),
                                                    controller:
                                                        decleaseCon[index],
                                                    onChanged: (value) {
                                                      if (value != '' &&
                                                          value != null) {
                                                        incleaseProductOrder(
                                                            size,
                                                            double.parse(value),
                                                            GlobalParam
                                                                    .customerPODTList[
                                                                index]);
                                                      }
                                                    },
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
                                                      // contentPadding: EdgeInsets.only(
                                                      //     left: 15,
                                                      //     bottom: 11,
                                                      //     top: 15,
                                                      //     right: 15),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // ----------------------------------------------------------------4
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
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Prompt',
                                  ),
                                ),
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  width: 150.0,
                                  child: SubstringPrice(
                                    '$unitPrice',
                                    14.0,
                                    12.0,
                                    Colors.black,
                                    Colors.black,
                                    'Prompt',
                                    'Prompt',
                                    FontWeight.bold,
                                    FontWeight.bold,
                                    '฿',
                                    12.0,
                                    Colors.black,
                                    'Prompt',
                                    FontWeight.bold,
                                    FontStyle.normal,
                                    FontStyle.normal,
                                    FontStyle.normal,
                                  )),
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Colors.grey,
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  getProductStock(GetProductStockReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var result = await proxy.getProductStock(req);

      if (result.isNotEmpty) {
        for (int i = 0; i < result.length; i++) {
          GlobalParam.customerStockProductList.add(result[i]);
        }
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

  incleaseProductOrder(String size, double value, QueryPodtResp product) {
    double inclease = 0;

    if (value > 0) {
      inclease = value;
    }

    if (size == "L") {
      for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
        if (GlobalParam.customerProductList[i].cPOCD ==
            GlobalParam.customerPOHDSelect!.cPOCD) {
          if (GlobalParam.customerProductList[i].cPRODCD == product.cPRODCD) {
            double sum = double.parse(
                    GlobalParam.customerProductList[i].iLSIZEQTY ?? '0') +
                inclease;
            GlobalParam.customerProductList[i].iLSIZEQTY =
                sum.toStringAsFixed(0);
          }
        }
      }

      for (var i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
        if (GlobalParam.deliveryPodtList[i].cPRODCD == product.cPRODCD) {
          if (GlobalParam.deliveryPodtList[i].cLUOMCD != '') {
            double sum =
                double.parse(GlobalParam.deliveryPodtList[i].iLSIZEQTY ?? '0') +
                    inclease;
            GlobalParam.deliveryPodtList[i].iLSIZEQTY = sum.toStringAsFixed(0);
          }
        }
      }
    }

    if (size == "M") {
      for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
        if (GlobalParam.customerProductList[i].cPOCD ==
            GlobalParam.customerPOHDSelect!.cPOCD) {
          if (GlobalParam.customerProductList[i].cPRODCD == product.cPRODCD) {
            double sum = double.parse(
                    GlobalParam.customerProductList[i].iMSIZEQTY ?? '0') +
                inclease;
            GlobalParam.customerProductList[i].iMSIZEQTY =
                sum.toStringAsFixed(0);
          }
        }
      }

      for (var i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
        if (GlobalParam.deliveryPodtList[i].cPRODCD == product.cPRODCD) {
          if (GlobalParam.deliveryPodtList[i].cMUOMCD != '') {
            double sum =
                double.parse(GlobalParam.deliveryPodtList[i].iMSIZEQTY ?? '0') +
                    inclease;
            GlobalParam.deliveryPodtList[i].iMSIZEQTY = sum.toStringAsFixed(0);
          }
        }
      }
    }

    if (size == "S") {
      for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
        if (GlobalParam.customerProductList[i].cPOCD ==
            GlobalParam.customerPOHDSelect!.cPOCD) {
          if (GlobalParam.customerProductList[i].cPRODCD == product.cPRODCD) {
            double sum = double.parse(
                    GlobalParam.customerProductList[i].iSSIZEQTY ?? '0') +
                inclease;
            GlobalParam.customerProductList[i].iSSIZEQTY =
                sum.toStringAsFixed(0);
          }
        }
      }

      for (var i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
        if (GlobalParam.deliveryPodtList[i].cPRODCD == product.cPRODCD) {
          if (GlobalParam.deliveryPodtList[i].cSUOMCD != '') {
            double sum =
                double.parse(GlobalParam.deliveryPodtList[i].iSSIZEQTY ?? '0') +
                    inclease;
            GlobalParam.deliveryPodtList[i].iSSIZEQTY = sum.toStringAsFixed(0);
          }
        }
      }
    }
  }

  decleaseProductOrder(String size, double value, QueryPodtResp product) {
    double declease = 0;

    if (value > 0) {
      declease = value;
    }

    if (size == "L") {
      for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
        if (GlobalParam.customerProductList[i].cPRODCD == product.cPRODCD) {
          double sum = double.parse(
                  GlobalParam.customerProductList[i].iLSIZEQTY ?? '0') -
              declease;
          GlobalParam.customerProductList[i].iLSIZEQTY = '$sum';
        }
      }
    }

    if (size == "M") {
      for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
        if (GlobalParam.customerProductList[i].cPRODCD == product.cPRODCD) {
          double sum = double.parse(
                  GlobalParam.customerProductList[i].iMSIZEQTY ?? '0') -
              declease;
          GlobalParam.customerProductList[i].iMSIZEQTY = '$sum';
        }
      }
    }

    if (size == "S") {
      for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
        if (GlobalParam.customerProductList[i].cPRODCD == product.cPRODCD) {
          double sum = double.parse(
                  GlobalParam.customerProductList[i].iSSIZEQTY ?? '0') -
              declease;
          GlobalParam.customerProductList[i].iSSIZEQTY = '$sum';
        }
      }
    }
  }
}
