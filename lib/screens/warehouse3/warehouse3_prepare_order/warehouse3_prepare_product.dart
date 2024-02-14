import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/queryPodtReq.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/screens/home/home.dart';

class WarehousePrepareProduct extends StatefulWidget {
  //const WarehousePrepareProduct({ Key? key }) : super(key: key);
  final String typeMenuCode;
  final bool wholesaleStore;
  final String pocd;
  WarehousePrepareProduct(this.typeMenuCode, this.wholesaleStore, this.pocd);

  @override
  State<WarehousePrepareProduct> createState() =>
      _WarehousePrepareProductState();
}

class _WarehousePrepareProductState extends State<WarehousePrepareProduct> {
  bool isFilter = false;
  List<QueryPodtResp> podtList = [];
  List<QueryPodtResp> podtListNstatus = [];
  List<QueryPodtResp> listOfPodt = [];
  int listProductTotal = 0;
  double listProductItem = 0;
  int listProductYstatus = 0;
  TextEditingController basket = TextEditingController();
  double numBasket = 0;
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

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              'จัดสินค้า',
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'กลุ่ม 2',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Prompt',
                      ),
                    )),
              )
            ]),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                      child: ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: listOfPodt.length,
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
                  double totalItem = double.parse(listOfPodt[index].iSSIZEQTY) +
                      double.parse(listOfPodt[index].iMSIZEQTY) +
                      double.parse(listOfPodt[index].iLSIZEQTY);

                  int count_column = 0;
                  if (double.parse(listOfPodt[index].iLSIZEQTY) > 0) {
                    count_column++;
                  }
                  if (double.parse(listOfPodt[index].iMSIZEQTY) > 0) {
                    count_column++;
                  }
                  if (double.parse(listOfPodt[index].iSSIZEQTY) > 0) {
                    count_column++;
                  }
                  // print(
                  //     '---------------------- ${listOfPodt[0].cPREPAIRSTATUS} ----------------------');

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
                                    image: listOfPodt[index].cPHOTOSERV == '' ||
                                            listOfPodt[index].cPHOTOPATH == ''
                                        ? new AssetImage(
                                            // order[index]['image'],
                                            "assets/images/no_image.png",
                                          )
                                        : NetworkImage(
                                            'http://${listOfPodt[index].cPHOTOSERV}/${listOfPodt[index].cPHOTOPATH}'),
                                    scale: 3.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.only(
                                  left: 5.0,
                                  right: 5.0,
                                  top: 7,
                                  bottom: 7,
                                ),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        (index + 1).toString() +
                                            "." +
                                            listOfPodt[index].cPRODNM,
                                        style: TextStyle(
                                          fontFamily: 'Prompt',
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: widthScreen * 0.4,
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              double.parse(listOfPodt[index]
                                                          .iLSIZEQTY) >
                                                      0
                                                  ? Container(
                                                      width: widthScreen *
                                                          (0.4 / count_column),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: AutoSizeText(
                                                        listOfPodt[index]
                                                            .cLUOMNM,
                                                        maxLines: 1,
                                                        maxFontSize: 16,
                                                        minFontSize: 10,
                                                        style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(height: 0),
                                              double.parse(listOfPodt[index]
                                                          .iMSIZEQTY) >
                                                      0
                                                  ? Container(
                                                      width: widthScreen *
                                                          (0.4 / count_column),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: AutoSizeText(
                                                        listOfPodt[index]
                                                            .cMUOMNM,
                                                        maxLines: 1,
                                                        maxFontSize: 16,
                                                        minFontSize: 10,
                                                        style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(height: 0),
                                              double.parse(listOfPodt[index]
                                                          .iSSIZEQTY) >
                                                      0
                                                  ? Container(
                                                      width: widthScreen *
                                                          (0.4 / count_column),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: AutoSizeText(
                                                        listOfPodt[index]
                                                            .cSUOMNM,
                                                        maxLines: 1,
                                                        maxFontSize: 16,
                                                        minFontSize: 10,
                                                        style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(height: 0),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: widthScreen * 0.3,
                                            alignment: Alignment.center,
                                            child: listOfPodt[index].cPREPAIRSTATUS ==
                                                        'N' ||
                                                    listOfPodt[index]
                                                            .cPREPAIRSTATUS ==
                                                        '' ||
                                                    listOfPodt[index]
                                                            .cPREPAIRSTATUS ==
                                                        null
                                                ? Container(
                                                    height: 30.0,
                                                    width: widthScreen * 0.3,
                                                    child: InkWell(
                                                      onTap: () {
                                                        confirmDialog(
                                                            "ยืนยัน ${listOfPodt[index].cPRODNM} จัดแล้ว",
                                                            listOfPodt[index]);
                                                      },
                                                      child: Container(
                                                        width:
                                                            widthScreen * 0.3,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5.0,
                                                                  right: 5.0),
                                                          height: 30.0,
                                                          width: 80.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: Colors.green,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .green),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomLeft: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                          ),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            child: Center(
                                                              child:
                                                                  AutoSizeText(
                                                                "จัดแล้ว",
                                                                maxLines: 1,
                                                                maxFontSize: 16,
                                                                minFontSize: 10,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 30.0,
                                                    width: widthScreen * 0.3,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: widthScreen * 0.4,
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              double.parse(listOfPodt[index]
                                                          .iLSIZEQTY) >
                                                      0
                                                  ? Container(
                                                      width: widthScreen *
                                                          (0.4 / count_column),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: AutoSizeText(
                                                        double.parse(listOfPodt[
                                                                    index]
                                                                .iLSIZEQTY)
                                                            .toStringAsFixed(0),
                                                        maxLines: 1,
                                                        maxFontSize: 16,
                                                        minFontSize: 10,
                                                        style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              double.parse(listOfPodt[index]
                                                          .iMSIZEQTY) >
                                                      0
                                                  ? Container(
                                                      width: widthScreen *
                                                          (0.4 / count_column),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: AutoSizeText(
                                                        double.parse(listOfPodt[
                                                                    index]
                                                                .iMSIZEQTY)
                                                            .toStringAsFixed(0),
                                                        maxLines: 1,
                                                        maxFontSize: 16,
                                                        minFontSize: 10,
                                                        style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              double.parse(listOfPodt[index]
                                                          .iSSIZEQTY) >
                                                      0
                                                  ? Container(
                                                      width: widthScreen *
                                                          (0.4 / count_column),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: AutoSizeText(
                                                        double.parse(listOfPodt[
                                                                    index]
                                                                .iSSIZEQTY)
                                                            .toStringAsFixed(0),
                                                        maxLines: 1,
                                                        maxFontSize: 16,
                                                        minFontSize: 10,
                                                        style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: widthScreen * 0.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
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
              )
                      // Warehouse3ListProduct(isCheck: isCheck, pocd: widget.pocd),
                      )),
              Container(
                color: Colors.white,
                height: 160.0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Text(
                                  '${listProductTotal} รายการ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'รายละเอียด',
                                          style: TextStyle(
                                              fontFamily: 'Prompt',
                                              fontSize: 16),
                                        ),
                                        content: setupAlertDialoadContainer(
                                            GlobalParam.deliveryUnitList,
                                            widthScreen),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  },
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                width: widthScreen * 0.4,
                                height: 24,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'แสดงรายละเอียด',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Prompt',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //------------------------
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'จัดแล้ว: $listProductYstatus รายการ',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'รอจัด: ${listProductTotal - listProductYstatus} รายการ',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //-------------------------------
                      widget.wholesaleStore == true
                          ? Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 30.0,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'กรอกจำนวนตะกร้า:',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 5.0, right: 16.0),
                                      height: 30.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                          ),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: TextFormField(
                                        // controller: basket,
                                        onChanged: (value) {
                                          if ((value != '') &&
                                              (value != null)) {
                                            setState(() {
                                              numBasket = double.parse(value);
                                            });
                                          } else {
                                            setState(() {
                                              numBasket = 0;
                                            });
                                          }
                                        },
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        initialValue: '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: HexColor('#00cb39'),
                                          fontFamily: 'Prompt',
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          // contentPadding: EdgeInsets.only(
                                          //     left: 15,
                                          //     bottom: 0,
                                          //     top: 0,
                                          //     right: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(height: 24),
                      //-------------------------------
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 0.0,
                                child: InkWell(
                                  onTap: () {
                                    // confirmDialog("พิมพ์ใบสั่งซื้อแล้ว");
                                    updatePohdTable(
                                      widget.pocd,
                                      'Y',
                                      numBasket,
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(LineAwesomeIcons.boxes,
                                            color: Colors.green),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 8, 0),
                                          child: Text(
                                            'ยืนยันจัดแล้ว',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                elevation: 0.0,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isFilter = !isFilter;
                                      // print(
                                      //     '00000000000000000 $isFilter 00000000000000000');

                                      if (isFilter == true) {
                                        listOfPodt = podtListNstatus;
                                      } else {
                                        listOfPodt = podtList;
                                      }
                                      // print(
                                      //     '---------------------- ${listOfPodt[0].cPREPAIRSTATUS} ----------------------');
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(LineAwesomeIcons.truck_loading,
                                          color: Colors.red),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'สินค้ารอจัด',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  confirmDialog(String msg, QueryPodtResp listOfPodt) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('ยืนยันจัดแล้ว'),
        content: Text(
          msg,
          style: const TextStyle(fontSize: 16.0),
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
                    Navigator.pop(context);
                  },
                  child:
                      const Text('ยกเลิก', style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: () {
                    if (listOfPodt.cPREPAIRSTATUS == 'N' ||
                        listOfPodt.cPREPAIRSTATUS == '' ||
                        listOfPodt.cPREPAIRSTATUS == null) {
                      setState(() {
                        // print(
                        //     '======================== update cPREPAIRSTATUS ========================');
                        updatePodtTable(listOfPodt.cPOCD, listOfPodt.iSEQ, 'Y',
                            double.parse(listOfPodt.iTOTAL));
                      });
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        // print(
                        //     '======================== update cPREPAIRSTATUS ========================');
                        updatePodtTable(
                            listOfPodt.cPOCD, listOfPodt.iSEQ, 'N', 0.00);
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    'ยืนยัน',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
            var unitList = [];
            //  print('+++++++++++++++++++ query TBT_PODT success +++++++++++++++++++');
            podtList.clear();
            podtListNstatus.clear();
            for (int i = 0; i < result.length; i++) {
              print(result[i].cPREPAIRSTATUS);
              sumItem += double.parse(result[i].iSSIZEQTY) +
                  double.parse(result[i].iMSIZEQTY) +
                  double.parse(result[i].iLSIZEQTY);
              podtList.add(result[i]);
              if (result[i].cPREPAIRSTATUS == 'N' ||
                  result[i].cPREPAIRSTATUS == null) {
                podtListNstatus.add(result[i]);
              }
            }

            for (int i = 0; i < result.length; i++) {
              sumItem += double.parse(result[i].iSSIZEQTY) +
                  double.parse(result[i].iMSIZEQTY) +
                  double.parse(result[i].iLSIZEQTY);

              if (double.parse(result[i].iSSIZEQTY) != 0.0) {
                var data = {
                  "cUOMNM": result[i].cSUOMNM,
                  "iPRICE": double.parse(result[i].iSUNITPRICE),
                  "iTOTAL": double.parse(result[i].iSSIZEQTY)
                };
                unitList.add(data);
              } else if (double.parse(result[i].iMSIZEQTY) != 0.0) {
                var data = {
                  "cUOMNM": result[i].cMUOMNM,
                  "iPRICE": double.parse(result[i].iMUNITPRICE),
                  "iTOTAL": double.parse(result[i].iMSIZEQTY)
                };
                unitList.add(data);
              } else if (double.parse(result[i].iLSIZEQTY) != 0.0) {
                var data = {
                  "cUOMNM": result[i].cLUOMNM,
                  "iPRICE": double.parse(result[i].iLUNITPRICE),
                  "iTOTAL": double.parse(result[i].iLSIZEQTY)
                };
                unitList.add(data);
              } else {
                var data = {
                  "cUOMNM": '',
                  "iPRICE": '0.0',
                  "iTOTAL": '0.0',
                };
                unitList.add(data);
              }
            }

            GlobalParam.deliveryUnitList = unitList;
          } else {
            // print('+++++++++++++++++++ query TBT_PODT fail +++++++++++++++++++');
            podtList.clear();
          }
        } on SocketException catch (e) {
          wrongDialog('${e.message}');
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
        if (isFilter == false) {
          listOfPodt = podtList;
        } else {
          listOfPodt = podtListNstatus;
        }

        listProductTotal = podtList.length;
        listProductItem = sumItem;
        listProductYstatus = podtList.length - podtListNstatus.length;
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
            print(
                'success: ${result.success}\nmessage: ${result.message}\nresult: ${result.result}');
          } else {
            print(
                'success: ${result.success}\nmessage: ${result.message}\nresult: ${result.result}');
          }
        } on SocketException catch (e) {
          wrongDialog("${e.message}");
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
        getPodt(widget.pocd);
        setState(() {});
      }
    } else {
      wrongDialog("cPOCD is null.");
    }
  }

  updatePohdTable(
    String cPOCD,
    String cPREPAIRCFSTATUS,
    double iBASKETTOTAL,
  ) async {
    if (cPOCD != '') {
      if (cPOCD != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result =
              await proxy.updatePohd(cPOCD, cPREPAIRCFSTATUS, iBASKETTOTAL);
          if (result.success == true) {
            print(
                'success: ${result.success}\nmessage: ${result.message}\nresult: ${result.result}');
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => HomePage(GlobalParam.typeMenuCode)),
                (Route<dynamic> route) => false);
          } else {
            print(
                'success: ${result.success}\nmessage: ${result.message}\nresult: ${result.result}');
          }
        } on SocketException catch (e) {
          wrongDialog("${e.message}");
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
        setState(() {});
      }
    } else {
      wrongDialog("cPOCD is null.");
    }
  }

  Widget setupAlertDialoadContainer(var data, double widthScreen) {
    List unitName = [];
    var listItem = [];
    for (int i = 0; i < data.length; i++) {
      unitName.add(data[i]['cUOMNM']);
    }

    var unitList = unitName.toSet().toList();

    for (int i = 0; i < unitList.length; i++) {
      int num = 0;
      double numItem = 0;
      for (int j = 0; j < data.length; j++) {
        if (unitList[i] == data[j]['cUOMNM']) {
          double total = data[j]['iTOTAL'];
          double prince = data[j]['iPRICE'];
          num++;
          numItem += total;
        }
      }
      var text = {
        "unitName": unitList[i],
        "qty": num,
        "sumItem": numItem.toStringAsFixed(0)
      };
      listItem.add(text);
    }

    return Container(
      height: data.length * 48.0, // Change as per your requirement
      width: widthScreen * 0.8, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listItem.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 48,
            child: Row(
              children: [
                Text('${listItem[index]['qty']} รายการ'),
                Spacer(),
                Text(
                    '${listItem[index]['sumItem']} ${listItem[index]['unitName']}')
              ],
            ),
          );
        },
      ),
    );
  }
}
