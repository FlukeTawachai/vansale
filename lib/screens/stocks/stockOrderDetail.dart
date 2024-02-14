import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addBarsketStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/addStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/addSupplierCreditReq.dart';
import 'package:vansale/api/class/request/mobile/addSupplierReceiveDT.dart';
import 'package:vansale/api/class/request/mobile/addSupplierReceiveHDReq.dart';
import 'package:vansale/api/class/request/mobile/getSPOrderDTReq.dart';
import 'package:vansale/api/class/request/mobile/supplierCreditPayReq.dart';
import 'package:vansale/api/class/request/mobile/updateStatusAPPOHD.dart';
import 'package:vansale/api/class/response/routeMobile/getSPOrderDTResp.dart';
import 'package:vansale/screens/Supplier/models/delayTime.dart';
import 'package:vansale/screens/delivery/delivery_scanner.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_filter.dart';
import 'package:vansale/screens/stocks/supplierFooter.dart';
import 'package:vansale/screens/stocks/stockImages.dart';

DelayTime delay = new DelayTime();

class StockOrderDetail extends StatefulWidget {
  StockOrderDetail();
  @override
  _StockOrderDetailState createState() => _StockOrderDetailState();
}

class _StockOrderDetailState extends State<StockOrderDetail> {
  double widthScreen = 0;
  var proItem = 0;
  var proTotal = 0.0;
  List<GetSPOrderDTResp> products = [];
  var unitList = [];
  double sumItem = 0;
  bool canSave = true;
  var search = TextEditingController();

  // ignore: deprecated_member_use
  List<TextEditingController> incomCon = [];
  // ignore: deprecated_member_use
  List<TextEditingController> plusCon = [];

  String total = '0.0';
  List<double> itemTotalList = [];
  final formatNum = new NumberFormat("#,###.##", "en_US");
  var totalProGoodList = [];
  var proIncom = 0;
  var proPlus = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = [];
    GlobalParam.supplierCheckProList = [];
    if (GlobalParam.deliveryRegetPODT == true) {
      for (int i = 0; i < GlobalParam.supplierOrProductShowList.length; i++) {
        if (GlobalParam.supplierOrProductShowList[i].cPOCD ==
            GlobalParam.supplierSelectOrder!.cPOCD) {
          proTotal +=
              double.parse(GlobalParam.supplierOrProductShowList[i].iNETPRICE!);
          proItem++;
          products.add(GlobalParam.supplierOrProductShowList[i]);
          itemTotalList.add(
              double.parse(GlobalParam.supplierOrProductShowList[i].iPURCHASE!));

          GlobalParam.supplierCheckProList.add(false);
        }
      }
    }

    products.sort((a, b) => a.iSEQ!.compareTo(b.iSEQ!));

    for (int i = 0; i < products.length; i++) {
      incomCon.add(new TextEditingController());
      plusCon.add(new TextEditingController());
      incomCon[i].text = '';
      plusCon[i].text = '';
    }

