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
import 'package:vansale/api/class/request/mobile/addReturnProductToStockReq.dart';
import 'package:vansale/api/class/request/mobile/addStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/getProductBranchReq.dart';
import 'package:vansale/api/class/request/mobile/getProductOrBasketStockReq.dart';
import 'package:vansale/api/class/request/mobile/getProductReturnReq.dart';
import 'package:vansale/api/class/response/routeMobile/getProductBranchResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductOrBasketStockResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductReturnOfRouteResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductReturnResp.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/customer_menu/custommer_Order/customer_order_filter.dart';
import 'package:vansale/screens/delivery/delivery_scanner.dart';
import 'package:vansale/screens/stocks/stock_transfer/product_mis_filter.dart';

import 'package:vansale/screens/stocks/stock_transfer/stock_transfer_barket.dart';
import 'package:vansale/screens/stocks/stock_transfer/stock_transfer_good.dart';
import 'package:vansale/screens/stocks/stoeck_return/stock_return_img.dart';

class StockTransferReturnMissPro extends StatefulWidget {
  //const MoreItem({ Key? key }) : super(key: key);
  final bool reset;
  StockTransferReturnMissPro(this.reset);
  @override
  _StockTransferReturnMissProState createState() =>
      _StockTransferReturnMissProState();
}

