// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/function/substring_price.dart';

class DeliveryGoodProductCard extends StatefulWidget {
  DeliveryGoodProductCard();
  @override
  _DeliveryGoodProductCardState createState() =>
      _DeliveryGoodProductCardState();
}

class _DeliveryGoodProductCardState extends State<DeliveryGoodProductCard> {
  double widthScreen;
  String total = '0.0';
  final formatNum = new NumberFormat("#,###.##", "en_US");
  var totalProGoodList = [];
  List<TextEditingController> sController = [];
  List<TextEditingController> mController = [];
  List<TextEditingController> lController = [];

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return GlobalParam.deliveryShowHisProduct.length != 0
        ? ListView.builder(
            itemCount: GlobalParam.deliveryShowHisProduct.length,
            itemBuilder: (BuildContext context, int index) {
              sController.add(new TextEditingController());
              mController.add(new TextEditingController());
              lController.add(new TextEditingController());
              double unitPrice = 0.0;
              var unitCode = '';
              if (double.parse(
                      GlobalParam.deliveryShowHisProduct[index].iSSIZEQTY) !=
                  0) {
                unitPrice = double.parse(
                    GlobalParam.deliveryShowHisProduct[index].iSUNITPRICE);
                unitCode = GlobalParam.deliveryShowHisProduct[index].cSUOMCD;
              }
              if (double.parse(
                      GlobalParam.deliveryShowHisProduct[index].iMSIZEQTY) !=
                  0) {
                unitPrice = double.parse(
                    GlobalParam.deliveryShowHisProduct[index].iMUNITPRICE);
                unitCode = GlobalParam.deliveryShowHisProduct[index].cMUOMCD;
              }
              if (double.parse(
                      GlobalParam.deliveryShowHisProduct[index].iLSIZEQTY) !=
                  0) {
                unitPrice = double.parse(
                    GlobalParam.deliveryShowHisProduct[index].iLUNITPRICE);
                unitCode = GlobalParam.deliveryShowHisProduct[index].cLUOMCD;
              }

              for (var item in GlobalParam.deliveryCustPOHisBtnCheck) {
                if (item["cPRODCD"] ==
                    GlobalParam.deliveryShowHisProduct[index].cPRODCD) {
                  if (item["CPROGD"] == true) {
                    if (item["cUOMCD"] ==
                        GlobalParam.deliveryShowHisProduct[index].cSUOMCD) {
                      sController[index].text = '${item['iQTY']}';
                      for (int i = 0;
                          i < GlobalParam.deliveryHisProduct.length;
                          i++) {
                        // ignore: unrelated_type_equality_checks
                        if (GlobalParam.deliveryHisProduct[i].cPRODCD ==
                            item["cPRODCD"]) {
                          GlobalParam.deliveryHisProduct[index].iSSIZEQTY =
                              '${item['iQTY']}';
                        }
                      }
                    }

                    if (item["cUOMCD"] ==
                        GlobalParam.deliveryShowHisProduct[index].cMUOMCD) {
                      mController[index].text = '${item['iQTY']}';
                      for (int i = 0;
                          i < GlobalParam.deliveryHisProduct.length;
                          i++) {
                        // ignore: unrelated_type_equality_checks
                        if (GlobalParam.deliveryHisProduct[i].cPRODCD ==
                            item["cPRODCD"]) {
                          GlobalParam.deliveryHisProduct[index].iMSIZEQTY =
                              '${item['iQTY']}';
                        }
                      }
                    }
                    if (item["cUOMCD"] ==
                        GlobalParam.deliveryShowHisProduct[index].cLUOMCD) {
                      lController[index].text = '${item['iQTY']}';
                      for (int i = 0;
                          i < GlobalParam.deliveryHisProduct.length;
                          i++) {
                        // ignore: unrelated_type_equality_checks
                        if (GlobalParam.deliveryHisProduct[i].cPRODCD ==
                            item["cPRODCD"]) {
                          GlobalParam.deliveryHisProduct[index].iLSIZEQTY =
                              '${item['iQTY']}';
                        }
                      }
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
                                image: GlobalParam.deliveryShowHisProduct[index]
                                            .cPHOTOPATH !=
                                        ''
                                    ? DecorationImage(
                                        image: new NetworkImage(
                                          'http://${GlobalParam.deliveryShowHisProduct[index].cPHOTOSERV}/${GlobalParam.deliveryShowHisProduct[index].cPHOTOPATH}',
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
                                      GlobalParam.deliveryShowHisProduct[index]
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
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 36,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        double.parse(GlobalParam
                                                    .deliveryShowHisProduct[
                                                        index]
                                                    .iLSIZEQTY) !=
                                                0
                                            ? Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Center(
                                                    child: Text(
                                                      GlobalParam
                                                          .deliveryShowHisProduct[
                                                              index]
                                                          .cLUOMNM,
                                                      style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),

                                        double.parse(GlobalParam
                                                    .deliveryShowHisProduct[
                                                        index]
                                                    .iMSIZEQTY) !=
                                                0
                                            ? Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Center(
                                                    child: Text(
                                                      GlobalParam
                                                          .deliveryShowHisProduct[
                                                              index]
                                                          .cMUOMNM,
                                                      style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        // ignore: unrelated_type_equality_checks
                                        double.parse(GlobalParam
                                                    .deliveryShowHisProduct[
                                                        index]
                                                    .iSSIZEQTY) !=
                                                0
                                            ? Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Center(
                                                    child: Text(
                                                      GlobalParam
                                                          .deliveryShowHisProduct[
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
                                        double.parse(GlobalParam
                                                    .deliveryShowHisProduct[
                                                        index]
                                                    .iLSIZEQTY) !=
                                                0
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
                                                        int iINCOMPRO =
                                                            int.parse(value);
                                                        if (value == '' ||
                                                            value == null) {
                                                          iINCOMPRO = 0;
                                                        }

                                                        for (int i = 0;
                                                            i <
                                                                GlobalParam
                                                                    .deliveryShowHisProduct
                                                                    .length;
                                                            i++) {
                                                          // ignore: unrelated_type_equality_checks
                                                          if (GlobalParam
                                                                  .deliveryHisProduct[
                                                                      i]
                                                                  .cPRODCD ==
                                                              GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cPRODCD) {
                                                            GlobalParam
                                                                    .deliveryHisProduct[
                                                                        index]
                                                                    .iLSIZEQTY =
                                                                '$iINCOMPRO';
                                                          }
                                                        }

                                                        for (int i = 0;
                                                            i <
                                                                GlobalParam
                                                                    .totalProGoodList
                                                                    .length;
                                                            i++) {
                                                          if (GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cPRODCD ==
                                                              GlobalParam
                                                                      .totalProGoodList[i]
                                                                  ['proCode']) {
                                                            GlobalParam.totalProGoodList[
                                                                        i]
                                                                    ['total'] =
                                                                '${iINCOMPRO * unitPrice}';
                                                          }
                                                        }
                                                      },
                                                      enabled: GlobalParam
                                                                  .subMenuCode !=
                                                              "003"
                                                          ? true
                                                          : false,
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
                                        double.parse(GlobalParam
                                                    .deliveryShowHisProduct[
                                                        index]
                                                    .iMSIZEQTY) !=
                                                0
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
                                                        int iINCOMPRO =
                                                            int.parse(value);
                                                        if (value == '' ||
                                                            value == null) {
                                                          iINCOMPRO = 0;
                                                        }

                                                        for (int i = 0;
                                                            i <
                                                                GlobalParam
                                                                    .deliveryShowHisProduct
                                                                    .length;
                                                            i++) {
                                                          // ignore: unrelated_type_equality_checks
                                                          if (GlobalParam
                                                                  .deliveryHisProduct[
                                                                      i]
                                                                  .cPRODCD ==
                                                              GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cPRODCD) {
                                                            GlobalParam
                                                                    .deliveryHisProduct[
                                                                        index]
                                                                    .iMSIZEQTY =
                                                                '$iINCOMPRO';
                                                          }
                                                        }

                                                        for (int i = 0;
                                                            i <
                                                                GlobalParam
                                                                    .totalProGoodList
                                                                    .length;
                                                            i++) {
                                                          if (GlobalParam
                                                                  .deliveryShowHisProduct[
                                                                      index]
                                                                  .cPRODCD ==
                                                              GlobalParam
                                                                      .totalProGoodList[i]
                                                                  ['proCode']) {
                                                            GlobalParam.totalProGoodList[
                                                                        i]
                                                                    ['total'] =
                                                                '${iINCOMPRO * unitPrice}';
                                                          }
                                                        }
                                                      },
                                                      enabled: GlobalParam
                                                                  .subMenuCode !=
                                                              "003"
                                                          ? true
                                                          : false,
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
                                        double.parse(GlobalParam
                                                    .deliveryShowHisProduct[
                                                        index]
                                                    .iSSIZEQTY) !=
                                                0
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
                                                          int iINCOMPRO =
                                                              int.parse(value);
                                                          if (value == '' ||
                                                              value == null) {
                                                            iINCOMPRO = 0;
                                                          }

                                                          for (int i = 0;
                                                              i <
                                                                  GlobalParam
                                                                      .deliveryShowHisProduct
                                                                      .length;
                                                              i++) {
                                                            // ignore: unrelated_type_equality_checks
                                                            if (GlobalParam
                                                                    .deliveryHisProduct[
                                                                        i]
                                                                    .cPRODCD ==
                                                                GlobalParam
                                                                    .deliveryShowHisProduct[
                                                                        index]
                                                                    .cPRODCD) {
                                                              GlobalParam
                                                                      .deliveryHisProduct[
                                                                          index]
                                                                      .iSSIZEQTY =
                                                                  '$iINCOMPRO';

                                                              print(
                                                                  "++++++++++++ ${GlobalParam.deliveryHisProduct[index].iSSIZEQTY}");
                                                            }
                                                          }

                                                          for (int i = 0;
                                                              i <
                                                                  GlobalParam
                                                                      .totalProGoodList
                                                                      .length;
                                                              i++) {
                                                            if (GlobalParam
                                                                    .deliveryShowHisProduct[
                                                                        index]
                                                                    .cPRODCD ==
                                                                GlobalParam
                                                                        .totalProGoodList[i]
                                                                    [
                                                                    'proCode']) {
                                                              GlobalParam.totalProGoodList[
                                                                          i][
                                                                      'total'] =
                                                                  '${iINCOMPRO * unitPrice}';
                                                            }
                                                          }
                                                        },
                                                        enabled: GlobalParam
                                                                    .subMenuCode !=
                                                                "003"
                                                            ? true
                                                            : false,
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
                              'ต่อหน่วย ${formatNum.format(unitPrice)} ฿ รวม ${formatNum.format(double.parse(GlobalParam.totalProGoodList[index]['total']))} ฿',
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
}