    for (int i = 0; i < products.length; i++) {
      sumItem += double.parse(products[i].iSSTOCK!) +
          double.parse(products[i].iMSTOCK!) +
          double.parse(products[i].iLSTOCK!);

      // if (double.parse(products[i].iSSTOCK) != 0.0) {
      //   var data = {
      //     "cUOMNM": products[i].cSUOMNM,
      //     "iPRICE": double.parse(products[i].iNETPRICE) /
      //         double.parse(products[i].iSSTOCK),
      //     "iTOTAL": double.parse(products[i].iSSTOCK)
      //   };
      //   unitList.add(data);
      // } else if (double.parse(products[i].iMSTOCK) != 0.0) {
      //   var data = {
      //     "cUOMNM": products[i].cMUOMNM,
      //     "iPRICE": double.parse(products[i].iNETPRICE) /
      //         double.parse(products[i].iMSTOCK),
      //     "iTOTAL": double.parse(products[i].iMSTOCK)
      //   };
      //   unitList.add(data);
      // }
      if (double.parse(products[i].iPURCHASE!) != 0.0) {
        var data = {
          "cUOMNM": products[i].cLUOMNM,
          "iPRICE": double.parse(products[i].iLUNITPRICE!),
          "iTOTAL": double.parse(products[i].iPURCHASE!)
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
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0.0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            'รับสินค้า',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Prompt',
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlobalParam.subMenuCode != "003"
                  ? Container(
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
                                      controller: search,
                                      onSubmitted: (value) {
                                        setState(() {
                                          search.text = value;

                                          if (search.text == '') {
                                            for (int i = 0;
                                                i <
                                                    GlobalParam
                                                        .supplierOrProductList
                                                        .length;
                                                i++) {
                                              if (GlobalParam
                                                      .supplierOrProductList[i]
                                                      .cPOCD ==
                                                  GlobalParam
                                                      .supplierSelectOrder!
                                                      .cPOCD) {
                                                proTotal += double.parse(
                                                    GlobalParam
                                                        .supplierOrProductList[
                                                            i]
                                                        .iNETPRICE!);
                                                proItem++;
                                                products.add(GlobalParam
                                                    .supplierOrProductList[i]);
                                              }
                                            }
                                          } else {
                                            getSPOrderDTShow(
                                                GlobalParam
                                                    .supplierSelectOrder!.cPOCD!,
                                                '${search.text}',
                                                '');
                                          }
                                        });
                                      },
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                      ),
                                      textInputAction: TextInputAction.search,
                                      decoration: InputDecoration(
                                        hintText: "ค้นหา",
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 5.0, top: 5.0),
                                        prefixIcon: RotatedBox(
                                          quarterTurns: 1,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.search,
                                              color: HexColor('#6c7e9b'),
                                            ),
                                            onPressed: () {
                                              if (search.text == '') {
                                                for (int i = 0;
                                                    i <
                                                        GlobalParam
                                                            .supplierOrProductList
                                                            .length;
                                                    i++) {
                                                  if (GlobalParam
                                                          .supplierOrProductList[
                                                              i]
                                                          .cPOCD ==
                                                      GlobalParam
                                                          .supplierSelectOrder!
                                                          .cPOCD!) {
                                                    proTotal += double.parse(
                                                        GlobalParam
                                                            .supplierOrProductList[
                                                                i]
                                                            .iNETPRICE!);
                                                    proItem++;
                                                    products.add(GlobalParam
                                                        .supplierOrProductList[i]);
                                                  }
                                                }
                                              } else {
                                                getSPOrderDTShow(
                                                    GlobalParam
                                                        .supplierSelectOrder!
                                                        .cPOCD!,
                                                    '${search.text}',
                                                    '');
                                              }
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
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DeliveryQrScanner(
                                                      code: '006',
                                                      navigator: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        StockOrderDetail()));
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
                                      builder: (context) => FilterPage(
                                            pageNumber: '003',
                                          )));
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
                    )
                  : Container(),
              Expanded(
                  child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        // incomCon.add(new TextEditingController());
                        // plusCon.add(new TextEditingController());
                        double unitPrice = 0.0;
                        double item = 0.0;
                        String unitNM = '';
                        String unitCD = '';

                        // GlobalParam.supplierCheckProList.add(false);

                        // incomCon[index].text = '0';
                        // plusCon[index].text = '0';
                        if (double.parse(products[index].iPURCHASE!) != 0) {
                          item = double.parse(products[index].iPURCHASE!);
                          unitPrice = double.parse(products[index].iLUNITPRICE!);
                          if (products[index].cLUOMCD != '' &&
                              products[index].cLUOMCD != null) {
                            unitNM = products[index].cLUOMNM!;
                            unitCD = products[index].cLUOMCD!;
                          } else {
                            if (products[index].cMUOMCD != '' &&
                                products[index].cMUOMCD != null) {
                              unitNM = products[index].cMUOMNM!;
                              unitCD = products[index].cMUOMCD!;
                            } else {
                              if (products[index].cSUOMCD != '' &&
                                  products[index].cSUOMCD != null) {
                                unitNM = products[index].cSUOMNM!;
                                unitCD = products[index].cSUOMCD!;
                              }
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
                                height: 128.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5.0),
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                          image:
                                              products[index].cPHOTOPATH != ''
                                                  ? DecorationImage(
                                                      image: new NetworkImage(
                                                        'http://${products[index].cPHOTOSERV}/${products[index].cPHOTOPATH}',
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
                                          border:
                                              Border.all(color: Colors.grey)),
                                    ),
                                    //----------------------1
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  // width: widthScreen * 0.48,
                                                  height: 24,
                                                  child: Text(
                                                    products[index].cPRODNM!,
                                                    style: TextStyle(
                                                      fontFamily: 'Prompt',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //----------------------------2
                                            Container(
                                              height: 28,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: widthScreen * 0.48,
                                                    // padding: const EdgeInsets.all(5.0),
                                                    // alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      '$unitNM',
                                                      style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (products[index]
                                                                .cCHECK ==
                                                            false) {
                                                          products[index]
                                                              .cCHECK = true;
                                                          GlobalParam
                                                              .supplierCheckCounter++;
                                                        } else {
                                                          products[index]
                                                              .cCHECK = false;
                                                          GlobalParam
                                                              .supplierCheckCounter--;
                                                        }
                                                      });
                                                    },
                                                    child:
                                                        products[index]
                                                                    .cCHECK ==
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
                                            ),
                                            //--------------------2
                                            // SizedBox(
                                            //   height: 12,
                                            // ),
                                            Container(
                                              height: 28,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Center(
                                                        child: Text(
                                                          'จำนวน',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Center(
                                                        child: Text(
                                                          'ขาด',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color: Colors.red,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Center(
                                                        child: Text(
                                                          'เกิน',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 14),
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
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 5.0),
                                                      height: 30.0,
                                                      width: 80.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
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
                                                            color: Colors.grey),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '${formatNum.format(itemTotalList[index])}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 5.0),
                                                      height: 30.0,
                                                      width: 80.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
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
                                                            color: Colors.grey),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 8, 0, 0),
                                                        child: TextField(
                                                          controller:
                                                              incomCon[index],
                                                          onChanged: (value) {
                                                            if (value == '') {
                                                              value = '0';
                                                            }
                                                            for (int i = 0;
                                                                i <
                                                                    GlobalParam
                                                                        .supplierIncomProList
                                                                        .length;
                                                                i++) {
                                                              if (GlobalParam
                                                                          .supplierIncomProList[i]
                                                                      [
                                                                      "cPRODCD"] ==
                                                                  products[
                                                                          index]
                                                                      .cPRODCD) {
                                                                GlobalParam
                                                                    .supplierIncomProList
                                                                    .removeAt(
                                                                        i);
                                                              }
                                                            }
                                                            proTotal -=
                                                                double.parse(
                                                                        value) *
                                                                    unitPrice;
                                                            item -=
                                                                double.parse(
                                                                    value);

                                                            // print(
                                                            //     '+++++++$item');

                                                            setState(() {
                                                              incomCon[index]
                                                                  .text = value;
                                                              itemTotalList[
                                                                  index] = item;
                                                            });
                                                            var data = {
                                                              "cBRANCD": GlobalParam
                                                                      .VEHICLE[
                                                                  'cBRANCD'],
                                                              "cBASKCD":
                                                                  products[
                                                                          index]
                                                                      .cBASKCD,
                                                              "cBRANNM": GlobalParam
                                                                      .VEHICLE[
                                                                  'cBRANNM'],
                                                              "cBASKNM":
                                                                  products[
                                                                          index]
                                                                      .cBASKNM,
                                                              "cBASKPRICE":
                                                                  products[
                                                                          index]
                                                                      .iPRICE,
                                                              "cBKUNIT":
                                                                  "B0001",
                                                              "cPRODCD":
                                                                  products[
                                                                          index]
                                                                      .cPRODCD,
                                                              "cPRODNM":
                                                                  products[
                                                                          index]
                                                                      .cPRODNM,
                                                              "cPROUNIT":
                                                                  unitCD,
                                                              "iPROPRICE":
                                                                  unitPrice,
                                                              "iSEQ": products[
                                                                      index]
                                                                  .iSEQ,
                                                              "iSSTOCK": '0',
                                                              "iMSTOCK": '0',
                                                              "iLSTOCK":
                                                                  products[
                                                                          index]
                                                                      .iPURCHASE,
                                                              "cSUOMCD":
                                                                  products[
                                                                          index]
                                                                      .cSUOMCD,
                                                              "cSUOMNM":
                                                                  products[
                                                                          index]
                                                                      .cSUOMNM,
                                                              "cMUOMCD":
                                                                  products[
                                                                          index]
                                                                      .cMUOMCD,
                                                              "cMUOMNM":
                                                                  products[
                                                                          index]
                                                                      .cMUOMNM,
                                                              "cLUOMCD":
                                                                  products[
                                                                          index]
                                                                      .cLUOMCD,
                                                              "cLUOMNM":
                                                                  products[
                                                                          index]
                                                                      .cLUOMNM,
                                                              "iTOTAL": products[
                                                                      index]
                                                                  .iNETPRICE,
                                                              "iINCOMQTY":
                                                                  value,
                                                              "iPLUSHQTY": '0',
                                                            };

                                                            GlobalParam
                                                                .supplierIncomProList
                                                                .add(data);
                                                            if (int.parse(plusCon[
                                                                            index]
                                                                        .text) !=
                                                                    0 &&
                                                                plusCon[index]
                                                                        .text !=
                                                                    '') {
                                                              errDialog(
                                                                  'หากสินค้าขาดมากกว่า 0 สินค้าเกินต้องเท่ากับ 0',
                                                                  index);
                                                            }
                                                          },
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontFamily:
                                                                'Prompt',
                                                          ),
                                                          cursorColor:
                                                              Colors.black,
                                                          decoration:
                                                              new InputDecoration(
                                                            //hintText: "1",
                                                            hintStyle: TextStyle(
                                                                color: HexColor(
                                                                    '#00cb39')),
                                                            border: InputBorder
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
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 5.0),
                                                      height: 30.0,
                                                      width: 80.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
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
                                                            color: Colors.grey),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 8, 0, 0),
                                                        child: TextField(
                                                          controller:
                                                              plusCon[index],
                                                          onChanged: (value) {
                                                            if (value == '') {
                                                              value = '0';
                                                            }
                                                            for (int i = 0;
                                                                i <
                                                                    GlobalParam
                                                                        .supplierIncomProList
                                                                        .length;
                                                                i++) {
                                                              if (GlobalParam
                                                                          .supplierIncomProList[i]
                                                                      [
                                                                      "cPRODCD"] ==
                                                                  products[
                                                                          index]
                                                                      .cPRODCD) {
                                                                GlobalParam
                                                                    .supplierIncomProList
                                                                    .removeAt(
                                                                        i);
                                                              }
                                                            }

                                                            proTotal +=
                                                                double.parse(
                                                                        value) *
                                                                    unitPrice;
                                                            item +=
                                                                double.parse(
                                                                    value);
                                                            // print(
                                                            //     '+++++++$item');
                                                            setState(() {
                                                              plusCon[index]
                                                                  .text = value;
                                                              itemTotalList[
                                                                  index] = item;
                                                            });
                                                            var data = {
                                                              "cBRANCD": GlobalParam
                                                                      .VEHICLE[
                                                                  'cBRANCD'],
                                                              "cBASKCD":
                                                                  products[
                                                                          index]
                                                                      .cBASKCD,
                                                              "cBRANNM": GlobalParam
                                                                      .VEHICLE[
                                                                  'cBRANNM'],
                                                              "cBASKNM":
                                                                  products[
                                                                          index]
                                                                      .cBASKNM,
                                                              "cBASKPRICE":
                                                                  products[
                                                                          index]
                                                                      .iPRICE,
                                                              "cBKUNIT":
                                                                  "B0001",
                                                              "cPRODCD":
                                                                  products[
                                                                          index]
                                                                      .cPRODCD,
                                                              "cPRODNM":
                                                                  products[
                                                                          index]
                                                                      .cPRODNM,
                                                              "iSEQ": products[
                                                                      index]
                                                                  .iSEQ,
                                                              "cPROUNIT":
                                                                  unitCD,
                                                              "iPROPRICE":
                                                                  unitPrice,
                                                              "iSSTOCK": '0',
                                                              "iMSTOCK": '0',
                                                              "iLSTOCK":
                                                                  products[
                                                                          index]
                                                                      .iPURCHASE,
                                                              "cSUOMCD":
                                                                  products[
                                                                          index]
                                                                      .cSUOMCD,
                                                              "cSUOMNM":
                                                                  products[
                                                                          index]
                                                                      .cSUOMNM,
                                                              "cMUOMCD":
                                                                  products[
                                                                          index]
                                                                      .cMUOMCD,
                                                              "cMUOMNM":
                                                                  products[
                                                                          index]
                                                                      .cMUOMNM,
                                                              "cLUOMCD":
                                                                  products[
                                                                          index]
                                                                      .cLUOMCD,
                                                              "cLUOMNM":
                                                                  products[
                                                                          index]
                                                                      .cLUOMNM,
                                                              "iTOTAL": products[
                                                                      index]
                                                                  .iNETPRICE,
                                                              "iINCOMQTY": '0',
                                                              "iPLUSHQTY":
                                                                  value,
                                                            };

                                                            GlobalParam
                                                                .supplierIncomProList
                                                                .add(data);

                                                            if (double.parse(incomCon[
                                                                            index]
                                                                        .text) !=
                                                                    0 &&
                                                                incomCon[index]
                                                                        .text !=
                                                                    '') {
                                                              errDialog(
                                                                  'หากสินค้าเกินมากกว่า 0 สินค้าขาดต้องเท่ากับ 0',
                                                                  index);
                                                            }
                                                          },
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: HexColor(
                                                                '#00cb39'),
                                                            fontFamily:
                                                                'Prompt',
                                                          ),
                                                          cursorColor:
                                                              Colors.black,
                                                          decoration:
                                                              new InputDecoration(
                                                            //hintText: "1",
                                                            hintStyle: TextStyle(
                                                                color: HexColor(
                                                                    '#00cb39')),
                                                            border: InputBorder
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
                                        width: widthScreen * 0.25,
                                        child: Text(
                                          'ต่อหน่วย',
                                          style: TextStyle(
                                              fontFamily: 'Prompt',
                                              fontSize: 14),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      Container(
                                        width: widthScreen * 0.2,
                                        child: Text(
                                          '${formatNum.format(unitPrice)} ฿',
                                          style: TextStyle(
                                              fontFamily: 'Prompt',
                                              fontSize: 14),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      Container(
                                        width: widthScreen * 0.1,
                                        child: Text(
                                          'รวม',
                                          style: TextStyle(
                                              fontFamily: 'Prompt',
                                              fontSize: 14),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      Container(
                                        width: widthScreen * 0.25,
                                        child: Text(
                                          '${formatNum.format((unitPrice * itemTotalList[index]))} ฿',
                                          style: TextStyle(
                                              fontFamily: 'Prompt',
                                              fontSize: 14),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
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
                      })),
            ],
          ),
        ),
        bottomNavigationBar: SupplierOrderFooter(
          item: '$proItem',
          total: '$proTotal',
          title1: 'บันทึกรับสินค้า',
          title2: 'สินค้ารอนับ',
          check: '${GlobalParam.supplierCheckCounter}',
          unCheck:
              '${GlobalParam.supplierCheckProList.length - GlobalParam.supplierCheckCounter}',
          navigated1: () {
            bool canSave = true;
            // print(
            // '++++++++++++++++ ${GlobalParam.supplierIncomProList.length}');
            // for (int i = 0; i < GlobalParam.supplierIncomProList.length; i++) {}
            if (GlobalParam.supplierSelectOrder!.cPOSTATUS != '3' ||
                GlobalParam.supplierSelectOrder!.cPOSTATUS != '4' ||
                GlobalParam.supplierSelectOrder!.cPOSTATUS != '5') {
              for (int i = 0; i < products.length; i++) {
                print('$i-----------------${products[i].cCHECK}');
                if (products[i].cCHECK == false) {
                  canSave = false;
                }
              }
              if (canSave == true) {
                addStockCard();
              } else {
                wrongDialog('กรุณาตรวจนับสินค้าทุกรายการ');
              }
            } else {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StockBillImage()));
            }
          },
          navigated2: () {
            setState(() {
              products.sort(
                  (a, b) => a.cCHECK.toString().compareTo(b.cCHECK.toString()));
            });
          },
          icon1: Icon(
            LineAwesomeIcons.check_circle,
            color: Colors.green,
            size: 25.0,
          ),
          icon2: Icon(
            LineAwesomeIcons.box,
            color: Colors.red,
            size: 25.0,
          ),
        ));
  }

