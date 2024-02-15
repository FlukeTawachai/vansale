// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/class/globalparam.dart';

class DeliveryStoreProductMissList extends StatefulWidget {
  // final Map<String, dynamic> item;
  // DeliveryStoreProductMissList(
  //   this.item,
  // );
  @override
  State<DeliveryStoreProductMissList> createState() =>
      _DeliveryStoreProductMissListState();
}

class _DeliveryStoreProductMissListState
    extends State<DeliveryStoreProductMissList> {
  var IncomPro = TextEditingController();
  double widthScreen = 0;
  var numberFormat = NumberFormat("###.0#", "en_US");
  List<TextEditingController> controller = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GlobalParam.deliveryCustPOHisBtnCheck = [];
    for (var item in GlobalParam.deliveryPodtShow) {
      var unitCode = "";
      if (double.parse(item.iSSIZEQTY!) > 0) {
        unitCode = item.cSUOMCD!;
      }
      if (double.parse(item.iMSIZEQTY!) > 0) {
        unitCode = item.cMUOMCD!;
      }
      if (double.parse(item.iLSIZEQTY!) > 0) {
        unitCode = item.cLUOMCD!;
      }
      var data = {
        "cPRODCD": item.cPRODCD,
        "cUOMCD": unitCode,
        "CPROGD": false,
        "CPROBD": false,
        "iQTY": 0
      };
      GlobalParam.deliveryCustPOHisBtnCheck.add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return GlobalParam.deliveryPodtShow.isNotEmpty
        ? ListView.builder(
            reverse: false,
            padding: const EdgeInsets.all(5),
            itemCount: GlobalParam.deliveryPodtList.length,
            itemBuilder: (BuildContext context, int index) {
              double item = double.parse(
                      GlobalParam.deliveryPodtShow[index].iSSIZEQTY!) +
                  double.parse(GlobalParam.deliveryPodtShow[index].iMSIZEQTY!) +
                  double.parse(GlobalParam.deliveryPodtShow[index].iLSIZEQTY!);
              var unit = '';
              var unitCode = '';
              var hisPro = '0';
              var currentPro = '0';
              var unitPrice = 0.0;
              var total = 0.0;
              bool goodCheck = false;
              bool badCheck = false;
              controller.add(TextEditingController());

              if (double.parse(GlobalParam.deliveryPodtShow[index].iSSIZEQTY!) >
                  0) {
                unitCode = GlobalParam.deliveryPodtShow[index].cSUOMCD!;
                unit = GlobalParam.deliveryPodtShow[index].cSUOMNM!;
                currentPro =
                    double.parse(GlobalParam.deliveryPodtShow[index].iSSIZEQTY!)
                        .toStringAsFixed(0);
                unitPrice = double.parse(
                    GlobalParam.deliveryPodtShow[index].iSUNITPRICE!);
                total = double.parse(
                        GlobalParam.deliveryPodtShow[index].iSUNITPRICE!) *
                    double.parse(
                        GlobalParam.deliveryPodtShow[index].iSSIZEQTY!);
              }
              if (double.parse(GlobalParam.deliveryPodtShow[index].iMSIZEQTY!) >
                  0) {
                unitCode = GlobalParam.deliveryPodtShow[index].cMUOMCD!;
                unit = GlobalParam.deliveryPodtShow[index].cMUOMNM!;
                currentPro =
                    double.parse(GlobalParam.deliveryPodtShow[index].iMSIZEQTY!)
                        .toStringAsFixed(0);
                unitPrice = double.parse(
                    GlobalParam.deliveryPodtShow[index].iMUNITPRICE!);
                total = double.parse(
                        GlobalParam.deliveryPodtShow[index].iMUNITPRICE!) *
                    double.parse(
                        GlobalParam.deliveryPodtShow[index].iMSIZEQTY!);
              }
              if (double.parse(GlobalParam.deliveryPodtShow[index].iLSIZEQTY!) >
                  0) {
                unitCode = GlobalParam.deliveryPodtShow[index].cLUOMCD!;
                unit = GlobalParam.deliveryPodtShow[index].cLUOMNM!;
                currentPro =
                    double.parse(GlobalParam.deliveryPodtShow[index].iLSIZEQTY!)
                        .toStringAsFixed(0);
                unitPrice = double.parse(
                    GlobalParam.deliveryPodtShow[index].iLUNITPRICE!);
                total = double.parse(
                        GlobalParam.deliveryPodtShow[index].iLUNITPRICE!) *
                    double.parse(
                        GlobalParam.deliveryPodtShow[index].iLSIZEQTY!);
              }
              for (var item in GlobalParam.deliveryCustPOHisDate) {
                if (item.cPRODCD ==
                    GlobalParam.deliveryPodtShow[index].cPRODCD) {
                  if (double.parse(
                          GlobalParam.deliveryPodtShow[index].iSSIZEQTY!) >
                      0) {
                    hisPro = item.iSSIZEQTY!;
                  }
                  if (double.parse(
                          GlobalParam.deliveryPodtShow[index].iMSIZEQTY!) >
                      0) {
                    hisPro = item.iMSIZEQTY!;
                  }
                  if (double.parse(
                          GlobalParam.deliveryPodtShow[index].iLSIZEQTY!) >
                      0) {
                    hisPro = item.iLSIZEQTY!;
                  }
                }
              }

              for (var item in GlobalParam.deliveryCustPOHisBtnCheck) {
                if (item["cPRODCD"] ==
                    GlobalParam.deliveryPodtShow[index].cPRODCD) {
                  if (item["cUOMCD"] == unitCode) {
                    goodCheck = item['CPROGD'];
                    badCheck = item['CPROBD'];
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
                            height: 150.0,
                            decoration: BoxDecoration(
                                image: GlobalParam.deliveryPodtShow[index]
                                            .cPHOTOPATH !=
                                        ''
                                    ? DecorationImage(
                                        image: NetworkImage(
                                          'http://${GlobalParam.deliveryPodtShow[index].cPHOTOSERV}/${GlobalParam.deliveryPodtShow[index].cPHOTOPATH}',
                                        ),
                                        scale: 1.0,
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(
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
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${item.toStringAsFixed(0)} ${GlobalParam.deliveryPodtShow[index].cPRODNM}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Prompt',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 32,
                                      width: widthScreen * 0.25,
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: GlobalParam
                                                    .deliveryPodtShow.isNotEmpty
                                                ? Text(
                                                    '$unit',
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: 'Prompt',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.0),
                                                  )
                                                : const Text(
                                                    '',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: 'Prompt',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.0),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (goodCheck == true) {
                                            goodCheck = false;
                                          } else {
                                            goodCheck = true;
                                          }

                                          print('Good : $goodCheck');
                                        });

                                        for (var i = 0;
                                            i <
                                                GlobalParam
                                                    .deliveryCustPOHisBtnCheck
                                                    .length;
                                            i++) {
                                          if (GlobalParam
                                                      .deliveryCustPOHisBtnCheck[
                                                  i]["cPRODCD"] ==
                                              GlobalParam
                                                  .deliveryPodtShow[index]
                                                  .cPRODCD) {
                                            if (GlobalParam
                                                        .deliveryCustPOHisBtnCheck[
                                                    i]["cUOMCD"] ==
                                                unitCode) {
                                              GlobalParam
                                                      .deliveryCustPOHisBtnCheck[
                                                  i]['CPROGD'] = goodCheck;
                                              GlobalParam
                                                      .deliveryCustPOHisBtnCheck[
                                                  i]['CPROBD'] = false;
                                            }
                                          }
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        // padding: const EdgeInsets.all(5.0),
                                        height: 30.0,
                                        width: widthScreen * 0.18,
                                        decoration: BoxDecoration(
                                            color: goodCheck == false
                                                ? Colors.white
                                                : Colors.green.shade100,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5),
                                            ),
                                            border: Border.all(
                                                color: Colors.green)),
                                        child: const Center(
                                            child: Text('สินค้าดี',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontFamily: 'Prompt',
                                                    fontSize: 14.0),
                                                textAlign: TextAlign.center)),
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (badCheck == true) {
                                            badCheck = false;
                                          } else {
                                            badCheck = true;
                                          }

                                          print('Bad: $badCheck');
                                        });

                                        for (var i = 0;
                                            i <
                                                GlobalParam
                                                    .deliveryCustPOHisBtnCheck
                                                    .length;
                                            i++) {
                                          if (GlobalParam
                                                      .deliveryCustPOHisBtnCheck[
                                                  i]["cPRODCD"] ==
                                              GlobalParam
                                                  .deliveryPodtShow[index]
                                                  .cPRODCD) {
                                            if (GlobalParam
                                                        .deliveryCustPOHisBtnCheck[
                                                    i]["cUOMCD"] ==
                                                unitCode) {
                                              GlobalParam
                                                      .deliveryCustPOHisBtnCheck[
                                                  i]['CPROGD'] = false;
                                              GlobalParam
                                                      .deliveryCustPOHisBtnCheck[
                                                  i]['CPROBD'] = badCheck;
                                            }
                                          }
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        // padding: const EdgeInsets.all(5.0),
                                        height: 30.0,
                                        width: widthScreen * 0.18,
                                        decoration: BoxDecoration(
                                            color: badCheck == false
                                                ? Colors.white
                                                : Colors.red.shade100,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5),
                                            ),
                                            border:
                                                Border.all(color: Colors.red)),
                                        child: const Center(
                                            child: Text('สินค้าเสีย',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontFamily: 'Prompt',
                                                    fontSize: 14.0),
                                                textAlign: TextAlign.center)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 32.0,
                                          width: widthScreen * 0.2,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'รอบก่อน',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Prompt',
                                                fontSize: 14.0),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          // padding: const EdgeInsets.all(5.0),
                                          height: 30.0,
                                          width: widthScreen * 0.2,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade400,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                                bottomLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
                                              ),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Center(
                                              child: Text(hisPro,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Prompt',
                                                      fontSize: 14.0),
                                                  textAlign: TextAlign.center)),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 32.0,
                                            width: widthScreen * 0.2,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'รอบนี้',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Prompt',
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            // padding: const EdgeInsets.all(5.0),
                                            height: 30.0,
                                            width: widthScreen * 0.2,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5),
                                                ),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Center(
                                                child: Text(currentPro,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Prompt',
                                                        fontSize: 14.0),
                                                    textAlign:
                                                        TextAlign.center)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 32.0,
                                            width: widthScreen * 0.2,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'คืน/เหลือ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Prompt',
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            // padding: const EdgeInsets.all(5.0),
                                            height: 30.0,
                                            width: widthScreen * 0.2,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5),
                                                ),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Center(
                                              child: TextField(
                                                controller: controller[index],
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                  color: HexColor('#00cb39'),
                                                  fontFamily: 'Prompt',
                                                ),
                                                onChanged: (value) {
                                                  int iCANCLEPRO =
                                                      int.parse(value);
                                                  if (value == '' ||
                                                      value == null) {
                                                    iCANCLEPRO = 0;
                                                  }
                                                  if (iCANCLEPRO >
                                                      double.parse(
                                                          currentPro)) {
                                                    wrongDialog(
                                                        "คืนสินค้าได้ไม่เกินจำนวนสินค้ารอบนี้");
                                                    setState(() {
                                                      controller[index].text =
                                                          "0";
                                                    });
                                                  } else {
                                                    for (int i = 0;
                                                        i <
                                                            GlobalParam
                                                                .deliveryPodtList
                                                                .length;
                                                        i++) {
                                                      // ignore: unrelated_type_equality_checks
                                                      if (GlobalParam
                                                              .deliveryPodtList[
                                                                  i]
                                                              .iSEQ ==
                                                          GlobalParam
                                                              .deliveryPodtShow[
                                                                  index]
                                                              .iSEQ) {
                                                        GlobalParam
                                                                .deliveryPodtList[i]
                                                                .iCANCLEPRO =
                                                            iCANCLEPRO;

                                                        // print('---------------${GlobalParam
                                                        //     .deliveryPodtList[i]
                                                        //     .iCANCLEPRO}');
                                                      }
                                                    }
                                                    for (var item in GlobalParam
                                                        .deliveryCustPOHisBtnCheck) {
                                                      if (item["cPRODCD"] ==
                                                          GlobalParam
                                                              .deliveryPodtShow[
                                                                  index]
                                                              .cPRODCD) {
                                                        if (item["cUOMCD"] ==
                                                            unitCode) {
                                                          item['iQTY'] =
                                                              iCANCLEPRO;
                                                        }
                                                      }
                                                    }
                                                  }
                                                },
                                                cursorColor: Colors.black,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        SizedBox(
                          width: widthScreen * 0.2,
                          child: const Text(
                            "ต่อหน่วย",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Prompt',
                                fontSize: 14.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(
                          width: widthScreen * 0.22,
                          child: Text(
                            "${numberFormat.format(unitPrice)} ฿",
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Prompt',
                                fontSize: 14.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(
                          width: widthScreen * 0.1,
                          child: const Text(
                            "รวม",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Prompt',
                                fontSize: 14.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(
                          width: widthScreen * 0.22,
                          child: Text(
                            "${numberFormat.format(total)} ฿",
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Prompt',
                                fontSize: 14.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const DottedLine(
                      dashColor: Colors.grey,
                    ),
                  ],
                ),
              );
            },
          )
        : Container();
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
