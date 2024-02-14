import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addCustomerOrderReq.dart';
import 'package:vansale/api/class/request/mobile/addReturnDTReq.dart';
import 'package:vansale/api/class/request/mobile/addReturnHDReq.dart';
import 'package:vansale/api/class/request/mobile/addStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/getProductBranchReq.dart';
import 'package:vansale/api/class/request/mobile/getProductOrBasketStockReq.dart';
import 'package:vansale/api/class/response/routeMobile/getProductBranchResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductOrBasketStockResp.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/customer_menu/customer_purchase/customerConfirm.dart';
import 'package:vansale/screens/customer_menu/custommer_Order/customer_order_filter.dart';
import 'package:vansale/screens/delivery/delivery_scanner.dart';
import 'package:vansale/screens/home/home.dart';
import 'package:vansale/screens/stocks/stoeck_return/stock_return_img.dart';

class StockReturnBadPro extends StatefulWidget {
  //const MoreItem({ Key? key }) : super(key: key);
  final String typeMenuCode;
  final bool reset;
  StockReturnBadPro(this.typeMenuCode, this.reset);
  @override
  _StockReturnBadProState createState() => _StockReturnBadProState();
}

class _StockReturnBadProState extends State<StockReturnBadPro> {
  String total = '3200.00';
  double widthScreen;
  List<TextEditingController> sController = [];
  List<TextEditingController> mController = [];
  List<TextEditingController> lController = [];
  final formatNum = new NumberFormat("#,###.##", "en_US");
  AddCustomerOrderReq addRequest = AddCustomerOrderReq(
      cCUSTCD: GlobalParam.customer['cCUSTCD'],
      cCREABY: GlobalParam.userData.cUSRNM,
      aPRODUCT: []);
  List<GetProductBranchResp> basketProduct = [];
  String search = '';
  var totalList = [];
  List<GetProductOrBasketStockResp> stockList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.reset == true) {
      getProductBranch(GetProductBranchReq(
        cBRANCD: GlobalParam.customer['cBRANCD'],
        cCUSTTYPE: GlobalParam.customer['cCUSTTYPE'],
        cPRICECD: GlobalParam.customer['cPRICECD'],
        cPRODCD: "%%",
        cPRODNM: "%%",
      ));
    }

    getProductOrBasketStock(GetProductOrBasketStockReq(
        cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
        cWH: 'FG',
        cSEARCH: 'PRODUCT'));
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'คืนสินค้าเสีย',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: HexColor('#6c7e9b'),
              height: 60.0,
              child: Row(
                children: [
                  Container(
                    width: widthScreen * 0.74,
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
                              style: TextStyle(
                                fontFamily: 'Prompt',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  search = value;
                                });
                              },
                              onSubmitted: (value) {
                                searchProductBranch(GetProductBranchReq(
                                  cBRANCD: GlobalParam.customer['cBRANCD'],
                                  cCUSTTYPE: GlobalParam.customer['cCUSTTYPE'],
                                  cPRICECD: GlobalParam.customer['cPRICECD'],
                                  cPRODCD: "%%",
                                  cPRODNM: "%$search%",
                                ));
                              },
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                hintText: "ค้นหา",
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
                                      searchProductBranch(GetProductBranchReq(
                                        cBRANCD:
                                            GlobalParam.customer['cBRANCD'],
                                        cCUSTTYPE:
                                            GlobalParam.customer['cCUSTTYPE'],
                                        cPRICECD:
                                            GlobalParam.customer['cPRICECD'],
                                        cPRODCD: "%%",
                                        cPRODNM: "%$search%",
                                      ));
                                    },
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
                                          code: '008',
                                          navigator: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StockReturnBadPro(
                                                            GlobalParam
                                                                .typeMenuCode,
                                                            false)));
                                          },
                                        )));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: widthScreen * 0.2,
                    height: 48,
                    child: Card(
                      elevation: 0.0,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  CustomerOrderFilterPage(pageNumber: '003')));
                        },
                        child: Container(
                          color: Colors.black12,
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Text(
                            'ประเภท',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: listOfProduct()),
          ],
        ),
      ),
      bottomNavigationBar: footer(),
    );
  }

  Widget listOfProduct() {
    return GlobalParam.customerShowProList.length != 0
        ? ListView.builder(
            itemCount: GlobalParam.customerShowProList.length,
            itemBuilder: (BuildContext context, int index) {
              sController.add(new TextEditingController());
              mController.add(new TextEditingController());
              lController.add(new TextEditingController());
              double sUnitPrice = 0.0;
              double mUnitPrice = 0.0;
              double lUnitPrice = 0.0;
              double total = 0.0;

              if (GlobalParam.customerShowProList[index].cISSSIZE == 'Y') {
                sUnitPrice = double.parse(
                    GlobalParam.customerShowProList[index].iSUNITPRICE);
              }
              if (GlobalParam.customerShowProList[index].cISMSIZE == 'Y') {
                mUnitPrice = double.parse(
                    GlobalParam.customerShowProList[index].iMUNITPRICE);
              }
              if (GlobalParam.customerShowProList[index].cISLSIZE == 'Y') {
                lUnitPrice = double.parse(
                    GlobalParam.customerShowProList[index].iLUNITPRICE);
              }

              for (var k = 0; k < totalList.length; k++) {
                if (totalList[k]['cPRODCD'] ==
                    GlobalParam.customerShowProList[index].cPRODCD) {
                  total = totalList[k]['total'];
                }
              }

              double stockS = 0.0;
              double stockM = 0.0;
              double stockL = 0.0;
              for (var k = 0; k < stockList.length; k++) {
                if (stockList[k].cPRODCD ==
                    GlobalParam.customerShowProList[index].cPRODCD) {
                  if (stockList[k].cUOMCD ==
                      GlobalParam.customerShowProList[index].cSUOMCD) {
                    stockS = double.parse(stockList[k].iPROQTY);
                  }
                  if (stockList[k].cUOMCD ==
                      GlobalParam.customerShowProList[index].cMUOMCD) {
                    stockM = double.parse(stockList[k].iPROQTY);
                  }
                  if (stockList[k].cUOMCD ==
                      GlobalParam.customerShowProList[index].cLUOMCD) {
                    stockL = double.parse(stockList[k].iPROQTY);
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
                            height: 100.0,
                            decoration: BoxDecoration(
                                image: GlobalParam.customerShowProList[index]
                                            .cPHOTOPATH !=
                                        ''
                                    ? DecorationImage(
                                        image: new NetworkImage(
                                          'http://${GlobalParam.customerShowProList[index].cPHOTOSERV}/${GlobalParam.customerShowProList[index].cPHOTOPATH}',
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
                              child: Column(
                                children: [
                                  Container(
                                    width: widthScreen * 0.8,
                                    height: 24,
                                    child: Text(
                                      GlobalParam
                                          .customerShowProList[index].cPRODNM,
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  //--------------------2
                                  Container(
                                    height: 24,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'สต็อก ${stockL.toStringAsFixed(0)}-${stockM.toStringAsFixed(0)}-${stockS.toStringAsFixed(0)}',
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        color: Colors.grey.shade500,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    height: 36,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GlobalParam.customerShowProList[index]
                                                    .cISLSIZE ==
                                                'Y'
                                            ? Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Center(
                                                    child: Text(
                                                      GlobalParam
                                                          .customerShowProList[
                                                              index]
                                                          .cLUOMNM,
                                                      style: TextStyle(
                                                        fontFamily: 'Prompt',
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        GlobalParam.customerShowProList[index]
                                                    .cISMSIZE ==
                                                'Y'
                                            ? Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Center(
                                                    child: Text(
                                                      GlobalParam
                                                          .customerShowProList[
                                                              index]
                                                          .cMUOMNM,
                                                      style: TextStyle(
                                                        fontFamily: 'Prompt',
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        // ignore: unrelated_type_equality_checks
                                        GlobalParam.customerShowProList[index]
                                                    .cISLSIZE ==
                                                'Y'
                                            ? Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Center(
                                                    child: Text(
                                                      GlobalParam
                                                          .customerShowProList[
                                                              index]
                                                          .cSUOMNM,
                                                      style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  //----------------------------3
                                  Container(
                                    height: 36,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // ignore: unrelated_type_equality_checks
                                        GlobalParam.customerShowProList[index]
                                                    .cISLSIZE ==
                                                'Y'
                                            ? Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5.0, right: 5.0),
                                                  height: 30.0,
                                                  width: 80.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
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
                                                        color: Colors.grey),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 8, 0, 0),
                                                    child: TextField(
                                                      controller:
                                                          lController[index],
                                                      onChanged: (value) {
                                                        addValue(
                                                            'L',
                                                            value,
                                                            GlobalParam
                                                                    .customerShowProList[
                                                                index]);
                                                        if (value != '' &&
                                                            value != null) {
                                                          total += double.parse(
                                                                  GlobalParam
                                                                      .customerShowProList[
                                                                          index]
                                                                      .iLUNITPRICE) *
                                                              double.parse(
                                                                  value);
                                                        }
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            HexColor('#00cb39'),
                                                        fontFamily: 'Prompt',
                                                      ),
                                                      cursorColor: Colors.black,
                                                      decoration:
                                                          new InputDecoration(
                                                        //hintText: "1",
                                                        hintStyle: TextStyle(
                                                            color: HexColor(
                                                                '#00cb39')),
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        // contentPadding:
                                                        //     EdgeInsets.only(
                                                        //         left: 15,
                                                        //         bottom: 10,
                                                        //         top: 0,
                                                        //         right: 15),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        // ignore: unrelated_type_equality_checks
                                        GlobalParam.customerShowProList[index]
                                                    .cISMSIZE ==
                                                'Y'
                                            ? Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5.0, right: 5.0),
                                                  height: 30.0,
                                                  width: 80.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
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
                                                        color: Colors.grey),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 8, 0, 0),
                                                    child: TextField(
                                                      controller:
                                                          mController[index],
                                                      onChanged: (value) {
                                                        addValue(
                                                            'M',
                                                            value,
                                                            GlobalParam
                                                                    .customerShowProList[
                                                                index]);
                                                        if (value != '' &&
                                                            value != null) {
                                                          total += double.parse(
                                                                  GlobalParam
                                                                      .customerShowProList[
                                                                          index]
                                                                      .iMUNITPRICE) *
                                                              double.parse(
                                                                  value);
                                                        }
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            HexColor('#00cb39'),
                                                        fontFamily: 'Prompt',
                                                      ),
                                                      cursorColor: Colors.black,
                                                      decoration:
                                                          new InputDecoration(
                                                        //hintText: "1",
                                                        hintStyle: TextStyle(
                                                            color: HexColor(
                                                                '#00cb39')),
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        // contentPadding:
                                                        //     EdgeInsets.only(
                                                        //         left: 15,
                                                        //         bottom: 10,
                                                        //         top: 0,
                                                        //         right: 15),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        // ignore: unrelated_type_equality_checks
                                        GlobalParam.customerShowProList[index]
                                                    .cISSSIZE ==
                                                'Y'
                                            ? Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5.0, right: 5.0),
                                                  height: 30.0,
                                                  width: 80.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
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
                                                        color: Colors.grey),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 8, 0, 0),
                                                      child: TextField(
                                                        controller:
                                                            sController[index],
                                                        onChanged: (value) {
                                                          addValue(
                                                              'S',
                                                              value,
                                                              GlobalParam
                                                                      .customerShowProList[
                                                                  index]);
                                                        },
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: HexColor(
                                                              '#00cb39'),
                                                          fontFamily: 'Prompt',
                                                        ),
                                                        cursorColor:
                                                            Colors.black,
                                                        decoration:
                                                            new InputDecoration(
                                                          //hintText: "1",
                                                          hintStyle: TextStyle(
                                                              color: HexColor(
                                                                  '#00cb39')),
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          errorBorder:
                                                              InputBorder.none,
                                                          disabledBorder:
                                                              InputBorder.none,
                                                          // contentPadding:
                                                          // EdgeInsets.only(
                                                          //     left: 15,
                                                          //     bottom: 10,โ
                                                          //     top: 0,
                                                          //     right: 15),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                      child: Container(
                        height: 24,
                        child: Row(
                          children: [
                            Spacer(),
                            Text(
                              'ต่อหน่วย ${formatNum.format(lUnitPrice)}-${formatNum.format(mUnitPrice)}-${formatNum.format(sUnitPrice)} ฿ รวม ${formatNum.format(total)} ฿',
                              style:
                                  TextStyle(fontFamily: 'Prompt', fontSize: 14),
                            ),
                            // Container(
                            //     alignment: Alignment.centerRight,
                            //     width: widthScreen * 0.68,
                            //     child: SubstringPrice(
                            //       '$unitPrice',
                            //       14.0,
                            //       12.0,
                            //       Colors.black,
                            //       Colors.black,
                            //       'Prompt',
                            //       'Prompt',
                            //       FontWeight.bold,
                            //       FontWeight.bold,
                            //       '฿',
                            //       12.0,
                            //       Colors.black,
                            //       'Prompt',
                            //       FontWeight.bold,
                            //       FontStyle.normal,
                            //       FontStyle.normal,
                            //       FontStyle.normal,
                            //     )),
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
            })
        : Container();
  }

  Widget footer() {
    double widthScreen = MediaQuery.of(context).size.width;
    List<GetProductBranchResp> showData = [];
    List<GetProductBranchResp> orderList = [];
    orderList.addAll(GlobalParam.customerProList);
    var unitList = [];
    double productTotal = 0;

    for (var i = 0; i < orderList.length; i++) {
      double sQty = double.parse(orderList[i].iSSIZEQTY);
      double mQty = double.parse(orderList[i].iMSIZEQTY);
      double lQty = double.parse(orderList[i].iLSIZEQTY);
      double sPrice = double.parse(orderList[i].iSUNITPRICE);
      double mPrice = double.parse(orderList[i].iMUNITPRICE);
      double lPrice = double.parse(orderList[i].iLUNITPRICE);
      if ((sQty + mQty + lQty) > 0) {
        showData.add(orderList[i]);
        productTotal += (sQty * sPrice) + (mQty * mPrice) + (lQty * lPrice);
        if (sQty > 0) {
          var data = {
            "cPRODCD": orderList[i].cPRODCD,
            "cUOMNM": orderList[i].cSUOMNM,
            "iPRICE": double.parse(orderList[i].iSUNITPRICE),
            "iTOTAL": double.parse(orderList[i].iSSIZEQTY)
          };
          unitList.add(data);
        }
        if (mQty > 0) {
          var data = {
            "cUOMNM": orderList[i].cMUOMNM,
            "iPRICE": double.parse(orderList[i].iMUNITPRICE),
            "iTOTAL": double.parse(orderList[i].iMSIZEQTY)
          };
          unitList.add(data);
        }
        if (lQty > 0) {
          var data = {
            "cUOMNM": orderList[i].cLUOMNM,
            "iPRICE": double.parse(orderList[i].iLUNITPRICE),
            "iTOTAL": double.parse(orderList[i].iLSIZEQTY)
          };
          unitList.add(data);
        }
      }
    }

    return Container(
      height: 136.0,
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
                      '${productTotal.toStringAsFixed(2)}',
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
                    if (basketProduct.length > 0) {
                      addReturnHD();
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              HomePage(GlobalParam.typeMenuCode)));
                    }
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
                          'บันทึกคืนสินค้าเสีย',
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

  addCustomerOrder(AddCustomerOrderReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.addCustomerOrder(req);

      if (result.success == false) {
        wrongDialog('${result.message}');
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                CustomerOrderConfirm(widget.typeMenuCode),
          ),
        );
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getProductOrBasketStock(GetProductOrBasketStockReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getProductOrBasketStock(req);

      if (result.isNotEmpty) {
        setState(() {
          stockList = [];
          stockList.addAll(result);
        });
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getProductBranch(GetProductBranchReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var result = await proxy.getProductBranch(req);
      GlobalParam.customerProList = [];
      GlobalParam.customerShowProList = [];

      if (result.isNotEmpty) {
        GlobalParam.customerProList.addAll(result);
        // GlobalParam.customerShowProList.addAll(result);
        for (var i = 0; i < result.length; i++) {
          if (result[i].cSUPCD == GlobalParam.stockSupSelect.cSUPCD) {
            GlobalParam.customerShowProList.add(result[i]);
            var data = {"cPRODCD": result[i].cPRODCD, "total": 0.0};
            totalList.add(data);
          }
        }
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  searchProductBranch(GetProductBranchReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var result = await proxy.getProductBranch(req);
      GlobalParam.customerShowProList = [];
      if (result.isNotEmpty) {
        GlobalParam.customerShowProList = [];
        for (var i = 0; i < result.length; i++) {
          if (result[i].cSUPCD == GlobalParam.stockSupSelect.cSUPCD) {
            GlobalParam.customerShowProList.add(result[i]);
          }
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

  addReturnHD() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var checkReturn = 0.0;
      var sQty = 0.0;
      var mQty = 0.0;
      var lQty = 0.0;
      var sPrice = 0.0;
      var mPrice = 0.0;
      var lPrice = 0.0;
      var sTotal = 0.0;
      var mTotal = 0.0;
      var lTotal = 0.0;
      var cRETCD = '';
      for (int i = 0; i < basketProduct.length; i++) {
        checkReturn += double.parse(basketProduct[i].iLSIZEQTY) +
            double.parse(basketProduct[i].iMSIZEQTY) +
            double.parse(basketProduct[i].iSSIZEQTY);
        if (checkReturn > 0) {
          if (double.parse(basketProduct[i].iSSIZEQTY) > 0) {
            sQty = double.parse(basketProduct[i].iSSIZEQTY);
            sPrice = double.parse(basketProduct[i].iSUNITPRICE);
            sTotal += sQty * sPrice;
          }

          if (double.parse(basketProduct[i].iMSIZEQTY) > 0) {
            mQty = double.parse(basketProduct[i].iMSIZEQTY);
            mPrice = double.parse(basketProduct[i].iMUNITPRICE);
            mTotal += mQty * mPrice;
          }

          if (double.parse(basketProduct[i].iLSIZEQTY) > 0) {
            lQty = double.parse(basketProduct[i].iLSIZEQTY);
            lPrice = double.parse(basketProduct[i].iLUNITPRICE);
            lTotal += lQty * lPrice;
          }
        }
      }

      if ((sTotal + mTotal + lTotal) > 0) {
        if (checkReturn > 0) {
          AddReturnHDReq req = AddReturnHDReq(
              cBRANCD: GlobalParam.VEHICLE["cBRANCD"],
              cGRPCD: '',
              cRTECD: '',
              cVEHICD: '',
              cDRIVER: '',
              cCUSTCD: GlobalParam.VEHICLE["cBRANCD"],
              cCUSTNM: GlobalParam.VEHICLE["cBRANNM"],
              cREMARK: '',
              iTOTAL: '${sTotal + mTotal + lTotal}',
              cREFDOC: '',
              cRETYP: 'BBPTS',
              cPAYST: 'N',
              cCREABY: GlobalParam.userID);
          // print(req);
          var result = await proxy.addReturnHD(req);
          cRETCD = result.result;
          if (result.success == false) {
            wrongDialog('${result.message}');
          } else {
            GlobalParam.deliveryReturnProRef = result.result;
            for (int i = 0; i < basketProduct.length; i++) {
              if ((double.parse(basketProduct[i].iSSIZEQTY) +
                      double.parse(basketProduct[i].iMSIZEQTY) +
                      double.parse(basketProduct[i].iLSIZEQTY)) >
                  0) {
                AddReturnDTReq data = AddReturnDTReq(
                    cRETCD: result.result,
                    iSEQ: "${i + 1}",
                    cPRODCD: basketProduct[i].cPRODCD,
                    cPRODNM: basketProduct[i].cPRODNM,
                    cBRNDCD: basketProduct[i].cBRNDCD,
                    cBRNDNM: basketProduct[i].cBRNDNM,
                    iSSIZEQTY: basketProduct[i].iSSIZEQTY,
                    iMSIZEQTY: basketProduct[i].iMSIZEQTY,
                    iLSIZEQTY: basketProduct[i].iLSIZEQTY,
                    cSUOMCD: basketProduct[i].cSUOMCD,
                    cSUOMNM: basketProduct[i].cSUOMNM,
                    cMUOMCD: basketProduct[i].cMUOMCD,
                    cMUOMNM: basketProduct[i].cMUOMNM,
                    cLUOMCD: basketProduct[i].cLUOMCD,
                    cLUOMNM: basketProduct[i].cLUOMNM,
                    iSUNITPRICE: basketProduct[i].iSUNITPRICE,
                    iMUNITPRICE: basketProduct[i].iMUNITPRICE,
                    iLUNITPRICE: basketProduct[i].iLUNITPRICE,
                    cCREABY: GlobalParam.userID);
                // print(
                //     '--------------------${basketProduct[i].cPRODNM} ${basketProduct[i].iSSIZEQTY}');
                addReturnDT(data);
              }
            }

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StockReturnImage('03', cRETCD)));
          }
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StockReturnImage('03', cRETCD)));
        }
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StockReturnImage('03', cRETCD)));
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }

  addReturnDT(AddReturnDTReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.addReturnDT(req);

      if (result.success == false) {
        wrongDialog('${result.message}');
      } else {
        addStockCard(req.cRETCD);
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }

  addStockCard(String cRETCD) async {
    // print(
    //     '**********${GlobalParam.deliveryPodtList.length} : ${basketProduct.length}************');
    try {
      List<StockCardReq> stockCardReqList = [];
      var checkReturn = 0.0;
      var sQty = 0.0;
      var mQty = 0.0;
      var lQty = 0.0;
      var sPrice = 0.0;
      var mPrice = 0.0;
      var lPrice = 0.0;
      var sTotal = 0.0;
      var mTotal = 0.0;
      var lTotal = 0.0;

      for (int i = 0; i < basketProduct.length; i++) {
        checkReturn = double.parse(basketProduct[i].iLSIZEQTY) +
            double.parse(basketProduct[i].iMSIZEQTY) +
            double.parse(basketProduct[i].iLSIZEQTY);

        if (checkReturn > 0) {
          String cUOMCD = '';
          if (double.parse(basketProduct[i].iSSIZEQTY) > 0) {
            cUOMCD = basketProduct[i].cSUOMCD;
            sQty = double.parse(basketProduct[i].iSSIZEQTY);
            sPrice = double.parse(basketProduct[i].iSUNITPRICE);
            sTotal = sQty * sPrice;
            StockCardReq reGood = StockCardReq(
                cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                cPRODCD: basketProduct[i].cPRODCD,
                cUOMCD: cUOMCD,
                cWH: 'SP',
                cREFDOC: cRETCD,
                iRECEIVEQTY: '0',
                iISSUEQTY: '${sQty.toStringAsFixed(0)}',
                cREMARK: '',
                cLOTNO: '',
                cCREABY: GlobalParam.userData.cUSRNM);

            stockCardReqList.add(reGood);
          }
          if (double.parse(basketProduct[i].iMSIZEQTY) > 0) {
            cUOMCD = basketProduct[i].cMUOMCD;
            mQty = double.parse(basketProduct[i].iMSIZEQTY);
            mPrice = double.parse(basketProduct[i].iMUNITPRICE);
            mTotal = mQty * mPrice;
            StockCardReq reGood = StockCardReq(
                cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                cPRODCD: basketProduct[i].cPRODCD,
                cUOMCD: cUOMCD,
                cWH: 'SP',
                cREFDOC: cRETCD,
                iRECEIVEQTY: '0',
                iISSUEQTY: '${mQty.toStringAsFixed(0)}',
                cREMARK: '',
                cLOTNO: '',
                cCREABY: GlobalParam.userData.cUSRNM);

            stockCardReqList.add(reGood);
          }
          if (double.parse(basketProduct[i].iLSIZEQTY) > 0) {
            cUOMCD = basketProduct[i].cLUOMCD;
            lQty = double.parse(basketProduct[i].iLSIZEQTY);
            lPrice = double.parse(basketProduct[i].iLUNITPRICE);
            lTotal = lQty * lPrice;
            StockCardReq reGood = StockCardReq(
                cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                cPRODCD: basketProduct[i].cPRODCD,
                cUOMCD: cUOMCD,
                cWH: 'SP',
                cREFDOC: cRETCD,
                iRECEIVEQTY: '0',
                iISSUEQTY: '${lQty.toStringAsFixed(0)}',
                cREMARK: '',
                cLOTNO: '',
                cCREABY: GlobalParam.userData.cUSRNM);

            stockCardReqList.add(reGood);
          }
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
          wrongDialog('${result.message}');
        }
      }
      // GlobalParam.deliveryRegetPODT = false;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) =>
      //         DeliveryStoreGetBadProduct(GlobalParam.typeMenuCode, ''),
      //   ),
      // );
      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  addValue(String size, String value, GetProductBranchResp product) {
    bool proRepeat = false;
    for (var i = 0; i < GlobalParam.customerProList.length; i++) {
      if (product.cPRODCD == GlobalParam.customerProList[i].cPRODCD) {
        if (value != '') {
          if (size == "S") {
            GlobalParam.customerProList[i].iSSIZEQTY = value;
          }
          if (size == "M") {
            GlobalParam.customerProList[i].iMSIZEQTY = value;
          }
          if (size == "L") {
            GlobalParam.customerProList[i].iLSIZEQTY = value;
          }
        } else {
          if (size == "S") {
            GlobalParam.customerProList[i].iSSIZEQTY = '0.0';
          }
          if (size == "M") {
            GlobalParam.customerProList[i].iMSIZEQTY = '0.0';
          }
          if (size == "L") {
            GlobalParam.customerProList[i].iLSIZEQTY = '0.0';
          }
        }

        for (var j = 0; j < basketProduct.length; j++) {
          if (product.cPRODCD == basketProduct[j].cPRODCD) {
            proRepeat = true;
          }
        }
        if (proRepeat == true) {
          for (var j = 0; j < basketProduct.length; j++) {
            if (product.cPRODCD == basketProduct[j].cPRODCD) {
              basketProduct.removeAt(j);
              basketProduct.add(GlobalParam.customerProList[i]);
            }
          }
        } else {
          basketProduct.add(GlobalParam.customerProList[i]);
        }

        for (var k = 0; k < totalList.length; k++) {
          double sQty = double.parse(GlobalParam.customerProList[i].iSSIZEQTY);
          double mQty = double.parse(GlobalParam.customerProList[i].iMSIZEQTY);
          double lQty = double.parse(GlobalParam.customerProList[i].iLSIZEQTY);
          double sPrice =
              double.parse(GlobalParam.customerProList[i].iSUNITPRICE);
          double mPrice =
              double.parse(GlobalParam.customerProList[i].iMUNITPRICE);
          double lPrice =
              double.parse(GlobalParam.customerProList[i].iLUNITPRICE);
          if (totalList[k]['cPRODCD'] ==
              GlobalParam.customerProList[i].cPRODCD) {
            totalList[k]['total'] =
                (sQty * sPrice) + (mQty * mPrice) + (lQty * lPrice);
          }
        }
      }
      for (var j = 0; j < addRequest.aPRODUCT.length; j++) {
        if (GlobalParam.customerProList[i].cPRODCD ==
            addRequest.aPRODUCT[j].cPRODCD) {
          addRequest.aPRODUCT[j].iSSIZEQTY =
              double.parse(GlobalParam.customerProList[i].iSSIZEQTY);
          addRequest.aPRODUCT[j].iMSIZEQTY =
              double.parse(GlobalParam.customerProList[i].iMSIZEQTY);
          addRequest.aPRODUCT[j].iLSIZEQTY =
              double.parse(GlobalParam.customerProList[i].iLSIZEQTY);
        }
      }
    }
    setState(() {});
  }
}