  addSupplierCredit() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var INCOMQTY = 0;
      var PLUSQTY = 0;
      var iBKINCOMTOTAL = 0.0;
      var iBKPLUSTOTAL = 0.0;
      var iPROINCOMTOTAL = 0.0;
      var iPROPLUSTOTAL = 0.0;
      for (int i = 0; i < GlobalParam.supplierIncomProList.length; i++) {
        INCOMQTY = int.parse(GlobalParam.supplierIncomProList[i]["iINCOMQTY"]);
        PLUSQTY = int.parse(GlobalParam.supplierIncomProList[i]["iPLUSHQTY"]);
        iBKINCOMTOTAL =
            double.parse(GlobalParam.supplierIncomProList[i]["cBASKPRICE"]) *
                int.parse(GlobalParam.supplierIncomProList[i]["iINCOMQTY"]);
        iBKPLUSTOTAL =
            double.parse(GlobalParam.supplierIncomProList[i]["cBASKPRICE"]) *
                int.parse(GlobalParam.supplierIncomProList[i]["iPLUSHQTY"]);

        iPROINCOMTOTAL = GlobalParam.supplierIncomProList[i]["iPROPRICE"] *
            int.parse(GlobalParam.supplierIncomProList[i]["iINCOMQTY"]);

        iPROPLUSTOTAL = GlobalParam.supplierIncomProList[i]["iPROPRICE"] *
            int.parse(GlobalParam.supplierIncomProList[i]["iPLUSHQTY"]);
        // print('$i+++++++++++++${INCOMQTY}');
        if (INCOMQTY > 0) {
          var result = await proxy.addSupplierCredit(AddSupplierCreditReq(
              cSUPPCD: GlobalParam.supplierSelectOrder!.cSUPPCD,
              cSUPPNM: GlobalParam.supplierSelectOrder!.cSUPPNM,
              cREFDOC: GlobalParam.supplierSelectOrder!.cPOCD,
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cBRANNM: GlobalParam.VEHICLE['cBRANNM'],
              cPRODCD: GlobalParam.supplierIncomProList[i]["cPRODCD"],
              cPRODNM: GlobalParam.supplierIncomProList[i]["cPRODNM"],
              cSUOMCD: GlobalParam.supplierIncomProList[i]["cSUOMCD"],
              cSUOMNM: GlobalParam.supplierIncomProList[i]["cSUOMNM"],
              cMUOMCD: GlobalParam.supplierIncomProList[i]["cMUOMCD"],
              cMUOMNM: GlobalParam.supplierIncomProList[i]["cMUOMNM"],
              cLUOMCD: GlobalParam.supplierIncomProList[i]["cLUOMCD"],
              cLUOMNM: GlobalParam.supplierIncomProList[i]["cLUOMNM"],
              iSUNITPRICE: "0",
              iMUNITPRICE: "0",
              iLUNITPRICE:
                  "${double.parse(GlobalParam.supplierIncomProList[i]["iTOTAL"]) / double.parse(GlobalParam.supplierIncomProList[i]["iLSTOCK"])}",
              iORQTY:
                  "${double.parse(GlobalParam.supplierIncomProList[i]["iLSTOCK"])}",
              iDEBIT: "0",
              iCREDIT: '$INCOMQTY',
              iRCQTY:
                  "${double.parse(GlobalParam.supplierIncomProList[i]["iLSTOCK"]) - INCOMQTY}",
              cCREABY: "${GlobalParam.userID}"));
          if (result.success == false) {
            wrongDialog(result.message);
          }
        }
      }

