// ignore_for_file: unrelated_type_equality_checks

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/getSPOrderDTResp.dart';

class StockProductList extends StatefulWidget {
  StockProductList();
  @override
  _StockProductListState createState() => _StockProductListState();
}

class _StockProductListState extends State<StockProductList> {
  // ignore: deprecated_member_use
  List<TextEditingController> incomCon = [];
  // ignore: deprecated_member_use
  List<TextEditingController> plusCon = [];
  double widthScreen = 0;
  String total = '0.0';
  final formatNum = new NumberFormat("#,###.##", "en_US");
  var totalProGoodList = [];
  List<GetSPOrderDTResp> products = [];
  var proIncom = 0;
  var proPlus = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GlobalParam.supplierIncomProList = [];
    for (int i = 0; i < GlobalParam.supplierOrProductShowList.length; i++) {
      if (GlobalParam.supplierOrProductShowList[i].cPOCD ==
          GlobalParam.supplierSelectOrder!.cPOCD) {
        products.add(GlobalParam.supplierOrProductShowList[i]);
      }
    }
    products.sort((a, b) => a.iSEQ!.compareTo(b.iSEQ!));

    for (int i = 0; i < products.length; i++) {
      incomCon.add(new TextEditingController());
      plusCon.add(new TextEditingController());
      incomCon[i].text = '';
      plusCon[i].text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return ListView.builder(
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
                            image: products[index].cPHOTOPATH != ''
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
                            border: Border.all(color: Colors.grey)),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              //----------------------------2
                              Container(
                                height: 28,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: widthScreen * 0.48,
                                      // padding: const EdgeInsets.all(5.0),
                                      // alignment: Alignment.centerLeft,
                                      child: Text(
                                        'หน่วย $unitNM',
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
                                          if (GlobalParam.supplierCheckProList[
                                                  index] ==
                                              false) {
                                            GlobalParam.supplierCheckProList[
                                                index] = true;
                                            GlobalParam.supplierCheckCounter++;
                                          } else {
                                            GlobalParam.supplierCheckProList[
                                                index] = false;
                                            GlobalParam.supplierCheckCounter--;
                                          }
                                        });
                                      },
                                      child: GlobalParam.supplierCheckProList[
                                                  index] ==
                                              false
                                          ? Container(
                                              width: widthScreen * 0.2,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
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
                                                      fontSize: 16.0,
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
                                                    topLeft: Radius.circular(5),
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
                                                      fontSize: 16.0,
                                                      color: Colors.green),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                height: 26,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        alignment: Alignment.centerLeft,
                                        child: Center(
                                          child: Text(
                                            'จำนวน',
                                            style: TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 14),
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
                                                fontSize: 14),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        height: 30.0,
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${formatNum.format(item)}',
                                            style: TextStyle(
                                                fontFamily: 'Prompt',
                                                color: Colors.black,
                                                fontSize: 16),
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
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: TextField(
                                            controller: incomCon[index],
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
                                                            .supplierIncomProList[
                                                        i]["cPRODCD"] ==
                                                    products[index].cPRODCD) {
                                                  GlobalParam
                                                      .supplierIncomProList
                                                      .removeAt(i);
                                                }
                                              }
                                              var data = {
                                                "cBRANCD": GlobalParam
                                                    .VEHICLE['cBRANCD'],
                                                "cBASKCD":
                                                    products[index].cBASKCD,
                                                "cBRANNM": GlobalParam
                                                    .VEHICLE['cBRANNM'],
                                                "cBASKNM":
                                                    products[index].cBASKNM,
                                                "cBASKPRICE":
                                                    products[index].iPRICE,
                                                "cBKUNIT": "B0001",
                                                "cPRODCD":
                                                    products[index].cPRODCD,
                                                "cPRODNM":
                                                    products[index].cPRODNM,
                                                "cPROUNIT": unitCD,
                                                "iPROPRICE": unitPrice,
                                                "iSEQ": products[index].iSEQ,
                                                "iSSTOCK": '0',
                                                "iMSTOCK": '0',
                                                "iLSTOCK":
                                                    products[index].iPURCHASE,
                                                "cSUOMCD":
                                                    products[index].cSUOMCD,
                                                "cSUOMNM":
                                                    products[index].cSUOMNM,
                                                "cMUOMCD":
                                                    products[index].cMUOMCD,
                                                "cMUOMNM":
                                                    products[index].cMUOMNM,
                                                "cLUOMCD":
                                                    products[index].cLUOMCD,
                                                "cLUOMNM":
                                                    products[index].cLUOMNM,
                                                "iTOTAL":
                                                    products[index].iNETPRICE,
                                                "iINCOMQTY": value,
                                                "iPLUSHQTY": '0',
                                              };

                                              GlobalParam.supplierIncomProList
                                                  .add(data);
                                              if (int.parse(
                                                      plusCon[index].text) !=
                                                  0) {
                                                errDialog(
                                                    'หากสินค้าขาดมากกว่า 0 สินค้าเกินต้องเท่ากับ 0',
                                                    index);
                                              }
                                              setState(() {
                                                incomCon[index].text = value;
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'Prompt',
                                            ),
                                            cursorColor: Colors.black,
                                            decoration: new InputDecoration(
                                              //hintText: "1",
                                              hintStyle: TextStyle(
                                                  color: HexColor('#00cb39')),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
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
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: TextField(
                                            controller: plusCon[index],
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
                                                            .supplierIncomProList[
                                                        i]["cPRODCD"] ==
                                                    products[index].cPRODCD) {
                                                  GlobalParam
                                                      .supplierIncomProList
                                                      .removeAt(i);
                                                }
                                              }
                                              var data = {
                                                "cBRANCD": GlobalParam
                                                    .VEHICLE['cBRANCD'],
                                                "cBASKCD":
                                                    products[index].cBASKCD,
                                                "cBRANNM": GlobalParam
                                                    .VEHICLE['cBRANNM'],
                                                "cBASKNM":
                                                    products[index].cBASKNM,
                                                "cBASKPRICE":
                                                    products[index].iPRICE,
                                                "cBKUNIT": "B0001",
                                                "cPRODCD":
                                                    products[index].cPRODCD,
                                                "cPRODNM":
                                                    products[index].cPRODNM,
                                                "iSEQ": products[index].iSEQ,
                                                "cPROUNIT": unitCD,
                                                "iPROPRICE": unitPrice,
                                                "iSSTOCK": '0',
                                                "iMSTOCK": '0',
                                                "iLSTOCK":
                                                    products[index].iPURCHASE,
                                                "cSUOMCD":
                                                    products[index].cSUOMCD,
                                                "cSUOMNM":
                                                    products[index].cSUOMNM,
                                                "cMUOMCD":
                                                    products[index].cMUOMCD,
                                                "cMUOMNM":
                                                    products[index].cMUOMNM,
                                                "cLUOMCD":
                                                    products[index].cLUOMCD,
                                                "cLUOMNM":
                                                    products[index].cLUOMNM,
                                                "iTOTAL":
                                                    products[index].iNETPRICE,
                                                "iINCOMQTY": '0',
                                                "iPLUSHQTY": value,
                                              };
                                              GlobalParam.supplierIncomProList
                                                  .add(data);
                                              if (double.parse(
                                                      incomCon[index].text) !=
                                                  0) {
                                                errDialog(
                                                    'หากสินค้าเกินมากกว่า 0 สินค้าขาดต้องเท่ากับ 0',
                                                    index);
                                              }
                                              setState(() {
                                                plusCon[index].text = value;
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: HexColor('#00cb39'),
                                              fontFamily: 'Prompt',
                                            ),
                                            cursorColor: Colors.black,
                                            decoration: new InputDecoration(
                                              //hintText: "1",
                                              hintStyle: TextStyle(
                                                  color: HexColor('#00cb39')),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
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
                            style:
                                TextStyle(fontFamily: 'Prompt', fontSize: 14),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          width: widthScreen * 0.2,
                          child: Text(
                            '${formatNum.format(unitPrice)} ฿',
                            style:
                                TextStyle(fontFamily: 'Prompt', fontSize: 14),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          width: widthScreen * 0.1,
                          child: Text(
                            'รวม',
                            style:
                                TextStyle(fontFamily: 'Prompt', fontSize: 14),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          width: widthScreen * 0.25,
                          child: Text(
                            '${formatNum.format(unitPrice * item)} ฿',
                            style:
                                TextStyle(fontFamily: 'Prompt', fontSize: 14),
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
        });
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
