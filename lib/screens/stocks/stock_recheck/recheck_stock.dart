import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addCustomerOrderReq.dart';
import 'package:vansale/api/class/request/mobile/addRecheckStockProductReq.dart';
import 'package:vansale/api/class/request/mobile/addReturnDTReq.dart';
import 'package:vansale/api/class/request/mobile/addReturnHDReq.dart';
import 'package:vansale/api/class/request/mobile/addStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/getProductBranchReq.dart';
import 'package:vansale/api/class/request/mobile/getProductOrBasketStockReq.dart';
import 'package:vansale/api/class/request/mobile/getProductSalePriceResp.dart';
import 'package:vansale/api/class/response/routeMobile/getBranchAllResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductBranchResp.dart';
import 'package:vansale/api/class/response/routeMobile/getProductOrBasketStockResp.dart';
import 'package:vansale/function/substring_price.dart';

import 'package:vansale/screens/customer_menu/customer_purchase/customerConfirm.dart';
import 'package:vansale/screens/customer_menu/custommer_Order/customer_order_filter.dart';
import 'package:vansale/screens/delivery/delivery_scanner.dart';
import 'package:vansale/screens/home/home.dart';
// import 'package:vansale/screens/stocks/stock_recheck/StockPrinter.dart';
import 'package:vansale/screens/stocks/stoeck_return/stock_return_img.dart';
import 'package:pdf/Widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class RecheckProductStock extends StatefulWidget {
  //const MoreItem({ Key? key }) : super(key: key);
  final String typeMenuCode;
  final bool reset;
  RecheckProductStock(this.typeMenuCode, this.reset);
  @override
  _RecheckProductStockState createState() => _RecheckProductStockState();
}

class _RecheckProductStockState extends State<RecheckProductStock> {
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
  List<GetProductSalePriceResp> priceTable = [];
  int isCheck = 0;
  var productCheck = [];
  List<AddRecheckStockProductReq> reqRecheckStock = [];
  List<GetBranchAllResp> branchList = [];
  GetBranchAllResp branch = GetBranchAllResp();
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