      supplierCreditPay();

      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  addSupplierReceiveHD() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.addSupplierReceiveHD(AddSupplierReceiveHDReq(
          cREFDOC: GlobalParam.supplierSelectOrder!.cPOCD,
          cRECEIVEBY: GlobalParam.userID,
          iBEFOREVAT: GlobalParam.supplierSelectOrder!.iBEFOREVAT,
          iVATVAL: GlobalParam.supplierSelectOrder!.iVATVAL,
          iSKIPVAT: GlobalParam.supplierSelectOrder!.iSKIPVAT,
          iTOTAL: GlobalParam.supplierSelectOrder!.iTOTAL,
          cREMARK: "",
          cCREABY: GlobalParam.userID));

      if (result.success == false) {
        wrongDialog(result.message);
      } else {
        addSupplierReceiveDT(result.result);
        GlobalParam.supplierReceive_NO = result.result;
      }

      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  addSupplierReceiveDT(String cRECEIVENO) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      for (int i = 0; i < products.length; i++) {
        var plus = '0', incom = '0';
        for (int j = 0; j < GlobalParam.supplierIncomProList.length; j++) {
          if (GlobalParam.supplierIncomProList[j]['cPRODCD'] ==
              products[i].cPRODCD) {
            plus = GlobalParam.supplierIncomProList[j]['iPLUSHQTY'];
            incom = GlobalParam.supplierIncomProList[j]['iINCOMQTY'];
          }
        }
        var result = await proxy.addSupplierReceiveDT(AddSupplierReceiveDTReq(
            cRECEIVENO: cRECEIVENO,
            iSEQ: '${products[i].iSEQ}',
            cPRODCD: products[i].cPRODCD,
            cPRODNM: products[i].cPRODNM,
            cBRNDCD: products[i].cBRNDCD,
            cBRNDNM: products[i].cBRNNM,
            cSUOMCD: products[i].cSUOMCD,
            cSUOMNM: products[i].cSUOMNM,
            cMUOMCD: products[i].cMUOMCD,
            cMUOMNM: products[i].cMUOMNM,
            cLUOMCD: products[i].cLUOMCD,
            cLUOMNM: products[i].cLUOMNM,
            iSORDERQTY: '0',
            iMORDERQTY: '0',
            iLORDERQTY: products[i].iPURCHASE,
            iPLUSQTY: plus,
            iLOSSQTY: incom,
            cREMARK: "",
            cCREABY: GlobalParam.userID));
        if (result.success == false) {
          wrongDialog(result.message);
        }
      }