class _StockTransferReturnMissProState
    extends State<StockTransferReturnMissPro> {
  String total = '3200.00';
  double widthScreen;
  List<TextEditingController> inController = [];
  List<TextEditingController> deController = [];
  final formatNum = new NumberFormat("#,###.##", "en_US");
  AddCustomerOrderReq addRequest = AddCustomerOrderReq(
      cCUSTCD: GlobalParam.customer['cCUSTCD'],
      cCREABY: GlobalParam.userData.cUSRNM,
      aPRODUCT: []);
  List<GetProductBranchResp> basketProduct = [];
  List<GetProductReturnResp> returnProList;
  String search = '';
  var totalList = [];
  List<GetProductOrBasketStockResp> stockList = [];
  List<AddReturnProductToStockReq> returnProToStock = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.reset == true) {
      basketProduct = [];
      returnProList = [];
      getProductReturn();
      getProductOrBasketStock(GetProductOrBasketStockReq(
          cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
          cWH: 'FG',
          cSEARCH: 'PRODUCT'));
    }
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
          'รับคืนสินค้า ไม่รับ/คืน',
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
                                                        StockTransferReturnMissPro(
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
                                  StockTransferMissFilter(pageNumber: '005')));
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
    return GlobalParam.customerShowReturnProList.length != 0
        ? ListView.builder(
            itemCount: GlobalParam.customerShowReturnProList.length,
            itemBuilder: (BuildContext context, int index) {
              deController.add(new TextEditingController());
              inController.add(new TextEditingController());
              double sQty = double.parse(
                  GlobalParam.customerShowReturnProList[index].iSSIZEQTY);
              double mQty = double.parse(
                  GlobalParam.customerShowReturnProList[index].iMSIZEQTY);
              double lQty = double.parse(
                  GlobalParam.customerShowReturnProList[index].iLSIZEQTY);
              double qty = 0;
              double unitPrice = 0.0;
              String unitName = '';
              double total = 0.0;
              String size = '';

              if (sQty > 0) {
                size = 'S';
                qty = sQty;
                unitPrice = double.parse(
                    GlobalParam.customerShowReturnProList[index].iSUNITPRICE);
                unitName = GlobalParam.customerShowReturnProList[index].cSUOMNM;
                for (var k = 0; k < totalList.length; k++) {
                  if (totalList[k]['cPRODCD'] ==
                          GlobalParam
                              .customerShowReturnProList[index].cPRODCD &&
                      totalList[k]['size'] == 'S') {
                    total = totalList[k]['total'];
                  }
                }
              }
              if (mQty > 0) {
                size = 'M';
                qty = mQty;
                unitPrice = double.parse(
                    GlobalParam.customerShowReturnProList[index].iMUNITPRICE);
                unitName = GlobalParam.customerShowReturnProList[index].cMUOMNM;
                for (var k = 0; k < totalList.length; k++) {
                  if (totalList[k]['cPRODCD'] ==
                          GlobalParam
                              .customerShowReturnProList[index].cPRODCD &&
                      totalList[k]['size'] == 'M') {
                    total = totalList[k]['total'];
                  }
                }
              }
              if (lQty > 0) {
                size = 'L';
                qty = lQty;
                unitPrice = double.parse(
                    GlobalParam.customerShowReturnProList[index].iLUNITPRICE);
                unitName = GlobalParam.customerShowReturnProList[index].cLUOMNM;
                for (var k = 0; k < totalList.length; k++) {
                  if (totalList[k]['cPRODCD'] ==
                          GlobalParam
                              .customerShowReturnProList[index].cPRODCD &&
                      totalList[k]['size'] == 'L') {
                    total = totalList[k]['total'];
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
                                image: GlobalParam
                                            .customerShowReturnProList[index]
                                            .cPHOTOPATH !=
                                        ''
                                    ? DecorationImage(
                                        image: new NetworkImage(
                                          'http://${GlobalParam.customerShowReturnProList[index].cPHOTOSERV}/${GlobalParam.customerShowReturnProList[index].cPHOTOPATH}',
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
                                          .customerShowReturnProList[index]
                                          .cPRODNM,
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
                                    height: 36,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Center(
                                              child: Text(
                                                unitName,
                                                style: TextStyle(
                                                  fontFamily: 'Prompt',
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              GlobalParam
                                                      .customerShowReturnProList[
                                                          index]
                                                      .cCHECK =
                                                  !GlobalParam
                                                      .customerShowReturnProList[
                                                          index]
                                                      .cCHECK;
                                            });
                                          },
                                          child: GlobalParam
                                                      .customerShowReturnProList[
                                                          index]
                                                      .cCHECK ==
                                                  false
                                              ? Container(
                                                  width: widthScreen * 0.2,
                                                  height: 24,
                                                  decoration: BoxDecoration(
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
                                                          color: Colors.red)),
                                                  child: Center(
                                                    child: Text(
                                                      'รอนับ',
                                                      style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          fontSize: 14.0,
                                                          color: Colors.red),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: widthScreen * 0.2,
                                                  height: 24,
                                                  decoration: BoxDecoration(
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
                                                          color: Colors.green)),
                                                  child: Center(
                                                    child: Text(
                                                      'นับแล้ว',
                                                      style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          fontSize: 14.0,
                                                          color: Colors.green),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                        SizedBox(width: 8,)
                                      ],
                                    ),
                                  ),

                                  //--------------------2

                                  Container(
                                    height: 24,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Center(
                                              child: Text(
                                                'จำนวน',
                                                style: TextStyle(
                                                  fontFamily: 'Prompt',
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Center(
                                              child: Text(
                                                'ขาด',
                                                style: TextStyle(
                                                  fontFamily: 'Prompt',
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Center(
                                              child: Text(
                                                'เกิน',
                                                style: TextStyle(
                                                  fontFamily: 'Prompt',
                                                  color: Colors.green,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
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
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            height: 30.0,
                                            width: 80.0,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade400,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                                bottomLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
                                              ),
                                              border: Border.all(
                                                  color: Colors.grey),
                                            ),
                                            child: Center(
                                              child: Text(
                                                qty.toStringAsFixed(0),
                                                style: TextStyle(
                                                    fontFamily: 'Prompt',
                                                    fontSize: 14.0,
                                                    color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            height: 30.0,
                                            width: 80.0,
                                            decoration: BoxDecoration(
                                              color: GlobalParam
                                                          .customerShowReturnProList[
                                                              index]
                                                          .cDCUL ==
                                                      true
                                                  ? Colors.white
                                                  : Colors.grey.shade400,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                                bottomLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
                                              ),
                                              border: Border.all(
                                                  color: Colors.grey),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 8, 0, 0),
                                              child: TextField(
                                                enabled: GlobalParam
                                                    .customerShowReturnProList[
                                                        index]
                                                    .cDCUL,
                                                controller: deController[index],
                                                onChanged: (value) {
                                                  addValue(
                                                      size,
                                                      value,
                                                      GlobalParam
                                                              .customerShowReturnProList[
                                                          index],
                                                      'decrease',
                                                      index);
                                                  if (value != '' &&
                                                      value != null) {
                                                    total += double.parse(
                                                            GlobalParam
                                                                .customerShowReturnProList[
                                                                    index]
                                                                .iMUNITPRICE) *
                                                        double.parse(value);
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: HexColor('#00cb39'),
                                                  fontFamily: 'Prompt',
                                                ),
                                                cursorColor: Colors.black,
                                                decoration: new InputDecoration(
                                                  //hintText: "1",
                                                  hintStyle: TextStyle(
                                                      color:
                                                          HexColor('#00cb39')),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
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
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            height: 30.0,
                                            width: 80.0,
                                            decoration: BoxDecoration(
                                              color: GlobalParam
                                                          .customerShowReturnProList[
                                                              index]
                                                          .cICUL ==
                                                      true
                                                  ? Colors.white
                                                  : Colors.grey.shade400,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                                bottomLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
                                              ),
                                              border: Border.all(
                                                  color: Colors.grey),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 8, 0, 0),
                                                child: TextField(
                                                  enabled: GlobalParam
                                                      .customerShowReturnProList[
                                                          index]
                                                      .cICUL,
                                                  controller:
                                                      inController[index],
                                                  onChanged: (value) {
                                                    addValue(
                                                        size,
                                                        value,
                                                        GlobalParam
                                                                .customerShowReturnProList[
                                                            index],
                                                        'increase',
                                                        index);
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: HexColor('#00cb39'),
                                                    fontFamily: 'Prompt',
                                                  ),
                                                  cursorColor: Colors.black,
                                                  decoration:
                                                      new InputDecoration(
                                                    //hintText: "1",
                                                    hintStyle: TextStyle(
                                                        color: HexColor(
                                                            '#00cb39')),
                                                    border: InputBorder.none,
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
                                        ),
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
                            Container(
                              width: widthScreen * 0.24,
                              child: Text(
                                'ต่อหน่วย ',
                                style: TextStyle(
                                    fontFamily: 'Prompt', fontSize: 14),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Container(
                              width: widthScreen * 0.2,
                              child: Text(
                                '${formatNum.format(unitPrice)} ฿',
                                style: TextStyle(
                                    fontFamily: 'Prompt', fontSize: 14),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Container(
                              width: widthScreen * 0.1,
                              child: Text(
                                'รวม',
                                style: TextStyle(
                                    fontFamily: 'Prompt', fontSize: 14),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Container(
                              width: widthScreen * 0.24,
                              child: Text(
                                '${formatNum.format(total)} ฿',
                                style: TextStyle(
                                    fontFamily: 'Prompt', fontSize: 14),
                                textAlign: TextAlign.right,
                              ),
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
    orderList.addAll(GlobalParam.customerReturnProList);
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
                    // if (basketProduct.length > 0) {
                    //   addReturnHD();
                    // } else {
                    addStockCard();
                    addReturnProductToStock();

                    // }
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
                          'บันทึกรับคืนสินค้า ไม่รับ/คืน',
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

  getProductReturn() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var outputFormat = DateFormat('yyyy-MM-dd');
      var outputDate = outputFormat.format(new DateTime.now());
      var result = await proxy.getProductReturn(GetProductReturnReq(
          cBRANCD: GlobalParam.VEHICLE['cBRANCD'], dCREADT: outputDate));

      if (result.isNotEmpty) {
        setState(() {
          returnProList.addAll(result);
        });
        getProductBranch(GetProductBranchReq(
          cBRANCD: GlobalParam.customer['cBRANCD'],
          cCUSTTYPE: GlobalParam.customer['cCUSTTYPE'],
          cPRICECD: GlobalParam.customer['cPRICECD'],
          cPRODCD: "%%",
          cPRODNM: "%%",
        ));
      }
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
      GlobalParam.customerReturnProList = [];
      GlobalParam.customerShowReturnProList = [];

      if (result.isNotEmpty) {
        // GlobalParam.customerReturnProList.addAll(result);
        // GlobalParam.customerShowReturnProList.addAll(result);
        for (var i = 0; i < result.length; i++) {
          for (var j = 0; j < returnProList.length; j++) {
            if (result[i].cPRODCD == returnProList[j].cPRODCD) {
              result[i].cRETCD = returnProList[j].cPOCD;
              if (returnProList[j].cUOMCD == result[i].cSUOMCD) {
                GetProductBranchResp proData = GetProductBranchResp(
                    cPRODCD: result[i].cPRODCD,
                    cPRODNM: result[i].cPRODNM,
                    cTYPE: result[i].cTYPE,
                    cTYPENM: result[i].cTYPENM,
                    cCATECD: result[i].cCATECD,
                    cCATENM: result[i].cCATENM,
                    cSUBCATECD: result[i].cSUBCATECD,
                    cSUBCATENM: result[i].cSUBCATENM,
                    cBRNDCD: result[i].cBRNDCD,
                    cBRNDNM: result[i].cBRNDCD,
                    iSSIZEQTY: "${returnProList[j].iQTY}",
                    iMSIZEQTY: "0.00",
                    iLSIZEQTY: "0.00",
                    cSUOMCD: result[i].cSUOMCD,
                    cSUOMNM: result[i].cSUOMNM,
                    cMUOMCD: "",
                    cMUOMNM: "",
                    cLUOMCD: "",
                    cLUOMNM: "",
                    iSUNITPRICE: result[i].iSUNITPRICE,
                    iMUNITPRICE: "0.00",
                    iLUNITPRICE: "0.00",
                    cCUSTTYPE: result[i].cCUSTTYPE,
                    cISSSIZE: result[i].cISSSIZE,
                    cISMSIZE: result[i].cISMSIZE,
                    cISLSIZE: result[i].cISLSIZE,
                    cPHOTOSERV: result[i].cPHOTOSERV,
                    cPHOTOPATH: result[i].cPHOTOPATH,
                    cPHOTONM: result[i].cPHOTONM,
                    cSUPCD: result[i].cSUPCD,
                    cRETCD: returnProList[j].cPOCD,
                    cCHECK: false,
                    cICUL: true,
                    cDCUL: true);
                GlobalParam.customerShowReturnProList.add(proData);
                var data = {
                  "cPRODCD": result[i].cPRODCD,
                  "total": 0.0,
                  "size": 'S',
                };
                totalList.add(data);
                AddReturnProductToStockReq proReturn =
                    AddReturnProductToStockReq(
                  cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                  cREFDOC: returnProList[j].cPOCD,
                  iSEQ: j + 1,
                  cRETYP: "RR",
                  cGRPCD: GlobalParam.stockTransferReq.cGRPCD,
                  cRTECD: GlobalParam.stockTransferReq.cRTECD,
                  cPRODCD: proData.cPRODCD,
                  cSIZE: "S",
                  cUOMCD: proData.cSUOMCD,
                  cUOMNM: proData.cSUOMNM,
                  iUNITPRICE: proData.iSUNITPRICE,
                  iQTY: '${returnProList[j].iQTY}',
                  iTRUEQTY: '${returnProList[j].iQTY}',
                  cWH: "RR",
                  cCREABY: GlobalParam.userData.cUSRNM,
                );

                returnProToStock.add(proReturn);
              }
              if (returnProList[j].cUOMCD == result[i].cMUOMCD) {
                GetProductBranchResp proData = GetProductBranchResp(
                    cPRODCD: result[i].cPRODCD,
                    cPRODNM: result[i].cPRODNM,
                    cTYPE: result[i].cTYPE,
                    cTYPENM: result[i].cTYPENM,
                    cCATECD: result[i].cCATECD,
                    cCATENM: result[i].cCATENM,
                    cSUBCATECD: result[i].cSUBCATECD,
                    cSUBCATENM: result[i].cSUBCATENM,
                    cBRNDCD: result[i].cBRNDCD,
                    cBRNDNM: result[i].cBRNDCD,
                    iSSIZEQTY: "0.00",
                    iMSIZEQTY: "${returnProList[j].iQTY}",
                    iLSIZEQTY: "0.00",
                    cSUOMCD: '',
                    cSUOMNM: '',
                    cMUOMCD: result[i].cMUOMCD,
                    cMUOMNM: result[i].cMUOMNM,
                    cLUOMCD: "",
                    cLUOMNM: "",
                    iSUNITPRICE: "0.00",
                    iMUNITPRICE: result[i].iMUNITPRICE,
                    iLUNITPRICE: "0.00",
                    cCUSTTYPE: result[i].cCUSTTYPE,
                    cISSSIZE: result[i].cISSSIZE,
                    cISMSIZE: result[i].cISMSIZE,
                    cISLSIZE: result[i].cISLSIZE,
                    cPHOTOSERV: result[i].cPHOTOSERV,
                    cPHOTOPATH: result[i].cPHOTOPATH,
                    cPHOTONM: result[i].cPHOTONM,
                    cSUPCD: result[i].cSUPCD,
                    cRETCD: returnProList[j].cPOCD,
                    cCHECK: false,
                    cICUL: true,
                    cDCUL: true);
                GlobalParam.customerShowReturnProList.add(proData);
                var data = {
                  "cPRODCD": result[i].cPRODCD,
                  "total": 0.0,
                  "size": 'L',
                };
                totalList.add(data);
                AddReturnProductToStockReq proReturn =
                    AddReturnProductToStockReq(
                  cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                  cREFDOC: returnProList[j].cPOCD,
                  iSEQ: j + 1,
                  cRETYP: "RR",
                  cGRPCD: GlobalParam.stockTransferReq.cGRPCD,
                  cRTECD: GlobalParam.stockTransferReq.cRTECD,
                  cPRODCD: proData.cPRODCD,
                  cSIZE: "M",
                  cUOMCD: proData.cMUOMCD,
                  cUOMNM: proData.cMUOMNM,
                  iUNITPRICE: proData.iMUNITPRICE,
                  iQTY: '${returnProList[j].iQTY}',
                  iTRUEQTY: '${returnProList[j].iQTY}',
                  cWH: "RR",
                  cCREABY: GlobalParam.userData.cUSRNM,
                );

                returnProToStock.add(proReturn);
              }
              if (returnProList[j].cUOMCD == result[i].cLUOMCD) {
                GetProductBranchResp proData = GetProductBranchResp(
                    cPRODCD: result[i].cPRODCD,
                    cPRODNM: result[i].cPRODNM,
                    cTYPE: result[i].cTYPE,
                    cTYPENM: result[i].cTYPENM,
                    cCATECD: result[i].cCATECD,
                    cCATENM: result[i].cCATENM,
                    cSUBCATECD: result[i].cSUBCATECD,
                    cSUBCATENM: result[i].cSUBCATENM,
                    cBRNDCD: result[i].cBRNDCD,
                    cBRNDNM: result[i].cBRNDCD,
                    iSSIZEQTY: "0.00",
                    iMSIZEQTY: "0.00",
                    iLSIZEQTY: "${returnProList[j].iQTY}",
                    cSUOMCD: '',
                    cSUOMNM: '',
                    cMUOMCD: '',
                    cMUOMNM: '',
                    cLUOMCD: result[i].cLUOMCD,
                    cLUOMNM: result[i].cLUOMNM,
                    iSUNITPRICE: "0.00",
                    iMUNITPRICE: "0.00",
                    iLUNITPRICE: result[i].iLUNITPRICE,
                    cCUSTTYPE: result[i].cCUSTTYPE,
                    cISSSIZE: result[i].cISSSIZE,
                    cISMSIZE: result[i].cISMSIZE,
                    cISLSIZE: result[i].cISLSIZE,
                    cPHOTOSERV: result[i].cPHOTOSERV,
                    cPHOTOPATH: result[i].cPHOTOPATH,
                    cPHOTONM: result[i].cPHOTONM,
                    cSUPCD: result[i].cSUPCD,
                    cRETCD: returnProList[j].cPOCD,
                    cCHECK: false,
                    cICUL: true,
                    cDCUL: true);
                GlobalParam.customerShowReturnProList.add(proData);
                var data = {
                  "cPRODCD": result[i].cPRODCD,
                  "total": 0.0,
                  "size": 'L',
                };
                totalList.add(data);
                AddReturnProductToStockReq proReturn =
                    AddReturnProductToStockReq(
                  cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                  cREFDOC: returnProList[j].cPOCD,
                  iSEQ: j + 1,
                  cRETYP: "RR",
                  cGRPCD: GlobalParam.stockTransferReq.cGRPCD,
                  cRTECD: GlobalParam.stockTransferReq.cRTECD,
                  cPRODCD: proData.cPRODCD,
                  cSIZE: "L",
                  cUOMCD: proData.cLUOMCD,
                  cUOMNM: proData.cLUOMNM,
                  iUNITPRICE: proData.iLUNITPRICE,
                  iQTY: '${returnProList[j].iQTY}',
                  iTRUEQTY: '${returnProList[j].iQTY}',
                  cWH: "RR",
                  cCREABY: GlobalParam.userData.cUSRNM,
                );

                returnProToStock.add(proReturn);
              }
            }
          }
          GlobalParam.customerReturnProList.add(result[i]);
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
      GlobalParam.customerShowReturnProList = [];

      if (result.isNotEmpty) {
        GlobalParam.customerShowReturnProList = [];
        for (var i = 0; i < result.length; i++) {
          for (var j = 0; j < returnProList.length; j++) {
            if (result[i].cPRODCD == returnProList[j].cPRODCD) {
              GlobalParam.customerShowReturnProList.add(result[i]);
            }
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

  addStockCard() async {
    // print(
    //     '**********${GlobalParam.deliveryPodtList.length} : ${GlobalParam.deliveryHisProduct.length}************');
    try {
      List<StockCardReq> stockCardReqList = [];
      List<GetProductBranchResp> productReturn = [];
      productReturn.addAll(GlobalParam.customerReturnProList);
      for (int i = 0; i < productReturn.length; i++) {
        double sQty = double.parse(productReturn[i].iSSIZEQTY);
        double mQty = double.parse(productReturn[i].iMSIZEQTY);
        double lQty = double.parse(productReturn[i].iLSIZEQTY);
        double sPrice = double.parse(productReturn[i].iSUNITPRICE);
        double mPrice = double.parse(productReturn[i].iMUNITPRICE);
        double lPrice = double.parse(productReturn[i].iLUNITPRICE);
        if ((sQty + mQty + lQty) > 0) {
          if (sQty > 0) {
            StockCardReq transferOut = StockCardReq(
                cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                cPRODCD: productReturn[i].cPRODCD,
                cUOMCD: productReturn[i].cSUOMCD,
                cWH: 'TRR',
                cREFDOC: productReturn[0].cRETCD,
                iRECEIVEQTY: '0',
                iISSUEQTY: '$sQty',
                cREMARK: 'transfer stock to branch stock',
                cLOTNO: '',
                cCREABY: GlobalParam.userID);

            StockCardReq branchIn = StockCardReq(
                cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                cPRODCD: productReturn[i].cPRODCD,
                cUOMCD: productReturn[i].cSUOMCD,
                cWH: 'FG',
                cREFDOC: productReturn[0].cRETCD,
                iRECEIVEQTY: '$sQty',
                iISSUEQTY: '0',
                cREMARK: 'transfer stock to branch stock',
                cLOTNO: '',
                cCREABY: GlobalParam.userID);

            stockCardReqList.add(transferOut);
            stockCardReqList.add(branchIn);
          }

          if (mQty > 0) {
            StockCardReq transferOut = StockCardReq(
                cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                cPRODCD: productReturn[i].cPRODCD,
                cUOMCD: productReturn[i].cMUOMCD,
                cWH: 'TRR',
                cREFDOC: productReturn[0].cRETCD,
                iRECEIVEQTY: '0',
                iISSUEQTY: '$mQty',
                cREMARK: 'transfer stock to branch stock',
                cLOTNO: '',
                cCREABY: GlobalParam.userID);

            StockCardReq branchIn = StockCardReq(
                cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                cPRODCD: productReturn[i].cPRODCD,
                cUOMCD: productReturn[i].cMUOMCD,
                cWH: 'FG',
                cREFDOC: productReturn[0].cRETCD,
                iRECEIVEQTY: '$mQty',
                iISSUEQTY: '0',
                cREMARK: 'transfer stock to branch stock',
                cLOTNO: '',
                cCREABY: GlobalParam.userID);

            stockCardReqList.add(transferOut);
            stockCardReqList.add(branchIn);
          }

          if (lQty > 0) {
            StockCardReq transferOut = StockCardReq(
                cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                cPRODCD: productReturn[i].cPRODCD,
                cUOMCD: productReturn[i].cLUOMCD,
                cWH: 'TRR',
                cREFDOC: productReturn[0].cRETCD,
                iRECEIVEQTY: '0',
                iISSUEQTY: '$lQty',
                cREMARK: 'transfer stock to branch stock',
                cLOTNO: '',
                cCREABY: GlobalParam.userID);

            StockCardReq branchIn = StockCardReq(
                cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                cPRODCD: productReturn[i].cPRODCD,
                cUOMCD: productReturn[i].cLUOMCD,
                cWH: 'FG',
                cREFDOC: productReturn[0].cRETCD,
                iRECEIVEQTY: '$lQty',
                iISSUEQTY: '0',
                cREMARK: 'transfer stock to branch stock',
                cLOTNO: '',
                cCREABY: GlobalParam.userID);

            stockCardReqList.add(transferOut);
            stockCardReqList.add(branchIn);
          }
        }
      }

      AllApiProxyMobile proxy = AllApiProxyMobile();
      var check = 0;
      for (int i = 0; i < stockCardReqList.length; i++) {
        check++;
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
      // GlobalParam.deliveryRegetPODT = true;
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (comtext) =>
      //         DeliveryImageProduct(GlobalParam.typeMenuCode)));
      // if (check == stockCardReqList.length) {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => StockTransferBasketReturn()));
      // }

      // setState(() {});
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
              cRETYP: 'BDPTS',
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
                builder: (context) => StockReturnImage('02', cRETCD)));
          }
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StockReturnImage('02', cRETCD)));
        }
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StockReturnImage('02', cRETCD)));
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
        addStockCard();
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
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

  addReturnProductToStock() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var check = 0;
      for (int i = 0; i < returnProToStock.length; i++) {
        returnProToStock[i].iSEQ = i + 1;
        var result = await proxy.addReturnProductToStock(returnProToStock[i]);
        if (result.success == false) {
          wrongDialog('${result.message}');
        } else {
          check++;
        }
      }

      if (check == returnProToStock.length) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StockTransferReturnGoodPro(true)));
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  addValue(String size, String value, GetProductBranchResp product, String type,
      int index) {
    bool proRepeat = false;
    for (var i = 0; i < GlobalParam.customerReturnProList.length; i++) {
      if (product.cPRODCD == GlobalParam.customerReturnProList[i].cPRODCD) {
        if (value != '') {
          if (size == "S") {
            GlobalParam.customerReturnProList[i].iSSIZEQTY = value;
          }
          if (size == "M") {
            GlobalParam.customerReturnProList[i].iMSIZEQTY = value;
          }
          if (size == "L") {
            GlobalParam.customerReturnProList[i].iLSIZEQTY = value;
          }
        } else {
          if (size == "S") {
            GlobalParam.customerReturnProList[i].iSSIZEQTY = '0.0';
          }
          if (size == "M") {
            GlobalParam.customerReturnProList[i].iMSIZEQTY = '0.0';
          }
          if (size == "L") {
            GlobalParam.customerReturnProList[i].iLSIZEQTY = '0.0';
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
              basketProduct.add(GlobalParam.customerReturnProList[i]);
            }
          }
        } else {
          basketProduct.add(GlobalParam.customerReturnProList[i]);
        }

        for (var k = 0; k < totalList.length; k++) {
          double sQty =
              double.parse(GlobalParam.customerReturnProList[i].iSSIZEQTY);
          double mQty =
              double.parse(GlobalParam.customerReturnProList[i].iMSIZEQTY);
          double lQty =
              double.parse(GlobalParam.customerReturnProList[i].iLSIZEQTY);
          double sPrice =
              double.parse(GlobalParam.customerReturnProList[i].iSUNITPRICE);
          double mPrice =
              double.parse(GlobalParam.customerReturnProList[i].iMUNITPRICE);
          double lPrice =
              double.parse(GlobalParam.customerReturnProList[i].iLUNITPRICE);
          if (totalList[k]['cPRODCD'] ==
                  GlobalParam.customerReturnProList[i].cPRODCD &&
              totalList[k]['size'] == size) {
            totalList[k]['total'] =
                (sQty * sPrice) + (mQty * mPrice) + (lQty * lPrice);
          }
        }
      }
    }

    for (int i = 0; i < returnProToStock.length; i++) {
      if (returnProToStock[i].cPRODCD == product.cPRODCD) {
        if (returnProToStock[i].cSIZE == size) {
          if (value == '' || value == null) {
            value = '0.0';
          }
          if (type == 'increase') {
            if (value == '0.0') {
              GlobalParam.customerShowReturnProList[index].cICUL = true;
              GlobalParam.customerShowReturnProList[index].cDCUL = true;
            } else {
              GlobalParam.customerShowReturnProList[index].cDCUL = false;
            }
            returnProToStock[i].iTRUEQTY =
                '${double.parse(returnProToStock[i].iQTY) + double.parse(value)}';
          } else if (type == 'decrease') {
            if (value == '0.0') {
              GlobalParam.customerShowReturnProList[index].cICUL = true;
              GlobalParam.customerShowReturnProList[index].cDCUL = true;
            } else {
              GlobalParam.customerShowReturnProList[index].cICUL = false;
            }
            returnProToStock[i].iTRUEQTY =
                '${double.parse(returnProToStock[i].iQTY) - double.parse(value)}';
          }
        }
      }
    }
    setState(() {});
  }
}