    getBranchAll();
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
          'นับสต๊อกสินค้า',
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
                                                        RecheckProductStock(
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
    return GlobalParam.customerShowRecheckPROStockList.length != 0
        ? ListView.builder(
            itemCount: GlobalParam.customerShowRecheckPROStockList.length,
            itemBuilder: (BuildContext context, int index) {
              sController.add(new TextEditingController());
              mController.add(new TextEditingController());
              lController.add(new TextEditingController());
              double unitPrice = 0.0;
              double total = 0.0;
              double minusTotal = 0.0;

              for (var k = 0; k < priceTable.length; k++) {
                if (priceTable[k].cPRODCD ==
                    GlobalParam
                        .customerShowRecheckPROStockList[index].cPRODCD) {
                  unitPrice = double.parse(priceTable[k].iCOSTVAT);
                }
              }

              for (var k = 0; k < totalList.length; k++) {
                if (totalList[k]['cPRODCD'] ==
                    GlobalParam
                        .customerShowRecheckPROStockList[index].cPRODCD) {
                  total = totalList[k]['netTotal'];
                  if (totalList[k]['netTotal'] < 0) {
                    var num = totalList[k]['netTotal'].toString();
                    var list = num.split('-');
                    minusTotal = double.parse(list[1]);
                  }
                }
              }

              double stockS = 0.0;
              double stockM = 0.0;
              double stockL = 0.0;
              for (var k = 0; k < stockList.length; k++) {
                if (stockList[k].cPRODCD ==
                    GlobalParam
                        .customerShowRecheckPROStockList[index].cPRODCD) {
                  if (stockList[k].cUOMCD ==
                      GlobalParam
                          .customerShowRecheckPROStockList[index].cSUOMCD) {
                    stockS = double.parse(stockList[k].iPROQTY);
                  }
                  if (stockList[k].cUOMCD ==
                      GlobalParam
                          .customerShowRecheckPROStockList[index].cMUOMCD) {
                    stockM = double.parse(stockList[k].iPROQTY);
                  }
                  if (stockList[k].cUOMCD ==
                      GlobalParam
                          .customerShowRecheckPROStockList[index].cLUOMCD) {
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
                                image: GlobalParam
                                            .customerShowRecheckPROStockList[
                                                index]
                                            .cPHOTOPATH !=
                                        ''
                                    ? DecorationImage(
                                        image: new NetworkImage(
                                          'http://${GlobalParam.customerShowRecheckPROStockList[index].cPHOTOSERV}/${GlobalParam.customerShowRecheckPROStockList[index].cPHOTOPATH}',
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
                                          .customerShowRecheckPROStockList[
                                              index]
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
                                  Row(
                                    children: [
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
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          checkProduct(
                                              GlobalParam
                                                      .customerShowRecheckPROStockList[
                                                  index],
                                              index);
                                        },
                                        child: GlobalParam
                                                    .customerShowRecheckPROStockList[
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
                                    ],
                                  ),
                                  Container(
                                    height: 36,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GlobalParam
                                                    .customerShowRecheckPROStockList[
                                                        index]
                                                    .cISLSIZE ==
                                                'Y'
                                            ? Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Center(
                                                    child: Text(
                                                      GlobalParam
                                                          .customerShowRecheckPROStockList[
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
                                        GlobalParam
                                                    .customerShowRecheckPROStockList[
                                                        index]
                                                    .cISMSIZE ==
                                                'Y'
                                            ? Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Center(
                                                    child: Text(
                                                      GlobalParam
                                                          .customerShowRecheckPROStockList[
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
                                        GlobalParam
                                                    .customerShowRecheckPROStockList[
                                                        index]
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
                                                          .customerShowRecheckPROStockList[
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
                                        GlobalParam
                                                    .customerShowRecheckPROStockList[
                                                        index]
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
                                                                    .customerShowRecheckPROStockList[
                                                                index]);
                                                        if (value != '' &&
                                                            value != null) {
                                                          total += double.parse(
                                                                  GlobalParam
                                                                      .customerShowRecheckPROStockList[
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
                                        GlobalParam
                                                    .customerShowRecheckPROStockList[
                                                        index]
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
                                                                    .customerShowRecheckPROStockList[
                                                                index]);
                                                        if (value != '' &&
                                                            value != null) {
                                                          total += double.parse(
                                                                  GlobalParam
                                                                      .customerShowRecheckPROStockList[
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
                                        GlobalParam
                                                    .customerShowRecheckPROStockList[
                                                        index]
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
                                                                      .customerShowRecheckPROStockList[
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
                            Container(
                              width: widthScreen * 0.3,
                              child: Text(
                                'ต่อหน่วย ${formatNum.format(unitPrice)} ฿',
                                style: TextStyle(
                                    fontFamily: 'Prompt', fontSize: 14),
                              ),
                            ),
                            total == 0
                                ? Container(
                                    width: widthScreen * 0.3,
                                    child: Text(
                                      '',
                                      style: TextStyle(
                                          fontFamily: 'Prompt',
                                          fontSize: 14,
                                          color: Colors.green),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                : total > 0
                                    ? Container(
                                        width: widthScreen * 0.3,
                                        child: Text(
                                          '${formatNum.format(total)} เกิน',
                                          style: TextStyle(
                                              fontFamily: 'Prompt',
                                              fontSize: 14,
                                              color: Colors.green),
                                          textAlign: TextAlign.right,
                                        ),
                                      )
                                    : Container(
                                        width: widthScreen * 0.3,
                                        child: Text(
                                          '${formatNum.format(minusTotal)} ขาด',
                                          style: TextStyle(
                                              fontFamily: 'Prompt',
                                              fontSize: 14,
                                              color: Colors.red),
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
    orderList.addAll(GlobalParam.customerRecheckPROStockList);
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

    double netTotal = 0.0;
    for (var j = 0; j < totalList.length; j++) {
      netTotal += totalList[j]['price'] * totalList[j]['netTotal'];
    }

    return Container(
      height: 148.0,
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
                          fontSize: 14.0,
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
            Container(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
              child: Row(
                children: [
                  Container(
                      width: widthScreen * 0.46,
                      height: 24,
                      child: Text(
                        'นับแล้ว ${isCheck} รายการ',
                        style: TextStyle(
                          fontSize: 14.0,
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
                        'รอนับ ${GlobalParam.customerRecheckPROStockList.length - isCheck} รายการ',
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
                      'รวมเป็นเงิน ขาด/เกิน',
                      style: TextStyle(
                        fontSize: 14.0,
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
                      '${netTotal.toStringAsFixed(2)}',
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
                Spacer(),
                InkWell(
                  onTap: () {
                    addRecheckStockProduct();
                    // generatePdf();
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
                          'บันทึกนับสต๊อกสินค้า',
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
                Spacer(),
                InkWell(
                  onTap: () {
                    setState(() {
                      GlobalParam.customerShowRecheckPROStockList.sort((a, b) =>
                          a.cCHECK.toString().compareTo(b.cCHECK.toString()));
                    });
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child: Icon(
                              LineAwesomeIcons.filter,
                              color: Colors.red,
                              size: 25.0,
                            )),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'สินค้ารอนับ',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.red,
                            fontFamily: 'Prompt',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
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

  getProductOrBasketStock(GetProductOrBasketStockReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getProductOrBasketStock(req);

      if (result.isNotEmpty) {
        setState(() {
          stockList = [];
          stockList.addAll(result);
        });
        for (var i = 0; i < result.length; i++) {
          for (var j = 0;
              j < GlobalParam.customerRecheckPROStockList.length;
              j++) {
            if (GlobalParam.customerRecheckPROStockList[j].cPRODCD ==
                result[i].cPRODCD) {
              var data = AddRecheckStockProductReq(
                cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                cWH: "FG",
                cPRODCD: GlobalParam.customerRecheckPROStockList[j].cPRODCD,
                cUOMCD: result[i].cUOMCD,
                cPRODNM: GlobalParam.customerRecheckPROStockList[j].cPRODNM,
                cTYPE: GlobalParam.customerRecheckPROStockList[j].cTYPE,
                cCATECD: GlobalParam.customerRecheckPROStockList[j].cCATECD,
                cSUBCATECD:
                    GlobalParam.customerRecheckPROStockList[j].cSUBCATECD,
                cBRNDCD: GlobalParam.customerRecheckPROStockList[j].cBRNDCD,
                iSTCQTY: double.parse(result[i].iPROQTY),
                iSTCWEIGHT: double.parse(result[i].iWEIGHT),
                iRECQTY: 0,
                iRECWEIGHT: 0,
                cSALETYPE: "Q",
                cCREABY: GlobalParam.userData.cUSRNM,
              );
              reqRecheckStock.add(data);
            }
          }
        }
        getProductSalePrice();
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getProductSalePrice() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getProductSalePrice();

      if (result.isNotEmpty) {
        for (var i = 0; i < result.length; i++) {
          for (var j = 0; j < totalList.length; j++) {
            double sQty = 0;
            double mQty = 0;
            double lQty = 0;

            double unitPrice = 0;
            if (totalList[j]['cPRODCD'] == result[i].cPRODCD) {
              unitPrice = double.parse(result[i].iCOSTVAT);
              totalList[j]['price'] = unitPrice;
              for (var k = 0; k < result[i].tPRICEDT.length; k++) {
                if (result[i].tPRICEDT[k].cTYPE == 'L') {
                  lQty = double.parse(result[i].tPRICEDT[k].iQTY);
                }
                if (result[i].tPRICEDT[k].cTYPE == 'M') {
                  mQty = double.parse(result[i].tPRICEDT[k].iQTY);
                }
                if (result[i].tPRICEDT[k].cTYPE == 'S') {
                  sQty = double.parse(result[i].tPRICEDT[k].iQTY);
                }
              }

              for (var l = 0;
                  l < GlobalParam.customerShowRecheckPROStockList.length;
                  l++) {
                double stockS = 0.0;
                double stockM = 0.0;
                double stockL = 0.0;
                for (var k = 0; k < stockList.length; k++) {
                  if (stockList[k].cPRODCD ==
                      GlobalParam.customerShowRecheckPROStockList[l].cPRODCD) {
                    if (stockList[k].cUOMCD ==
                        GlobalParam
                            .customerShowRecheckPROStockList[l].cSUOMCD) {
                      stockS = double.parse(stockList[k].iPROQTY);
                    }
                    if (stockList[k].cUOMCD ==
                        GlobalParam
                            .customerShowRecheckPROStockList[l].cMUOMCD) {
                      stockM = double.parse(stockList[k].iPROQTY);
                    }
                    if (stockList[k].cUOMCD ==
                        GlobalParam
                            .customerShowRecheckPROStockList[l].cLUOMCD) {
                      stockL = double.parse(stockList[k].iPROQTY);
                    }
                  }
                }
                if (GlobalParam.customerShowRecheckPROStockList[l].cPRODCD ==
                    totalList[j]['cPRODCD']) {
                  totalList[j]['total'] =
                      (sQty * stockS) + (mQty * stockM) + (lQty * stockL);
                }
              }
            }
          }
        }
        setState(() {
          priceTable = [];
          priceTable.addAll(result);
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
      GlobalParam.customerRecheckPROStockList = [];
      GlobalParam.customerShowRecheckPROStockList = [];

      if (result.isNotEmpty) {
        if (widget.reset == true) {
          for (var i = 0; i < result.length; i++) {
            GlobalParam.customerRecheckPROStockList.add(result[i]);
            productCheck.add({"cPRODCD": result[i].cPRODCD, "check": false});
          }
        }

        // GlobalParam.customerShowRecheckPROStockList.addAll(result);
        for (var i = 0; i < result.length; i++) {
          GlobalParam.customerShowRecheckPROStockList.add(result[i]);
          var data = {
            "cPRODCD": result[i].cPRODCD,
            "total": 0.0,
            "checkTotal": 0.0,
            "netTotal": 0.0,
            'price': 0.0
          };
          totalList.add(data);
        }
        for (var i = 0;
            i < GlobalParam.customerShowRecheckPROStockList.length;
            i++) {
          GlobalParam.customerShowRecheckPROStockList[i].cCHECK = false;
        }
      }
      getProductOrBasketStock(GetProductOrBasketStockReq(
          cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
          cWH: 'FG',
          cSEARCH: 'PRODUCT'));

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
      GlobalParam.customerShowRecheckPROStockList = [];
      if (result.isNotEmpty) {
        GlobalParam.customerShowRecheckPROStockList = [];
        for (var i = 0; i < result.length; i++) {
          GlobalParam.customerShowRecheckPROStockList.add(result[i]);
        }
        for (var i = 0;
            i < GlobalParam.customerShowRecheckPROStockList.length;
            i++) {
          GlobalParam.customerShowRecheckPROStockList[i].cCHECK = false;
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

  addRecheckStockProduct() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var loopCheck = 0;
      for (var i = 0; i < reqRecheckStock.length; i++) {
        loopCheck++;

        var result = await proxy.addRecheckStockProduct(reqRecheckStock[i]);

        if (result.success == false) {
          wrongDialog('${result.message}');
        } else {
          addStockCard(result.result, reqRecheckStock[i]);
        }
      }

      if (loopCheck == reqRecheckStock.length) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePage(GlobalParam.typeMenuCode)));
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }

  addStockCard(String cREFDOC, AddRecheckStockProductReq data) async {
    // print(
    //     '**********${GlobalParam.deliveryPodtList.length} : ${basketProduct.length}************');
    try {
      StockCardReq recheckStock = StockCardReq(
          cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
          cPRODCD: data.cPRODCD,
          cUOMCD: data.cUOMCD,
          cWH: 'FG',
          cREFDOC: cREFDOC,
          iRECEIVEQTY: '0',
          iISSUEQTY: '0',
          cREMARK: 'Recheck Stock',
          cLOTNO: '',
          cCREABY: data.cCREABY);

      double stock = 0.0;
      for (var k = 0; k < stockList.length; k++) {
        if (stockList[k].cPRODCD == data.cPRODCD) {
          if (stockList[k].cUOMCD == data.cUOMCD) {
            stock = double.parse(stockList[k].iPROQTY);
          }
        }
      }
      if (data.iRECQTY == 0) {
        recheckStock.iRECEIVEQTY = '0';
        recheckStock.iISSUEQTY = '${stock.toStringAsFixed(0)}';
      } else {
        if ((data.iRECQTY - stock) != 0) {
          if ((data.iRECQTY - stock) > 0) {
            recheckStock.iRECEIVEQTY = '${data.iRECQTY.toStringAsFixed(0)}';
            recheckStock.iISSUEQTY = '0';
          } else {
            recheckStock.iRECEIVEQTY = '0';
            recheckStock.iISSUEQTY = '${data.iRECQTY.toStringAsFixed(0)}';
          }
        }
      }

      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.addStockCard(recheckStock);
      if (result.success == false) {
        wrongDialog('${result.message}');
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getBranchAll() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getBranchAll();
      if ((result.isNotEmpty)) {
        setState(() {
          branchList = [];
          branchList.addAll(result);
          for (var i = 0; i < result.length; i++) {
            if (result[i].cBRANCD == GlobalParam.VEHICLE['cBRANCD']) {
              branch = result[i];
            }
          }
        });
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  addValue(String size, String value, GetProductBranchResp product) {
    bool proRepeat = false;

    for (var i = 0; i < GlobalParam.customerRecheckPROStockList.length; i++) {
      if (product.cPRODCD ==
          GlobalParam.customerRecheckPROStockList[i].cPRODCD) {
        if (value != '') {
          if (size == "S") {
            GlobalParam.customerRecheckPROStockList[i].iSSIZEQTY = value;
            for (var j = 0; j < reqRecheckStock.length; j++) {
              if (reqRecheckStock[j].cPRODCD == product.cPRODCD) {
                if (reqRecheckStock[j].cUOMCD == product.cSUOMCD) {
                  reqRecheckStock[j].iRECQTY = double.parse(value);
                }
              }
            }
          }
          if (size == "M") {
            GlobalParam.customerRecheckPROStockList[i].iMSIZEQTY = value;
            for (var j = 0; j < reqRecheckStock.length; j++) {
              if (reqRecheckStock[j].cPRODCD == product.cPRODCD) {
                if (reqRecheckStock[j].cUOMCD == product.cMUOMCD) {
                  reqRecheckStock[j].iRECQTY = double.parse(value);
                }
              }
            }
          }
          if (size == "L") {
            GlobalParam.customerRecheckPROStockList[i].iLSIZEQTY = value;
            for (var j = 0; j < reqRecheckStock.length; j++) {
              if (reqRecheckStock[j].cPRODCD == product.cPRODCD) {
                if (reqRecheckStock[j].cUOMCD == product.cLUOMCD) {
                  reqRecheckStock[j].iRECQTY = double.parse(value);
                }
              }
            }
          }
        } else {
          if (size == "S") {
            GlobalParam.customerRecheckPROStockList[i].iSSIZEQTY = '0.0';
            for (var j = 0; j < reqRecheckStock.length; j++) {
              if (reqRecheckStock[j].cPRODCD == product.cPRODCD) {
                if (reqRecheckStock[j].cUOMCD == product.cSUOMCD) {
                  reqRecheckStock[j].iRECQTY = 0;
                }
              }
            }
          }
          if (size == "M") {
            GlobalParam.customerRecheckPROStockList[i].iMSIZEQTY = '0.0';
            for (var j = 0; j < reqRecheckStock.length; j++) {
              if (reqRecheckStock[j].cPRODCD == product.cPRODCD) {
                if (reqRecheckStock[j].cUOMCD == product.cMUOMCD) {
                  reqRecheckStock[j].iRECQTY = 0;
                }
              }
            }
          }
          if (size == "L") {
            GlobalParam.customerRecheckPROStockList[i].iLSIZEQTY = '0.0';
            for (var j = 0; j < reqRecheckStock.length; j++) {
              if (reqRecheckStock[j].cPRODCD == product.cPRODCD) {
                if (reqRecheckStock[j].cUOMCD == product.cLUOMCD) {
                  reqRecheckStock[j].iRECQTY = 0;
                }
              }
            }
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
              basketProduct.add(GlobalParam.customerRecheckPROStockList[i]);
            }
          }
        } else {
          basketProduct.add(GlobalParam.customerRecheckPROStockList[i]);
        }

        for (var k = 0; k < totalList.length; k++) {
          double sQty = 0;
          double mQty = 0;
          double lQty = 0;
          double unitPrice = 0.0;
          for (var l = 0; l < priceTable.length; l++) {
            if (priceTable[l].cPRODCD ==
                GlobalParam.customerShowRecheckPROStockList[i].cPRODCD) {
              unitPrice = double.parse(priceTable[l].iCOSTVAT);
              for (var m = 0; m < priceTable[l].tPRICEDT.length; m++) {
                if (priceTable[l].tPRICEDT[m].cTYPE == "S") {
                  sQty = double.parse(priceTable[l].tPRICEDT[m].iQTY);
                }
                if (priceTable[l].tPRICEDT[m].cTYPE == "M") {
                  mQty = double.parse(priceTable[l].tPRICEDT[m].iQTY);
                }
                if (priceTable[l].tPRICEDT[m].cTYPE == "L") {
                  lQty = double.parse(priceTable[l].tPRICEDT[m].iQTY);
                }
              }
            }
          }
          if (totalList[k]['cPRODCD'] ==
              GlobalParam.customerRecheckPROStockList[i].cPRODCD) {
            var s = double.parse(
                GlobalParam.customerRecheckPROStockList[i].iSSIZEQTY);
            var m = double.parse(
                GlobalParam.customerRecheckPROStockList[i].iMSIZEQTY);
            var l = double.parse(
                GlobalParam.customerRecheckPROStockList[i].iLSIZEQTY);
            totalList[k]['checkTotal'] = (s * sQty) + (m * mQty) + (l * lQty);
            totalList[k]['netTotal'] =
                totalList[k]['checkTotal'] - totalList[k]['total'];
          }
        }
      }
      for (var j = 0; j < addRequest.aPRODUCT.length; j++) {
        if (GlobalParam.customerRecheckPROStockList[i].cPRODCD ==
            addRequest.aPRODUCT[j].cPRODCD) {
          addRequest.aPRODUCT[j].iSSIZEQTY = double.parse(
              GlobalParam.customerRecheckPROStockList[i].iSSIZEQTY);
          addRequest.aPRODUCT[j].iMSIZEQTY = double.parse(
              GlobalParam.customerRecheckPROStockList[i].iMSIZEQTY);
          addRequest.aPRODUCT[j].iLSIZEQTY = double.parse(
              GlobalParam.customerRecheckPROStockList[i].iLSIZEQTY);
        }
      }
    }
    setState(() {});
  }

  checkProduct(GetProductBranchResp data, int index) {
    GlobalParam.customerShowRecheckPROStockList[index].cCHECK = !data.cCHECK;

    if (data.cCHECK == false) {
      isCheck--;
    } else {
      isCheck++;
    }

    setState(() {});
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();
    final fontTHNA = await rootBundle.load("assets/fonts/TH_Niramit_AS.ttf");
    final TH_NA = pw.Font.ttf(fontTHNA);
    final fontTHNAB =
        await rootBundle.load("assets/fonts/TH_Niramit_AS_Bold.ttf");
    final TH_NA_B = pw.Font.ttf(fontTHNAB);
    final formatNum = new NumberFormat("#,###.##", "en_US");
    String timeNow = DateFormat('HH:mm a').format(DateTime.now());
    String dateNewF = '';
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(new DateTime.now());
    List<String> listA = [];
    List<String> listB = [];
    double total = 0;

    List<pw.Widget> pages = [];
    double loop = GlobalParam.customerRecheckPROStockList.length / 22;
    var pageNember = 0;
    var start = 0;
    var add = 26;
    if ((loop % 1) != 0) {
      loop++;
      pageNember = int.parse(loop.toStringAsFixed(0));
    }

    for (var j = 0; j < GlobalParam.customerRecheckPROStockList.length; j++) {
      var sS = '0';
      var sM = '0';
      var sL = '0';
      var tS = '0';
      var tM = '0';
      var tL = '0';
      var aS = '0';
      var aM = '0';
      var aL = '0';
      for (var k = 0; k < stockList.length; k++) {
        double stockS = 0.0;
        double stockM = 0.0;
        double stockL = 0.0;
        double trueS = 0.0;
        double trueM = 0.0;
        double trueL = 0.0;
        if (stockList[k].cPRODCD ==
            GlobalParam.customerRecheckPROStockList[j].cPRODCD) {
          if (stockList[k].cUOMCD ==
              GlobalParam.customerRecheckPROStockList[j].cSUOMCD) {
            stockS = double.parse(stockList[k].iPROQTY);
            trueS = double.parse(
                GlobalParam.customerRecheckPROStockList[j].iSSIZEQTY);
            sS = '${stockS.toStringAsFixed(0)}';
            tS = '${trueS.toStringAsFixed(0)}';
            double amonut = trueS - stockS;
            aS = '${amonut.toStringAsFixed(0)}';
            total += amonut *
                double.parse(
                    GlobalParam.customerRecheckPROStockList[j].iSUNITPRICE);
          }
          if (stockList[k].cUOMCD ==
              GlobalParam.customerRecheckPROStockList[j].cMUOMCD) {
            stockM = double.parse(stockList[k].iPROQTY);
            trueM = double.parse(
                GlobalParam.customerRecheckPROStockList[j].iMSIZEQTY);
            sM = '${stockM.toStringAsFixed(0)}';
            tM = '${trueM.toStringAsFixed(0)}';
            double amonut = trueM - stockM;
            aM = '${amonut.toStringAsFixed(0)}';
            total += amonut *
                double.parse(
                    GlobalParam.customerRecheckPROStockList[j].iMUNITPRICE);
          }
          if (stockList[k].cUOMCD ==
              GlobalParam.customerRecheckPROStockList[j].cLUOMCD) {
            stockL = double.parse(stockList[k].iPROQTY);
            trueL = double.parse(
                GlobalParam.customerRecheckPROStockList[j].iLSIZEQTY);
            sL = '${stockL.toStringAsFixed(0)}';
            tL = '${trueL.toStringAsFixed(0)}';
            double amonut = trueL - stockL;
            aL = '${amonut.toStringAsFixed(0)}';
            total += amonut *
                double.parse(
                    GlobalParam.customerRecheckPROStockList[j].iLUNITPRICE);
          }
        }
      }
    }
    for (var i = 0; i < pageNember; i++) {
      pw.Widget header() {
        var a = 'นายกัณฐ์เทรดดิ้ง\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t';
        var b = 'ใบนับสต็อกสินค้า\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t';
        var c = 'หน้าที่ ${i + 1}';
        var a1 = '${branch.cBRANNM}\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t';
        var b1 = 'วันที่ $outputDate\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t';
        var c1 = 'ผู้ตรวจนับ: ${GlobalParam.userData.cUSRNM}';
        return pw.Column(children: [
          pw.Text(
            '$a$b$c',
            style: pw.TextStyle(fontSize: 24, font: TH_NA_B),
            textAlign: pw.TextAlign.left,
          ),
          pw.Text(
            '$a1$b1$c1',
            style: pw.TextStyle(fontSize: 20, font: TH_NA_B),
            textAlign: pw.TextAlign.left,
          ),
        ]);
      }

      pw.Widget lineBreak() {
        return pw.Container(
            child: pw.Center(
          child: pw.Text(
              '\n_______________________________________________________________\n\n',
              style: pw.TextStyle(
                  fontSize: 24, fontWeight: pw.FontWeight.bold, font: TH_NA)),
        ));
      }

      pw.Widget footer() {
        return pw.Container(
            child: pw.Center(
                child: pw.Column(children: [
          pw.Row(children: [
            pw.Text('สรุป ขาด/เกิน',
                style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    font: TH_NA_B)),
            pw.SizedBox(width: 12),
            pw.Container(
                width: 96,
                child: pw.Text(formatNum.format(total),
                    style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA_B),
                    textAlign: pw.TextAlign.right)),
            pw.SizedBox(width: 12),
            pw.Text('บาท',
                style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    font: TH_NA_B)),
          ]),
          pw.SizedBox(height: 24),
          pw.Row(children: [
            pw.SizedBox(width: 196),
            pw.Text('ผู้ตรวจนับ______________________________',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    font: TH_NA_B)),
          ]),
        ])));
      }

      pw.Widget columnName() {
        var a = '\t\t\t\t\t\t';
        var b = 'ชื่อสินค้า\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t';
        var c = 'ในระบบ\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t';
        var d = 'นับได้\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t';
        var e = 'สรุป';
        var a1 = '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t';
        var b1 = '\t\t\t\t\t\t\t\t\t\t\t';
        var c1 = '\t\t\tใหญ่\t\t\tกลาง\t\t\tเล็ก\t\t\t\t';
        var c2 = '\t\t\tใหญ่\t\t\tกลาง\t\t\tเล็ก\t\t\t\t';
        var c3 = '\t\t\tใหญ่\t\t\tกลาง\t\t\tเล็ก';

        return pw.Container(
            child: pw.Column(children: [
          pw.Container(
            height: 24,
            child: pw.Text('$a$b$c$d$e',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(fontSize: 20, font: TH_NA_B)),
          ),
          pw.Container(
            height: 24,
            child: pw.Text('$a1$b1\t\t\t\t\t\t\t\t\t\t\t\t\t$c1$c2$c3',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(fontSize: 16, font: TH_NA_B)),
          )
        ]));
      }

      pw.Widget test() {
        var a = '';
        var b = '';
        for (var j = start; j < start + add; j++) {
          var name = '';
          var sS = '0';
          var sM = '0';
          var sL = '0';
          var tS = '0';
          var tM = '0';
          var tL = '0';
          var aS = '0';
          var aM = '0';
          var aL = '0';
          if (j < GlobalParam.customerRecheckPROStockList.length) {
            double stockS = 0.0;
            double stockM = 0.0;
            double stockL = 0.0;
            double trueS = 0.0;
            double trueM = 0.0;
            double trueL = 0.0;
            for (var k = 0; k < stockList.length; k++) {
              if (stockList[k].cPRODCD ==
                  GlobalParam.customerRecheckPROStockList[j].cPRODCD) {
                if (stockList[k].cUOMCD ==
                    GlobalParam.customerRecheckPROStockList[j].cSUOMCD) {
                  stockS = double.parse(stockList[k].iPROQTY);
                  trueS = double.parse(
                      GlobalParam.customerRecheckPROStockList[j].iSSIZEQTY);
                  sS = '${stockS.toStringAsFixed(0)}';
                  tS = '${trueS.toStringAsFixed(0)}';
                  double amonut = trueS - stockS;
                  aS = '${amonut.toStringAsFixed(0)}';
                }
                if (stockList[k].cUOMCD ==
                    GlobalParam.customerRecheckPROStockList[j].cMUOMCD) {
                  stockM = double.parse(stockList[k].iPROQTY);
                  trueM = double.parse(
                      GlobalParam.customerRecheckPROStockList[j].iMSIZEQTY);
                  sM = '${stockM.toStringAsFixed(0)}';
                  tM = '${trueM.toStringAsFixed(0)}';
                  double amonut = trueM - stockM;
                  aM = '${amonut.toStringAsFixed(0)}';
                }
                if (stockList[k].cUOMCD ==
                    GlobalParam.customerRecheckPROStockList[j].cLUOMCD) {
                  stockL = double.parse(stockList[k].iPROQTY);
                  trueL = double.parse(
                      GlobalParam.customerRecheckPROStockList[j].iLSIZEQTY);
                  sL = '${stockL.toStringAsFixed(0)}';
                  tL = '${trueL.toStringAsFixed(0)}';
                  double amonut = trueL - stockL;
                  aL = '${amonut.toStringAsFixed(0)}';
                }
              }
            }
            var c1 = '$sL';
            var c2 = '$sM';
            var c3 = '$sS';
            var d1 = '$tL';
            var d2 = '$tM';
            var d3 = '$tS';
            var e1 = '$aL';
            var e2 = '$aM';
            var e3 = '$aS';

            name = '\t\t${GlobalParam.customerRecheckPROStockList[j].cPRODNM}';

            a += '\n\t\t${j + 1}$name\n';
            b += '\n\t\t$c1$c2$c3$d1$d2$d3$e1$e2$e3\n';
            listA.add(a);
            listB.add(b);
          } else {
            a += '\n\t\t${j + 1}\n';
            b += '\n\t\t\n';
            listA.add(a);
            listB.add(b);
          }
          // a += '\n\t\t${j + 1}\n';
        }

        return pw.Table(children: [
          for (var j = 0; j < listA.length; j++)
            pw.TableRow(children: [
              pw.Container(
                width: 128,
                child: pw.Text('${listA[j]}',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA)),
              ),
              pw.Container(
                width: 155,
                child: pw.Text('${listB[j]}',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        font: TH_NA)),
              ),
            ])
        ]);
      }

      pw.Widget content() {
        var a = '';
        var b = '';
        for (var j = start; j < start + add; j++) {
          var name = '';
          var sS = '0';
          var sM = '0';
          var sL = '0';
          var tS = '0';
          var tM = '0';
          var tL = '0';
          var aS = '0';
          var aM = '0';
          var aL = '0';
          if (j < GlobalParam.customerRecheckPROStockList.length) {
            double stockS = 0.0;
            double stockM = 0.0;
            double stockL = 0.0;
            double trueS = 0.0;
            double trueM = 0.0;
            double trueL = 0.0;
            for (var k = 0; k < stockList.length; k++) {
              if (stockList[k].cPRODCD ==
                  GlobalParam.customerRecheckPROStockList[j].cPRODCD) {
                if (stockList[k].cUOMCD ==
                    GlobalParam.customerRecheckPROStockList[j].cSUOMCD) {
                  stockS = double.parse(stockList[k].iPROQTY);
                  trueS = double.parse(
                      GlobalParam.customerRecheckPROStockList[j].iSSIZEQTY);
                  sS = '${stockS.toStringAsFixed(0)}';
                  tS = '${trueS.toStringAsFixed(0)}';
                  double amonut = trueS - stockS;
                  aS = '${amonut.toStringAsFixed(0)}';
                }
                if (stockList[k].cUOMCD ==
                    GlobalParam.customerRecheckPROStockList[j].cMUOMCD) {
                  stockM = double.parse(stockList[k].iPROQTY);
                  trueM = double.parse(
                      GlobalParam.customerRecheckPROStockList[j].iMSIZEQTY);
                  sM = '${stockM.toStringAsFixed(0)}';
                  tM = '${trueM.toStringAsFixed(0)}';
                  double amonut = trueM - stockM;
                  aM = '${amonut.toStringAsFixed(0)}';
                }
                if (stockList[k].cUOMCD ==
                    GlobalParam.customerRecheckPROStockList[j].cLUOMCD) {
                  stockL = double.parse(stockList[k].iPROQTY);
                  trueL = double.parse(
                      GlobalParam.customerRecheckPROStockList[j].iLSIZEQTY);
                  sL = '${stockL.toStringAsFixed(0)}';
                  tL = '${trueL.toStringAsFixed(0)}';
                  double amonut = trueL - stockL;
                  aL = '${amonut.toStringAsFixed(0)}';
                }
              }
            }
            var c1 = '\t$sL\t\t\t\t\t\t\t';
            var c2 = '$sM\t\t\t\t\t\t\t';
            var c3 = '$sS\t\t\t\t\t\t\t';
            var d1 = '\t\t\t\t$tL\t\t\t\t\t\t\t';
            var d2 = '$tM\t\t\t\t\t\t\t';
            var d3 = '$tS\t\t\t\t\t\t\t';
            var e1 = '\t\t\t\t\t$aL\t\t\t\t\t\t\t';
            var e2 = '$aM\t\t\t\t\t\t\t';
            var e3 = '$aS';

            name = '\t\t${GlobalParam.customerRecheckPROStockList[j].cPRODNM}';
            a += '\t\t${j + 1}$name\n\n';
            b += '\t\t$c1$c2$c3$d1$d2$d3$e1$e2$e3\n\n';
          } else {
            a += '\t\t${j + 1}\n\n';
            b += '\t\t\n\n';
          }
          // a += '\n\t\t${j + 1}\n';
        }
        return pw.Row(children: [
          pw.Padding(
            padding: pw.EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: pw.Container(
              width: 164,
              child: pw.Text('$a',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 16, font: TH_NA)),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: pw.Container(
              width: 320,
              child: pw.Text('$b',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 16, font: TH_NA)),
            ),
          )
        ]);
      }

      pages.addAll(<pw.Widget>[
        header(),
        lineBreak(),
        columnName(),
        // content(),
        test(),
        lineBreak(),
        footer()
      ]);
      start += add;
    }

    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.all(56),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pages;
        }));

    List<int> bytes = await pdf.save();
    String poDate = DateFormat('yyyyMMddHHmm').format(DateTime.now());
    // await file.writeAsBytes(await pdf.save());
    saveAndLaunchFile(bytes, 'ใบนับสต็อกสินค้า_${poDate}.pdf');
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    // final path = (await getExternalStorageDirectory()).path;
    final path = '/storage/emulated/0/Documents';
    final file = File('$path/$fileName');
    // final bit = await bytes;
    print('***************$path');
    await file
        .writeAsBytes(bytes, flush: true)
        .then((value) => {OpenFile.open('$path/$fileName')});
  }
}