      addSupplierCredit();

      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  supplierCreditPay() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      for (int i = 0; i < products.length; i++) {
        var result = await proxy.supplierCreditPay(SupplierCreditPayReq(
            cSUPPCD: GlobalParam.supplierSelectOrder!.cSUPPCD,
            cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
            cPRODCD: products[i].cPRODCD,
            cCREABY: GlobalParam.userID));
        if (result.success == false) {
          wrongDialog(result.message);
        }
      }

      // setState(() {});
      updateStatusAPPOHD();
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
      GlobalParam.supplierCheckProList = [];
      var BasketCDList = [];
      var basketQty = 0;
      for (int i = 0; i < products.length; i++) {
        String cUOMCD = '';
        double qty = 0;
        double proQTY = 0;

        if (double.parse(products[i].iPURCHASE!) != 0) {
          proQTY = double.parse(products[i].iPURCHASE!);
          qty = proQTY;
          if (products[i].cLUOMCD != '' && products[i].cLUOMCD != null) {
            cUOMCD = products[i].cLUOMCD!;
          } else {
            if (products[i].cMUOMCD != '' && products[i].cMUOMCD != null) {
              cUOMCD = products[i].cMUOMCD!;
            } else {
              if (products[i].cSUOMCD != '' && products[i].cSUOMCD != null) {
                cUOMCD = products[i].cSUOMCD!;
              }
            }
          }

          for (int j = 0; j < GlobalParam.supplierIncomProList.length; j++) {
            if (GlobalParam.supplierIncomProList[j]['cPRODCD'] ==
                products[i].cPRODCD) {
              qty += double.parse(
                  GlobalParam.supplierIncomProList[j]['iPLUSHQTY']);
            }
          }

          // for (int j = 0; j < GlobalParam.supplierIncomProList.length; j++) {
          //   if (GlobalParam.supplierIncomProList[j]['cPRODCD'] ==
          //       products[i].cPRODCD) {
          //     qty = proQTY;
          //   }
          // }

          BasketCDList.add(products[i].cBASKCD);

          StockCardReq proList = StockCardReq(
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cPRODCD: products[i].cPRODCD,
              cUOMCD: cUOMCD,
              cWH: 'FG',
              cREFDOC: GlobalParam.supplierSelectOrder!.cPOCD,
              iRECEIVEQTY: '${qty.toStringAsFixed(0)}',
              iISSUEQTY: '0',
              cREMARK: '',
              cLOTNO: '',
              cCREABY: GlobalParam.userID);

          stockCardReqList.add(proList);
        }
      }
      var uniqueBasCD = [];

