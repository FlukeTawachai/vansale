import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addProductTransferReq.dart';
import 'package:vansale/api/class/request/mobile/addStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/getVehicleWithBranchReq.dart';
import 'package:vansale/api/class/response/routeMobile/getProductSetResp.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/branch_warehouse/branch_warehouse_transfer/lst_batch.dart';
import 'package:vansale/screens/branch_warehouse/signature/signature_screen.dart';
import 'package:vansale/screens/home/home.dart';
import 'package:vansale/screens/namo/signature_screen.dart';

class BatchTransfer extends StatefulWidget {
  final String cBRANCD;
  final String cVEHICD;
  final String cCUSTTYPE;
  final String code;
  final AddProductTransferReq reqData;
  const BatchTransfer(
      {Key key,
      this.cBRANCD,
      this.cVEHICD,
      this.cCUSTTYPE,
      this.code,
      this.reqData})
      : super(key: key);

  @override
  State<BatchTransfer> createState() => _BatchTransferState();
}

class _BatchTransferState extends State<BatchTransfer> {
  List<TextEditingController> lsttxtQty = [];
  var f = NumberFormat("#,###.##", "en_US");
  double widthScreen = 0;
  var listItem2 = [];
  double totalSum = 0;
  List<double> totalList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductSet();
    GlobalParam.saleProductSetTransferList = [];
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('โอนเป็นชุด'),
      ),
      body: productSetList(),
      bottomNavigationBar: footer(),
    );
  }

  Widget footer() {
    double widthScreen = MediaQuery.of(context).size.width;
    List<GetProductSetResp> showData = [];
    List<GetProductSetResp> orderList = [];
    orderList.addAll(GlobalParam.saleProductSetTransferList);
    var unitList = [];
    double productTotal = 0;

    for (var i = 0; i < orderList.length; i++) {
      double sQty = double.parse(orderList[i].iSSIZEQTY);
      double mQty = double.parse(orderList[i].iMSIZEQTY);
      double lQty = double.parse(orderList[i].iLSIZEQTY);
      double sPrice = 0;
      double mPrice = 0;
      double lPrice = 0;

      if ((sQty + mQty + lQty) > 0) {
        for (int j = 0; j < orderList[i].aPRODUCT.length; j++) {
          var data = orderList[i].aPRODUCT[j];
          sPrice = double.parse(data.iSUOMQTY) * double.parse(data.iCOSTVAT);
          mPrice = double.parse(data.iMUOMQTY) * double.parse(data.iCOSTVAT);
          lPrice = double.parse(data.iLUOMQTY) * double.parse(data.iCOSTVAT);

          if (double.parse(data.iSSIZEQTY) > 0) {
            var dataf = {
              "cPRODCD": data.cPRODCD,
              "cUOMNM": data.cSUOMNM,
              "iPRICE": sPrice,
              "iTOTAL": double.parse(data.iSSIZEQTY)
            };
            unitList.add(dataf);
          }
          if (double.parse(data.iMSIZEQTY) > 0) {
            var dataf = {
              "cPRODCD": data.cPRODCD,
              "cUOMNM": data.cMUOMNM,
              "iPRICE": mPrice,
              "iTOTAL": double.parse(data.iMSIZEQTY)
            };
            unitList.add(dataf);
          }
          if (double.parse(data.iLSIZEQTY) > 0) {
            var dataf = {
              "cPRODCD": data.cPRODCD,
              "cUOMNM": data.cLUOMNM,
              "iPRICE": lPrice,
              "iTOTAL": double.parse(data.iLSIZEQTY)
            };
            unitList.add(dataf);
          }
        }
        showData.add(orderList[i]);
        // productTotal += (sQty * sPrice) + (mQty * mPrice) + (lQty * lPrice);
      }
    }

    for (var ax in this.totalList) {
      productTotal += ax;
    }

    listItem2 = showData;
    totalSum = double.parse(productTotal.toStringAsFixed(2));

    return Container(
      height: 128.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(children: [
        Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
              child: Row(
                children: [
                  Container(
                      width: widthScreen * 0.46,
                      height: 24,
                      child: Text(
                        '${showData.length} รายการ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
                        ),
                      )),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'รายละเอียด',
                                style: TextStyle(
                                    fontFamily: 'Prompt', fontSize: 16),
                              ),
                              content: setupAlertDialoadContainer(
                                  unitList, widthScreen),
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
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(color: Colors.green),
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

            // SizedBox(
            //   height: 24,
            // ),
            //--------------
            Container(
              padding: const EdgeInsets.only(top: 5.0, left: 12.0, right: 12.0),
              child: Row(
                children: [
                  Container(
                    width: widthScreen * 0.4,
                    height: 24,
                    child: Text(
                      'รวมเป็นเงิน',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: widthScreen * 0.4,
                    // height: 24,
                    alignment: Alignment.centerRight,
                    child: SubstringPrice(
                      '${totalSum.toStringAsFixed(2)}',
                      18.0,
                      14.0,
                      Colors.orange,
                      Colors.orange,
                      'Prompt',
                      'Prompt',
                      FontWeight.bold,
                      FontWeight.bold,
                      '฿',
                      18.0,
                      Colors.orange,
                      'Prompt',
                      FontWeight.bold,
                      FontStyle.normal,
                      FontStyle.normal,
                      FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),

            //--------------
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    addProductTransfer();
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child: Icon(
                              LineAwesomeIcons.boxes,
                              color: Colors.green,
                              size: 25.0,
                            )),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'บันทึกโอนย้ายสินค้า',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                            fontFamily: 'Prompt',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        //--------------
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 64),
        //   child: SliderCard(),
        // ),
      ]),
    );
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

  Widget productSetList() {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: GlobalParam.saleProductSetList.length,
      itemBuilder: (BuildContext context, int index) {
        lsttxtQty.add(new TextEditingController(text: ""));
        var total = 0.0;
        double totalProduct = 0;
        for (int i = 0;
            i < GlobalParam.saleProductSetList[index].aPRODUCT.length;
            i++) {
          this.totalList.add(0);
          var data = GlobalParam.saleProductSetList[index].aPRODUCT[i];
          double sCost = 0;
          double mCost = 0;
          double lCost = 0;
          sCost = double.parse(data.iSUOMQTY) *
              double.parse(data.iCOSTVAT) *
              double.parse(data.iSSIZEQTY);
          mCost = double.parse(data.iMUOMQTY) *
              double.parse(data.iCOSTVAT) *
              double.parse(data.iMSIZEQTY);
          lCost = double.parse(data.iLUOMQTY) *
              double.parse(data.iCOSTVAT) *
              double.parse(data.iLSIZEQTY);
          total += sCost + mCost + lCost;
        }
        return Container(
          color: HexColor("#F2F3F4"),
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: widthScreen * 0.6,
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              GlobalParam.saleProductSetList[index].cSETNM,
                              style: TextStyle(
                                fontFamily: "Prompt",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            width: widthScreen * 0.2,
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ยอดเงิน",
                              style: TextStyle(
                                fontFamily: "Prompt",
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              margin:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              height: 36.0,
                              width: widthScreen * 0.55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                                child: TextFormField(
                                  controller: lsttxtQty[index],
                                  onChanged: (value) {
                                    if (value != '') {
                                      addProductSet(
                                          GlobalParam.saleProductSetList[index],
                                          double.tryParse(value) ?? 0,
                                          index);
                                    } else {
                                      addProductSet(
                                          GlobalParam.saleProductSetList[index],
                                          0,
                                          index);
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: HexColor('#00cb39'),
                                    fontFamily: 'Prompt',
                                  ),
                                  cursorColor: Colors.black,
                                  decoration: new InputDecoration(
                                    hintText: " จำนวนชุด",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              height: 36.0,
                              width: widthScreen * 0.28,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Text(
                                "${f.format((this.totalList[index] ?? 0))} ฿",
                                style: TextStyle(
                                  fontFamily: "Prompt",
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      // Container(
                      //   padding: const EdgeInsets.only(right: 12.0),
                      //   alignment: Alignment.centerRight,
                      //   child: Text(
                      //     "${f.format(total)} ฿",
                      //     style: TextStyle(
                      //       fontFamily: "Prompt",
                      //       fontSize: 14,
                      //     ),
                      //     textAlign: TextAlign.right,
                      //   ),
                      // ),
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
      },
    );
  }

  addProductSet(GetProductSetResp data, double value, int index) {
    this.totalList[index] = 0.0;
    for (var ar in data.aPRODUCT) {
      this.totalList[index] += ((double.tryParse(ar.iCOST) ?? 0) * value);
    }

    GlobalParam.saleProductSetTransferList = [];
    for (var i = 0; i < GlobalParam.saleProductSetList.length; i++) {
      var master = new GetProductSetResp(
          cGUID: GlobalParam.saleProductSetList[i].cGUID,
          cSETCD: GlobalParam.saleProductSetList[i].cSETCD,
          cSETNM: GlobalParam.saleProductSetList[i].cSETNM,
          cBRANCD: GlobalParam.saleProductSetList[i].cBRANCD,
          cBRANNM: GlobalParam.saleProductSetList[i].cBRANNM,
          cCUSTTYPE: GlobalParam.saleProductSetList[i].cCUSTTYPE,
          iSSIZEQTY: GlobalParam.saleProductSetList[i].iSSIZEQTY,
          iMSIZEQTY: GlobalParam.saleProductSetList[i].iMSIZEQTY,
          iLSIZEQTY: GlobalParam.saleProductSetList[i].iLSIZEQTY,
          cSTATUS: GlobalParam.saleProductSetList[i].cSTATUS,
          cCREABY: GlobalParam.saleProductSetList[i].cCREABY,
          cUPDABY: GlobalParam.saleProductSetList[i].cUPDABY,
          dCREADT: GlobalParam.saleProductSetList[i].dCREADT,
          dUPDADT: GlobalParam.saleProductSetList[i].dUPDADT,
          aPRODUCT: []);

      for (var j = 0;
          j < GlobalParam.saleProductSetList[i].aPRODUCT.length;
          j++) {
        var data = new APRODUCTGetProductSet(
          cGUID: GlobalParam.saleProductSetList[i].aPRODUCT[j].cGUID,
          cSETCD: GlobalParam.saleProductSetList[i].aPRODUCT[j].cSETCD,
          iSEQ: GlobalParam.saleProductSetList[i].aPRODUCT[j].iSEQ,
          cPRODCD: GlobalParam.saleProductSetList[i].aPRODUCT[j].cPRODCD,
          cPRODNM: GlobalParam.saleProductSetList[i].aPRODUCT[j].cPRODNM,
          cBRNDCD: GlobalParam.saleProductSetList[i].aPRODUCT[j].cBRNDCD,
          cBRNDNM: GlobalParam.saleProductSetList[i].aPRODUCT[j].cBRNDNM,
          iSSIZEQTY: GlobalParam.saleProductSetList[i].aPRODUCT[j].iSSIZEQTY,
          iMSIZEQTY: GlobalParam.saleProductSetList[i].aPRODUCT[j].iMSIZEQTY,
          iLSIZEQTY: GlobalParam.saleProductSetList[i].aPRODUCT[j].iLSIZEQTY,
          cSUOMCD: GlobalParam.saleProductSetList[i].aPRODUCT[j].cSUOMCD,
          cSUOMNM: GlobalParam.saleProductSetList[i].aPRODUCT[j].cSUOMNM,
          iSUOMQTY: GlobalParam.saleProductSetList[i].aPRODUCT[j].iSUOMQTY,
          cMUOMCD: GlobalParam.saleProductSetList[i].aPRODUCT[j].cMUOMCD,
          cMUOMNM: GlobalParam.saleProductSetList[i].aPRODUCT[j].cMUOMNM,
          iMUOMQTY: GlobalParam.saleProductSetList[i].aPRODUCT[j].iMUOMQTY,
          cLUOMCD: GlobalParam.saleProductSetList[i].aPRODUCT[j].cLUOMCD,
          cLUOMNM: GlobalParam.saleProductSetList[i].aPRODUCT[j].cLUOMNM,
          iLUOMQTY: GlobalParam.saleProductSetList[i].aPRODUCT[j].iLUOMQTY,
          cBASKCD: GlobalParam.saleProductSetList[i].aPRODUCT[j].cBASKCD,
          cBASKNM: GlobalParam.saleProductSetList[i].aPRODUCT[j].cBASKNM,
          dCREADT: GlobalParam.saleProductSetList[i].aPRODUCT[j].dCREADT,
          cCREABY: GlobalParam.saleProductSetList[i].aPRODUCT[j].cCREABY,
          dUPDADT: GlobalParam.saleProductSetList[i].aPRODUCT[j].dUPDADT,
          cUPDABY: GlobalParam.saleProductSetList[i].aPRODUCT[j].cUPDABY,
          iCOST: GlobalParam.saleProductSetList[i].aPRODUCT[j].iCOST,
          iCOSTVAT: GlobalParam.saleProductSetList[i].aPRODUCT[j].iCOSTVAT,
          cPRODEX: GlobalParam.saleProductSetList[i].aPRODUCT[j].cPRODEX,
          iGENVAT: GlobalParam.saleProductSetList[i].aPRODUCT[j].iGENVAT,
          iEXCVAT: GlobalParam.saleProductSetList[i].aPRODUCT[j].iEXCVAT,
          cTYPE: GlobalParam.saleProductSetList[i].aPRODUCT[j].cTYPE,
          cMCATE: GlobalParam.saleProductSetList[i].aPRODUCT[j].cMCATE,
          cSCATE: GlobalParam.saleProductSetList[i].aPRODUCT[j].cSCATE,
          cCOLOR: GlobalParam.saleProductSetList[i].aPRODUCT[j].cCOLOR,
          cDIMENS: GlobalParam.saleProductSetList[i].aPRODUCT[j].cDIMENS,
          iWEIGHT: GlobalParam.saleProductSetList[i].aPRODUCT[j].iWEIGHT,
          cSUPCD: GlobalParam.saleProductSetList[i].aPRODUCT[j].cSUPCD,
          cSHARE: GlobalParam.saleProductSetList[i].aPRODUCT[j].cSHARE,
          iMINSTK: GlobalParam.saleProductSetList[i].aPRODUCT[j].iMINSTK,
          iMAXSTK: GlobalParam.saleProductSetList[i].aPRODUCT[j].iMAXSTK,
        );
        master.aPRODUCT.add(data);
      }

      if (master.cSETCD == data.cSETCD) {
        master.iSSIZEQTY = "${double.parse(master.iSSIZEQTY) * value}";
        master.iMSIZEQTY = "${double.parse(master.iMSIZEQTY) * value}";
        master.iLSIZEQTY = "${double.parse(master.iLSIZEQTY) * value}";

        for (var j = 0; j < master.aPRODUCT.length; j++) {
          var product = master.aPRODUCT[j];
          master.aPRODUCT[j].iSSIZEQTY =
              "${double.parse(product.iSSIZEQTY) * value}";
          master.aPRODUCT[j].iMSIZEQTY =
              "${double.parse(product.iMSIZEQTY) * value}";
          master.aPRODUCT[j].iLSIZEQTY =
              "${double.parse(product.iLSIZEQTY) * value}";
        }
        GlobalParam.saleProductSetTransferList.add(master);
      }
    }
    setState(() {});
  }

  getProductSet() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getProductSet(GetVehicleWithBranchReq(
          cBRANCD: widget.cBRANCD, cCUSTTYPE: widget.cCUSTTYPE));
      if (result.isNotEmpty) {
        GlobalParam.saleProductSetList = [];
        for (var i = 0; i < result.length; i++) {
          if (result[i].cSTATUS == 'Y') {
            GlobalParam.saleProductSetList.add(result[i]);
          }
        }
      } else {
        GlobalParam.saleProductSetList = [];
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  addProductTransfer() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      AddProductTransferReq req = AddProductTransferReq(
          cBRANCD: widget.reqData.cBRANCD,
          cSENDER: widget.reqData.cSENDER,
          cSENDERNM: widget.reqData.cSENDERNM,
          cRECEIVER: widget.reqData.cRECEIVER,
          cRECEIVERNM: widget.reqData.cRECEIVERNM,
          cTPYE: "BTV",
          cCREABY: GlobalParam.userData.cUSRNM,
          aPRODUCT: []);

      for (var i = 0; i < GlobalParam.saleProductSetTransferList.length; i++) {
        var master = GlobalParam.saleProductSetTransferList[i];
        for (var j = 0;
            j < GlobalParam.saleProductSetTransferList[i].aPRODUCT.length;
            j++) {
          var product = GlobalParam.saleProductSetTransferList[i].aPRODUCT[j];
          if (double.parse(product.iSSIZEQTY) > 0) {
            PRODUCTLIST data = PRODUCTLIST(
              cSETCD: master.cSETCD,
              cSETNM: master.cSETNM,
              cPRODCD: product.cPRODCD,
              cSIZE: "S",
              iQTY: double.parse(product.iSSIZEQTY),
              iUOMPRICE: double.parse(product.iSUOMQTY) *
                  double.parse(product.iCOSTVAT),
            );
            req.aPRODUCT.add(data);
          }
          if (double.parse(product.iMSIZEQTY) > 0) {
            PRODUCTLIST data = PRODUCTLIST(
              cSETCD: master.cSETCD,
              cSETNM: master.cSETNM,
              cPRODCD: product.cPRODCD,
              cSIZE: "M",
              iQTY: double.parse(product.iMSIZEQTY),
              iUOMPRICE: double.parse(product.iMUOMQTY) *
                  double.parse(product.iCOSTVAT),
            );
            req.aPRODUCT.add(data);
          }
          if (double.parse(product.iLSIZEQTY) > 0) {
            PRODUCTLIST data = PRODUCTLIST(
              cSETCD: master.cSETCD,
              cSETNM: master.cSETNM,
              cPRODCD: product.cPRODCD,
              cSIZE: "L",
              iQTY: double.parse(product.iLSIZEQTY),
              iUOMPRICE: double.parse(product.iLUOMQTY) *
                  double.parse(product.iCOSTVAT),
            );
            req.aPRODUCT.add(data);
          }
        }
      }

      var result = await proxy.addProductTransfer(req);
      if (result.success == false) {
        wrongDialog("${result.message}");
      } else {
        var check = 0;
        for (var i = 0;
            i < GlobalParam.saleProductSetTransferList.length;
            i++) {
          addStockCard(
              result.result, GlobalParam.saleProductSetTransferList[i]);
          check++;
        }

        if (check == GlobalParam.saleProductSetTransferList.length) {
          await Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => Signature2(
                        cVEHICD: widget.cVEHICD,
                        item: listItem2.length,
                        total: totalSum,
                        cREF: result.result,
                      )))
              .then((_) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(GlobalParam.typeMenuCode)));
          });
        }
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  addStockCard(String cREFDOC, GetProductSetResp data) async {
    // print(
    //     '**********${GlobalParam.deliveryPodtList.length} : ${basketProduct.length}************');
    try {
      List<StockCardReq> reqList = [];
      for (int i = 0; i < data.aPRODUCT.length; i++) {
        if (double.parse(data.aPRODUCT[i].iSSIZEQTY) > 0) {
          StockCardReq saleProSet = StockCardReq(
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cPRODCD: data.aPRODUCT[i].cPRODCD,
              cUOMCD: data.aPRODUCT[i].cSUOMCD,
              cWH: 'FG',
              cREFDOC: cREFDOC,
              iRECEIVEQTY: '0',
              iISSUEQTY: data.aPRODUCT[i].iSSIZEQTY,
              cREMARK: 'Transfer product set',
              cLOTNO: '',
              cCREABY: GlobalParam.userData.cUSRNM);
          reqList.add(saleProSet);
        }
        if (double.parse(data.aPRODUCT[i].iMSIZEQTY) > 0) {
          StockCardReq saleProSet = StockCardReq(
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cPRODCD: data.aPRODUCT[i].cPRODCD,
              cUOMCD: data.aPRODUCT[i].cMUOMCD,
              cWH: 'FG',
              cREFDOC: cREFDOC,
              iRECEIVEQTY: '0',
              iISSUEQTY: data.aPRODUCT[i].iMSIZEQTY,
              cREMARK: 'Transfer product set',
              cLOTNO: '',
              cCREABY: GlobalParam.userData.cUSRNM);
          reqList.add(saleProSet);
        }
        if (double.parse(data.aPRODUCT[i].iLSIZEQTY) > 0) {
          StockCardReq saleProSet = StockCardReq(
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cPRODCD: data.aPRODUCT[i].cPRODCD,
              cUOMCD: data.aPRODUCT[i].cLUOMCD,
              cWH: 'FG',
              cREFDOC: cREFDOC,
              iRECEIVEQTY: '0',
              iISSUEQTY: data.aPRODUCT[i].iLSIZEQTY,
              cREMARK: 'Transfer product set',
              cLOTNO: '',
              cCREABY: GlobalParam.userData.cUSRNM);
          reqList.add(saleProSet);
        }
      }

      AllApiProxyMobile proxy = AllApiProxyMobile();
      var check = 0;
      for (int i = 0; i < reqList.length; i++) {
        var result = await proxy.addStockCard(reqList[i]);
        if (result.success == false) {
          wrongDialog('${result.message}');
        } else {
          check++;
        }
      }
      // if (reqList.length == 0) {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => HomePage(GlobalParam.typeMenuCode)));
      // }
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
        title: const Text('แจ้งเตือน'),
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
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      'ตกลง',
                    );
                  },
                  child: const Text(
                    'ตกลง',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
