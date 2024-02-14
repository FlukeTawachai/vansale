import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addBKRReq.dart';
import 'package:vansale/api/class/request/mobile/addBarsketStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/addReturnBasketToStock.dart';
import 'package:vansale/api/class/request/mobile/getProductOrBasketStockReq.dart';
import 'package:vansale/api/class/request/mobile/searchBasket.dart';
import 'package:vansale/api/class/response/routeMobile/getBasketResp.dart';
import 'package:vansale/api/class/response/routeMobile/getBasketReturnOfRoute.dart';
import 'package:vansale/api/class/response/routeMobile/getProductOrBasketStockResp.dart';

import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/models/delayTime.dart';
import 'package:vansale/screens/delivery/delivery_scanner.dart';
import 'package:vansale/screens/home/home.dart';
import 'package:blue_print_pos/blue_print_pos.dart';

class StockTransferBasketReturn extends StatefulWidget {
  const StockTransferBasketReturn({Key? key}) : super(key: key);

  @override
  State<StockTransferBasketReturn> createState() =>
      _StockTransferBasketReturnState();
}

class _StockTransferBasketReturnState extends State<StockTransferBasketReturn> {
  DelayTime delay = new DelayTime();
  double widthScreen = 0.0;
  List<bool> oldBasketList = [];
  final formatNum = new NumberFormat("#,###.##", "en_US");
  String poDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String timeNow = DateFormat('HH:mm a').format(DateTime.now());
  String dateNewF = '';
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  var basketData = [];
  List<GetBasketReturnOfRouteResp> basketReturnList = [];
  List<AddBKRReq> returnList = [];
  List<GetBasketResp> returnCheckList = [];
  var totalList = [];
  String cREFDOC = '';
  List<GetProductOrBasketStockResp> stockList = [];
  List<AddReturnBasketToStockReq> basketToStockReqList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (GlobalParam.deliveryRegetPODT == true) {
      returnList = [];
      getBasketReturnOfRoute();

      getProductOrBasketStock(GetProductOrBasketStockReq(
          cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
          cWH: 'BR',
          cSEARCH: 'BASKET'));
    }
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0.0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            'คืนตะกร้า',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Prompt',
            ),
          ),
          // leading: Container(),
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
                            onSubmitted: (value) {
                              if (value == '' || value == null) {
                                getBasket(SearchBasketReq(
                                    cBASKCD: '%%', cBASKNM: '%%'));
                              } else {
                                getBasket(SearchBasketReq(
                                    cBASKCD: '%%', cBASKNM: '%$value%'));
                              }
                            },
                            style: TextStyle(
                              fontFamily: 'Prompt',
                            ),
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              hintText: "ค้นหาแบรนต์ตะกร้า",
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
                                  onPressed: () {},
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
                                        code: '004',
                                        navigator: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StockTransferBasketReturn()));
                                        },
                                      )));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child:
                    // textCode()
                    ListView.builder(
                        itemCount: GlobalParam.deliveryBasketShow.length,
                        itemBuilder: (BuildContext context, int index) {
                          // StockTransferBasketReturnCard
                          double total = 0.0;
                          int qty = 0;
                          for (var k = 0; k < totalList.length; k++) {
                            if (totalList[k]['cBASKCD'] ==
                                GlobalParam.deliveryBasketShow[index].cBASKCD) {
                              total = totalList[k]['total'];
                              qty = totalList[k]['qty'];
                            }
                          }

                          double stock = 0.0;

                          for (var k = 0; k < stockList.length; k++) {
                            if (stockList[k].cBASKCD ==
                                GlobalParam.deliveryBasketShow[index].cBASKCD) {
                              stock = double.parse(stockList[k].iBKQTY!);
                            }
                          }
                          return Container(
                            color: HexColor("#F2F3F4"),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // GlobalParam.typeMenuCode == "T001"?
                                Container(
                                    padding: const EdgeInsets.all(5.0),
                                    height: 140.0,
                                    child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(5.0),
                                            width: 100.0,
                                            height: 150.0,
                                            decoration: BoxDecoration(
                                                image: GlobalParam
                                                            .deliveryBasketShow[
                                                                index]
                                                            .cPHOTOPATH !=
                                                        ''
                                                    ? DecorationImage(
                                                        image: new NetworkImage(
                                                          'http://${GlobalParam.deliveryBasketShow[index].cPHOTOSERV}/${GlobalParam.deliveryBasketShow[index].cPHOTOPATH}',
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
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5),
                                                ),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                          ),
                                          //----------------------1
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            width: widthScreen * 0.65,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: widthScreen * 0.4,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      // width: 136,
                                                      child: Text(
                                                        GlobalParam
                                                            .deliveryBasketShow[
                                                                index]
                                                            .cBASKNM!,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Prompt',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    // InkWell(
                                                    //   onTap: () {
                                                    //     setState(() {
                                                    //       if (GlobalParam
                                                    //               .deliveryBasketShow[
                                                    //                   index]
                                                    //               .cCheck ==
                                                    //           false) {
                                                    //         GlobalParam
                                                    //             .deliveryBasketShow[
                                                    //                 index]
                                                    //             .cCheck = true;
                                                    //         GlobalParam
                                                    //             .supplierCheckCounter++;
                                                    //       } else {
                                                    //         GlobalParam
                                                    //             .deliveryBasketShow[
                                                    //                 index]
                                                    //             .cCheck = false;
                                                    //         GlobalParam
                                                    //             .supplierCheckCounter--;
                                                    //       }
                                                    //     });
                                                    //   },
                                                    //   child: GlobalParam
                                                    //               .deliveryBasketShow[
                                                    //                   index]
                                                    //               .cCheck ==
                                                    //           false
                                                    //       ? Container(
                                                    //           width:
                                                    //               widthScreen *
                                                    //                   0.2,
                                                    //           height: 24,
                                                    //           decoration:
                                                    //               BoxDecoration(
                                                    //                   borderRadius:
                                                    //                       BorderRadius
                                                    //                           .only(
                                                    //                     topLeft:
                                                    //                         Radius.circular(5),
                                                    //                     topRight:
                                                    //                         Radius.circular(5),
                                                    //                     bottomLeft:
                                                    //                         Radius.circular(5),
                                                    //                     bottomRight:
                                                    //                         Radius.circular(5),
                                                    //                   ),
                                                    //                   border: Border.all(
                                                    //                       color:
                                                    //                           Colors.red)),
                                                    //           child: Center(
                                                    //             child: Text(
                                                    //               'รอนับ',
                                                    //               style: TextStyle(
                                                    //                   fontFamily:
                                                    //                       'Prompt',
                                                    //                   fontSize:
                                                    //                       14.0,
                                                    //                   color: Colors
                                                    //                       .red),
                                                    //               overflow:
                                                    //                   TextOverflow
                                                    //                       .ellipsis,
                                                    //             ),
                                                    //           ),
                                                    //         )
                                                    //       : Container(
                                                    //           width:
                                                    //               widthScreen *
                                                    //                   0.2,
                                                    //           height: 24,
                                                    //           decoration:
                                                    //               BoxDecoration(
                                                    //                   borderRadius:
                                                    //                       BorderRadius
                                                    //                           .only(
                                                    //                     topLeft:
                                                    //                         Radius.circular(5),
                                                    //                     topRight:
                                                    //                         Radius.circular(5),
                                                    //                     bottomLeft:
                                                    //                         Radius.circular(5),
                                                    //                     bottomRight:
                                                    //                         Radius.circular(5),
                                                    //                   ),
                                                    //                   border: Border.all(
                                                    //                       color:
                                                    //                           Colors.green)),
                                                    //           child: Center(
                                                    //             child: Text(
                                                    //               'นับแล้ว',
                                                    //               style: TextStyle(
                                                    //                   fontFamily:
                                                    //                       'Prompt',
                                                    //                   fontSize:
                                                    //                       14.0,
                                                    //                   color: Colors
                                                    //                       .green),
                                                    //               overflow:
                                                    //                   TextOverflow
                                                    //                       .ellipsis,
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    // ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 24,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'สต็อก ${stock.toStringAsFixed(0)} ใบ',
                                                        style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          color: Colors
                                                              .grey.shade500,
                                                          fontSize: 14,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          GlobalParam
                                                                  .deliveryBasketShow[
                                                                      index]
                                                                  .cCheck =
                                                              !GlobalParam
                                                                  .deliveryBasketShow[
                                                                      index]
                                                                  .cCheck!;
                                                        });
                                                      },
                                                      child: GlobalParam
                                                                  .deliveryBasketShow[
                                                                      index]
                                                                  .cCheck ==
                                                              false
                                                          ? Container(
                                                              width:
                                                                  widthScreen *
                                                                      0.2,
                                                              height: 24,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
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
                                                                          color:
                                                                              Colors.red)),
                                                              child: Center(
                                                                child: Text(
                                                                  'รอนับ',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Prompt',
                                                                      fontSize:
                                                                          14.0,
                                                                      color: Colors
                                                                          .red),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(
                                                              width:
                                                                  widthScreen *
                                                                      0.2,
                                                              height: 24,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
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
                                                                          color:
                                                                              Colors.green)),
                                                              child: Center(
                                                                child: Text(
                                                                  'นับแล้ว',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Prompt',
                                                                      fontSize:
                                                                          14.0,
                                                                      color: Colors
                                                                          .green),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Center(
                                                          child: Text(
                                                            'จำนวน',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Center(
                                                          child: Text(
                                                            'ขาด',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color: Colors.red,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Center(
                                                          child: Text(
                                                            'เกิน',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 5.0,
                                                            right: 5.0),
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade400,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                          '$qty',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Prompt',
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                          ),
                                                        )),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 5.0,
                                                            right: 5.0),
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: GlobalParam
                                                                      .deliveryBasketShow[
                                                                          index]
                                                                      .cDCUL ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.grey
                                                                  .shade400,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0, 4, 0, 0),
                                                            child:
                                                                TextFormField(
                                                              enabled: GlobalParam
                                                                  .deliveryBasketShow[
                                                                      index]
                                                                  .cDCUL,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                              onChanged:
                                                                  (value) {
                                                                if (value !=
                                                                        '' &&
                                                                    value !=
                                                                        null) {
                                                                  addBasketReturn(
                                                                      GlobalParam
                                                                              .deliveryBasketShow[
                                                                          index],
                                                                      double.parse(
                                                                          value),
                                                                      index,
                                                                      'decrease');
                                                                } else {
                                                                  addBasketReturn(
                                                                      GlobalParam
                                                                              .deliveryBasketShow[
                                                                          index],
                                                                      0,
                                                                      index,
                                                                      'decrease');
                                                                }
                                                              },
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              // controller: incleaseValue,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                errorBorder:
                                                                    InputBorder
                                                                        .none,
                                                                disabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                // contentPadding: EdgeInsets.only(
                                                                //     left: 15,
                                                                //     bottom: 11,
                                                                //     top: 15,
                                                                //     right: 15),
                                                              ),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            left: 5.0,
                                                            right: 5.0),
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: GlobalParam
                                                                      .deliveryBasketShow[
                                                                          index]
                                                                      .cICUK ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.grey
                                                                  .shade400,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0, 4, 0, 0),
                                                            child:
                                                                TextFormField(
                                                              enabled: GlobalParam
                                                                  .deliveryBasketShow[
                                                                      index]
                                                                  .cICUK,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                              onChanged:
                                                                  (value) {
                                                                if (value !=
                                                                        '' &&
                                                                    value !=
                                                                        null) {
                                                                  addBasketReturn(
                                                                      GlobalParam
                                                                              .deliveryBasketShow[
                                                                          index],
                                                                      double.parse(
                                                                          value),
                                                                      index,
                                                                      'increase');
                                                                } else {
                                                                  addBasketReturn(
                                                                      GlobalParam
                                                                              .deliveryBasketShow[
                                                                          index],
                                                                      0,
                                                                      index,
                                                                      'increase');
                                                                }
                                                              },
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              // controller: incleaseValue,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                errorBorder:
                                                                    InputBorder
                                                                        .none,
                                                                disabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                // contentPadding: EdgeInsets.only(
                                                                //     left: 15,
                                                                //     bottom: 11,
                                                                //     top: 15,
                                                                //     right: 15),
                                                              ),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Spacer(),
                                                    Container(
                                                      width: widthScreen * 0.15,
                                                      child: Center(
                                                        child: Text(
                                                          "ต่อหน่วย",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: widthScreen * 0.2,
                                                      child: Text(
                                                        "${formatNum.format(double.parse(GlobalParam.deliveryBasketShow[index].iPRICE!))} ฿",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Prompt',
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: widthScreen * 0.1,
                                                      child: Center(
                                                        child: Text(
                                                          "รวม",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        width:
                                                            widthScreen * 0.2,
                                                        child: Text(
                                                          "${formatNum.format(total)} ฿",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                          textAlign:
                                                              TextAlign.right,
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ])),

                                DottedLine(
                                  dashColor: Colors.grey,
                                ),
                              ],
                            ),
                          );
                        }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: footer());
  }

  Widget footer() {
    double widthScreen = MediaQuery.of(context).size.width;
    List<AddBKRReq> showData = [];
    List<AddBKRReq> orderList = [];
    orderList.addAll(returnList);
    var unitList = [];
    double productTotal = 0;
    String basketName = '';

    for (var i = 0; i < orderList.length; i++) {
      double qty = orderList[i].iQTY!;
      double price = orderList[i].iTOTAL! / orderList[i].iQTY!;
      for (var j = 0; j < GlobalParam.deliveryBasketList.length; j++) {
        if (GlobalParam.deliveryBasketList[j].cBASKCD == orderList[i].cBASKCD) {
          basketName = GlobalParam.deliveryBasketList[j].cBASKNM!;
        }
      }
      if (qty > 0) {
        showData.add(orderList[i]);
        productTotal += qty * price;

        var data = {
          "cPRODCD": orderList[i].cBASKCD,
          "cUOMNM": basketName,
          "iPRICE": price,
          "iTOTAL": orderList[i].iTOTAL
        };
        unitList.add(data);
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
                    saveData();

                    // Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             HomePage(GlobalParam.typeMenuCode)),
                    //     (Route route) => false);
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child: Icon(
                              LineAwesomeIcons.shopping_basket,
                              color: Colors.green,
                              size: 25.0,
                            )),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'บันทึกตืนตะกร้า',
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

  getBasketReturnOfRoute() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result =
          await proxy.getBasketReturnOfRoute(GlobalParam.stockTransferReq);
      if (result.isNotEmpty) {
        setState(() {
          basketReturnList = [];
          basketReturnList.addAll(result);
        });

        getBasket(SearchBasketReq(cBASKCD: '%%', cBASKNM: '%%'));
      } else {
        basketReturnList = [];
        GlobalParam.deliveryBasketShow = [];
      }
      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getBasket(SearchBasketReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getBasket(req);
      GlobalParam.deliveryBasketList = result;

      // GlobalParam.deliveryBasketShow = result;
      var list = [];
      GlobalParam.deliveryBasketShow = [];
      // GlobalParam.deliveryBasketShow.addAll(result);

      for (int j = 0; j < GlobalParam.deliveryBasketList.length; j++) {
        var increase = 0;
        var data = {
          'basketCD': GlobalParam.deliveryBasketList[j].cBASKCD,
          'baskeNM': GlobalParam.deliveryBasketList[j].cBASKNM,
          'total': '0',
          'increase': '0'
        };
      }

      for (int i = 0; i < GlobalParam.deliveryBasketList.length; i++) {
        for (int j = 0; j < basketReturnList.length; j++) {
          if (GlobalParam.deliveryBasketList[i].cBASKCD ==
              basketReturnList[j].cBASKCD) {
            GlobalParam.deliveryBasketList[i].cCheck = false;
            GlobalParam.deliveryBasketList[i].cICUK = true;
            GlobalParam.deliveryBasketList[i].cDCUL = true;
            GlobalParam.deliveryBasketShow
                .add(GlobalParam.deliveryBasketList[i]);
            var data = {
              "cBASKCD": GlobalParam.deliveryBasketList[i].cBASKCD,
              "total": 0.0,
              'qty': basketReturnList[j].iQTY
            };
            totalList.add(data);
            var req = AddReturnBasketToStockReq(
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cREFDOC: basketReturnList[j].cREFDOC,
              iSEQ: j + 1,
              cGRPCD: GlobalParam.stockTransferReq.cGRPCD,
              cRTECD: GlobalParam.stockTransferReq.cRTECD,
              cBASKCD: basketReturnList[j].cBASKCD,
              iPRICE: "${GlobalParam.deliveryBasketList[i].iPRICE}",
              iQTY: "${basketReturnList[j].iQTY}",
              iTRUEQTY: "${basketReturnList[j].iQTY}",
              cWH: "BR",
              cCREABY: GlobalParam.userData.cUSRNM,
            );
            basketToStockReqList.add(req);
          }
        }
      }

      if (result.isEmpty) {
        wrongDialog('ไม่พบรายการตะกร้า');
      }
      setState(() {
        print(
            '++++++++++++++++++++ ${list.length} : ${GlobalParam.deliveryHisBasket.length}');
        basketData = list;
      });
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  addBasketStockCard() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      List<AddBasketStockCardReq> reqList = [];
      for (var i = 0; i < returnList.length; i++) {
        var basketName = '';
        for (var j = 0; j < GlobalParam.deliveryBasketList.length; j++) {
          if (returnList[i].cBASKCD ==
              GlobalParam.deliveryBasketList[j].cBASKCD) {
            basketName = GlobalParam.deliveryBasketList[j].cBASKNM!;
          }
        }

        if (returnList[i].iQTY! > 0) {
          reqList.add(AddBasketStockCardReq(
            cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
            cWH: "TP",
            cBASKCD: returnList[i].cBASKCD,
            cBASKNM: basketName,
            cUOMCD: "B0001",
            cREFDOC: '${returnList[i].cREFDOC}',
            iRECEIVEQTY: "0",
            iISSUEQTY: "${returnList[i].iQTY!.toStringAsFixed(0)}",
            cREMARK: "transfer stock to branch stock",
            cCREABY: GlobalParam.userData.cUSRNM,
          ));

          reqList.add(AddBasketStockCardReq(
            cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
            cWH: "BR",
            cBASKCD: returnList[i].cBASKCD,
            cBASKNM: basketName,
            cUOMCD: "B0001",
            cREFDOC: '${returnList[i].cREFDOC}',
            iRECEIVEQTY: "${returnList[i].iQTY!.toStringAsFixed(0)}",
            iISSUEQTY: "0",
            cREMARK: "transfer stock to branch stock",
            cCREABY: GlobalParam.userData.cUSRNM,
          ));
        }
      }

      for (var i = 0; i < reqList.length; i++) {
        var result = await proxy.addBasketStockCard(reqList[i]);
        if (result.success == false) {
          wrongDialog('${result.message}');
        }
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

  addBasketReturn(GetBasketResp basket, double value, int index, String type) {
    setState(() {
      for (var i = 0; i < totalList.length; i++) {
        if (totalList[i]['cBASKCD'] == basket.cBASKCD) {
          totalList[i]['total'] = value * double.parse(basket.iPRICE!);
        }
      }

      AddBKRReq addReturn = AddBKRReq(
        cREFDOC: "",
        cSENDER: GlobalParam.VEHICLE['cBRANCD'],
        cRECEIVER: GlobalParam.stockSupSelect.cSUPCD,
        cBASKCD: basket.cBASKCD,
        iQTY: value,
        iTOTAL: value * double.parse(basket.iPRICE!),
        cTYPE: "BTS",
        cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
        cVEHICD: "",
        cGRPCD: "",
        cRTECD: "",
        cCREABY: GlobalParam.userData.cUSRNM,
      );
      var check = false;
      for (var i = 0; i < returnList.length; i++) {
        if (returnList[i].cBASKCD == addReturn.cBASKCD) {
          check = true;
        }
      }

      if (check == true) {
        for (var i = 0; i < returnList.length; i++) {
          if (returnList[i].cBASKCD == addReturn.cBASKCD) {
            returnList.removeAt(i);
            returnList.add(addReturn);
          }
        }
      } else {
        returnList.add(addReturn);
      }

      for (int i = 0; i < basketToStockReqList.length; i++) {
        if (basketToStockReqList[i].cBASKCD == basket.cBASKCD) {
          if (type == 'increase') {
            if (value == 0) {
              GlobalParam.deliveryBasketShow[index].cICUK = true;
              GlobalParam.deliveryBasketShow[index].cDCUL = true;
            } else {
              GlobalParam.deliveryBasketShow[index].cDCUL = false;
            }
            basketToStockReqList[i].iTRUEQTY =
                '${double.parse(basketToStockReqList[i].iQTY!) + value}';
          } else if (type == 'decrease') {
            if (value == 0) {
              GlobalParam.deliveryBasketShow[index].cICUK = true;
              GlobalParam.deliveryBasketShow[index].cDCUL = true;
            } else {
              GlobalParam.deliveryBasketShow[index].cICUK = false;
            }
            basketToStockReqList[i].iTRUEQTY =
                '${double.parse(basketToStockReqList[i].iQTY!) - value}';
          }
        }
      }
    });
  }

  addReturnBasketToStock() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var check = 0;
      for (int i = 0; i < basketToStockReqList.length; i++) {
        basketToStockReqList[i].iSEQ = i + 1;
        var result =
            await proxy.addReturnBasketToStock(basketToStockReqList[i]);
        if (result.success == false) {
          wrongDialog('${result.message}');
        } else {
          check++;
        }
      }

      if (check == basketToStockReqList.length) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => HomePage(GlobalParam.typeMenuCode!)),
            (Route route) => false);
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  saveData() {
    if (returnList.length > 0) {
      for (var i = 0; i < returnList.length; i++) {
        addBasketStockCard();
        addReturnBasketToStock();
      }
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => HomePage(GlobalParam.typeMenuCode!)),
          (Route route) => false);
    }
  }
}