      var uniquelist = BasketCDList.toSet().toList();
      var uniqueBasketData = [];

      for (int i = 0; i < uniquelist.length; i++) {
        var basketQty = 0.0;
        for (int j = 0; j < products.length; j++) {
          if (uniquelist[i] == products[j].cBASKCD) {
            basketQty += double.parse(products[j].iPURCHASE!);
          }
        }

        for (int j = 0; j < GlobalParam.supplierIncomProList.length; j++) {
          if (GlobalParam.supplierIncomProList[j]['cBASKCD'] == uniquelist[i]) {
            basketQty +=
                double.parse(GlobalParam.supplierIncomProList[j]['iPLUSHQTY']);
          }
        }

        var data = {
          "cBASKCD": uniquelist[i],
          "cBASKNM": products[i].cBASKNM,
          "iRECEIVEQTY": basketQty.toStringAsFixed(0)
        };
        uniqueBasketData.add(data);
      }

      for (int i = 0; i < uniqueBasketData.length; i++) {
        addBasketStockCard(AddBasketStockCardReq(
            cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
            cBASKCD: uniqueBasketData[i]['cBASKCD'],
            cUOMCD: 'B0001',
            iRECEIVEQTY: uniqueBasketData[i]['iRECEIVEQTY'],
            cBASKNM: uniqueBasketData[i]['cBASKNM'],
            iISSUEQTY: '0',
            cCREABY: GlobalParam.userID,
            cREFDOC: GlobalParam.supplierSelectOrder!.cPOCD,
            cWH: 'BR',
            cREMARK: ''));
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
          wrongDialog(result.message);
        }
      }
      addSupplierReceiveHD();

      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  addBasketStockCard(AddBasketStockCardReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.addBasketStockCard(req);
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

  updateStatusAPPOHD() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.updateStatusAPPOHD(UpdateStatusAPPOHDReq(
          cPOCD: GlobalParam.supplierSelectOrder!.cPOCD,
          cCREABY: GlobalParam.userID));
      if (result.success == false) {
        wrongDialog(result.message);
      }
      // setState(() {
      //   canSave = false;
      // });

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => StockBillImage()),
          (Route<dynamic> route) => false);
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getSPOrderDTShow(String cPOCD, String cPRODNM, String cPRODCD) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getSPOrderDT(GetSPOrderDTReq(
          cPOCD: cPOCD, cPRODNM: '%$cPRODNM%', cPRODCD: '%$cPRODCD%'));

      if (result.isNotEmpty) {
        GlobalParam.supplierOrProductShowList = [];
        for (int i = 0; i < result.length; i++) {
          GlobalParam.supplierOrProductShowList.add(result[i]);
        }

        // setState(() {
        //   products = GlobalParam.supplierOrProductShowList;
        // });
      } else {
        GlobalParam.supplierOrProductShowList = [];
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
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

  errDialog(String msg, int index) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('ผิดพลาด'),
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
                    setState(() {
                      plusCon[index].text = '0';
                      incomCon[index].text = '0';
                      GlobalParam.supplierIncomProList.removeAt(index);
                    });
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
