import 'dart:io';

import 'package:blue_print_pos/models/blue_device.dart';
import 'package:blue_print_pos/models/connection_status.dart';
import 'package:blue_print_pos/receipt/receipt.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addBKRReq.dart';
import 'package:vansale/api/class/request/mobile/addBarsketStockCardReq.dart';
import 'package:vansale/api/class/request/mobile/searchBasket.dart';
import 'package:vansale/api/class/response/routeMobile/getBasketResp.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/Pay/pay_main.dart';
import 'package:vansale/screens/Supplier/supplier/confirmPages.dart';
import 'package:vansale/screens/Supplier/models/delayTime.dart';
import 'package:vansale/screens/delivery/delivery_bill/print.dart';
import 'package:vansale/screens/delivery/delivery_scanner.dart';
import 'package:vansale/screens/home/home.dart';
import 'package:vansale/screens/Supplier/shipping/widgets/Footer3Layout.dart';
import 'package:blue_print_pos/blue_print_pos.dart';

class BasketReturn extends StatefulWidget {
  final String? typeMenuCode;
  const BasketReturn({Key? key, this.typeMenuCode}) : super(key: key);

  @override
  State<BasketReturn> createState() => _BasketReturnState();
}

class _BasketReturnState extends State<BasketReturn> {
  DelayTime delay = new DelayTime();
  double widthScreen = 0.0;
  List<bool> oldBasketList = [];
  final formatNum = new NumberFormat("#,###.##", "en_US");
  String poDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String timeNow = DateFormat('HH:mm a').format(DateTime.now());
  String dateNewF = '';
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  var basketData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (GlobalParam.deliveryRegetPODT == true) {
      getBasket(SearchBasketReq(cBASKCD: '%%', cBASKNM: '%%'));
      GlobalParam.deliveryBasketSum = {"item": '0', "total": '0.0'};
    }
    _onSelectDevice();
    var list = poDate.split('-');
    dateNewF = '${list[0]}/${list[1]}/${int.parse(list[2]) + 543}';
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
            'เก็บตะกร้า',
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
                                                      BasketReturn(
                                                          typeMenuCode: GlobalParam
                                                              .typeMenuCode)));
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
                          // BasketReturnCard
                          return Container(
                            color: HexColor("#F2F3F4"),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // GlobalParam.typeMenuCode == "T001"?
                                Container(
                                    padding: const EdgeInsets.all(5.0),
                                    height: 110.0,
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
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  // width: 136,
                                                  child: Text(
                                                    GlobalParam
                                                        .deliveryBasketShow[
                                                            index]
                                                        .cBASKNM!,
                                                    style: TextStyle(
                                                        fontFamily: 'Prompt',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: widthScreen * 0.2,
                                                      child: Center(
                                                        child: Text(
                                                          "ยอดค้าง",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: widthScreen * 0.21,
                                                      child: Center(
                                                        child: Text(
                                                          "เพิ่ม",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: widthScreen * 0.2,
                                                      child: Center(
                                                        child: Text(
                                                          "เก็บ",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Prompt',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: widthScreen * 0.18,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 5.0),
                                                      height: 30.0,
                                                      decoration: BoxDecoration(
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
                                                            color: Colors.grey),
                                                      ),
                                                      child: Center(
                                                          child: basketData
                                                                      .length >
                                                                  0
                                                              ? Text(basketData[
                                                                      index]
                                                                  ['total'])
                                                              : Text('0')),
                                                    ),
                                                    Container(
                                                      width: widthScreen * 0.18,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 5.0),
                                                      height: 30.0,
                                                      decoration: BoxDecoration(
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
                                                            color: Colors.grey),
                                                      ),
                                                      child: Center(
                                                          child: basketData
                                                                      .length >
                                                                  0
                                                              ? Text(basketData[
                                                                      index]
                                                                  ['increase'])
                                                              : Text('0')),
                                                    ),
                                                    Container(
                                                      width: widthScreen * 0.18,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 5.0),
                                                      height: 30.0,
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
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 4, 0, 0),
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                            onChanged: (value) {
                                                              if (value != '' &&
                                                                  value !=
                                                                      null) {
                                                                addBasketReturn(
                                                                    double.parse(
                                                                        value),
                                                                    GlobalParam
                                                                            .deliveryBasketShow[
                                                                        index]);
                                                              } else {
                                                                addBasketReturn(
                                                                    0,
                                                                    GlobalParam
                                                                            .deliveryBasketShow[
                                                                        index]);
                                                              }
                                                            },
                                                            textAlign: TextAlign
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ])),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Container(
                                            alignment: Alignment.centerRight,
                                            width: 150.0,
                                            child: SubstringPrice(
                                              GlobalParam
                                                  .deliveryBasketShow[index]
                                                  .iPRICE,
                                              14.0,
                                              12.0,
                                              Colors.black,
                                              Colors.black,
                                              'Prompt',
                                              'Prompt',
                                              FontWeight.bold,
                                              FontWeight.bold,
                                              '฿',
                                              12.0,
                                              Colors.black,
                                              'Prompt',
                                              FontWeight.bold,
                                              FontStyle.normal,
                                              FontStyle.normal,
                                              FontStyle.normal,
                                            )),
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
                        }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Footer3Layout(
            typeMenuCode: widget.typeMenuCode,
            layout1Title: "จำนวนตะกร้า (เก็บ)",
            layout1Paramitor: "${GlobalParam.deliveryBasketSum['item']} ใบ",
            layout2Title: "คืนค่ามัดจำ",
            layout2Paramitor: "${GlobalParam.deliveryBasketSum['total']}",
            titleButton: "บันทึกเก็บตะกร้า",
            iconButton: LineAwesomeIcons.check_circle,
            navigated: () {
              if (widget.typeMenuCode == "T001") {
                for (int i = 0; i < GlobalParam.deliveryBasketReq.length; i++) {
                  // print(
                  //     '$i = ${oldBasketList[i]} :${GlobalParam.deliveryBasketReq[i].iQTY}');
                  var basketName = '';
                  for (int j = 0;
                      j < GlobalParam.deliveryBasketList.length;
                      j++) {
                    if (GlobalParam.deliveryBasketReq[i].cBASKCD ==
                        GlobalParam.deliveryBasketList[j].cBASKCD) {
                      basketName = GlobalParam.deliveryBasketList[j].cBASKNM!;
                    }
                  }
                  if (oldBasketList[i] == true) {
                    addBKR(GlobalParam.deliveryBasketReq[i]);
                    addBasketStockCard(AddBasketStockCardReq(
                        cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                        cBASKCD: GlobalParam.deliveryBasketReq[i].cBASKCD,
                        cUOMCD: 'B0001',
                        iRECEIVEQTY: '0',
                        cBASKNM: basketName,
                        iISSUEQTY: '${GlobalParam.deliveryBasketReq[i].iQTY}',
                        cCREABY: GlobalParam.deliveryBasketReq[i].cCREABY,
                        cREFDOC: GlobalParam.deliveryBasketReq[i].cREFDOC,
                        cWH: 'TP',
                        cREMARK: ''));
                  }
                }
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (comtext) => SupPay()));
                if (GlobalParam.bluetoothConnect == true) {
                  _onPrintBill();
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BluPrintPOS(
                        code: '002',
                      ),
                    ),
                  );
                }
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (comtext) =>
                        ConfirmPages(widget.typeMenuCode!, "คืนตะกร้า")));
                Future.delayed(Duration(seconds: delay.getTimeDelay()), () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => HomePage(widget.typeMenuCode!)),
                      (Route<dynamic> route) => false);
                });
              }
            }));
  }

  getBasket(SearchBasketReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getBasket(req);
      GlobalParam.deliveryBasketList = result;

      // GlobalParam.deliveryBasketShow = result;
      var list = [];
      GlobalParam.deliveryBasketShow = [];

      for (int j = 0; j < GlobalParam.deliveryBasketList.length; j++) {
        var increase = 0;
        var data = {
          'basketCD': GlobalParam.deliveryBasketList[j].cBASKCD,
          'baskeNM': GlobalParam.deliveryBasketList[j].cBASKNM,
          'total': '0',
          'increase': '0'
        };
        for (int i = 0; i < GlobalParam.deliveryProductList.length; i++) {
          if (GlobalParam.deliveryProductList[i].cBASKCD ==
              GlobalParam.deliveryBasketList[j].cBASKCD) {
            increase += int.parse(GlobalParam.deliveryProductList[i].ibasket!);
          }
        }

        for (int i = 0; i < GlobalParam.deliveryHisBasket.length; i++) {
          if (GlobalParam.deliveryBasketList[j].cBASKCD ==
              GlobalParam.deliveryHisBasket[i].cBASKCD) {
            GlobalParam.deliveryBasketShow
                .add(GlobalParam.deliveryBasketList[j]);
            data['total'] =
                '${GlobalParam.deliveryHisBasket[i].iTOTAL! - GlobalParam.deliveryHisBasket[i].iRETURN!}';
            data['increase'] = '${increase}';
            print(data);
            list.add(data);
          }
        }
      }

      for (int i = 0; i < GlobalParam.deliveryHisBasket.length; i++) {
        String cGRPCD = "";
        final moonLanding = new DateTime.now();
        // print(moonLanding.weekday); // 7
        if (moonLanding.weekday == 1) {
          cGRPCD = "GRSUN";
        } else if (moonLanding.weekday == 2) {
          cGRPCD = "GRMON";
        } else if (moonLanding.weekday == 3) {
          cGRPCD = "GRTUE";
        } else if (moonLanding.weekday == 4) {
          cGRPCD = "GRWED";
        } else if (moonLanding.weekday == 5) {
          cGRPCD = "GRTHU";
        } else if (moonLanding.weekday == 6) {
          cGRPCD = "GRFRI";
        } else if (moonLanding.weekday == 7) {
          cGRPCD = "GRSAT";
        }

        AddBKRReq addReturn = AddBKRReq(
          cREFDOC: GlobalParam.deliveryPodtList[0].cPOCD,
          cSENDER: GlobalParam.deliverySelectStore.cCUSTCD,
          cRECEIVER: GlobalParam.VEHICLE['cVEHICD'],
          cBASKCD: GlobalParam.deliveryHisBasket[i].cBASKCD,
          iQTY: 0.0,
          iTOTAL: 0.0,
          cTYPE: "CTT",
          cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
          cVEHICD: GlobalParam.VEHICLE['cVEHICD'],
          cGRPCD: GlobalParam.deliveryRouteToday['cGRPCD'],
          cRTECD: GlobalParam.deliveryRouteToday['cRTECD'],
          cCREABY: GlobalParam.userData.cUSRNM,
        );
        GlobalParam.deliveryBasketReq.add(addReturn);

        oldBasketList.add(false);
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

  addBKR(AddBKRReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.addBKR(req);
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

  void _onSelectDevice() async {
    // box.put('test', 'test');
    bool checkRepeat = false;

    final BlueDevice blueDevice = GlobalParam.selectDevice!;
    _bluePrintPos.connect(blueDevice).then((ConnectionStatus status) {});
  }

  addBasketReturn(double value, GetBasketResp data) {
    int item = 0;
    double total = 0.0;
    for (int i = 0; i < GlobalParam.deliveryBasketReq.length; i++) {
      if (GlobalParam.deliveryBasketReq[i].cBASKCD == data.cBASKCD) {
        if (value == 0) {
          GlobalParam.deliveryBasketReq[i].iQTY = 0;
          GlobalParam.deliveryBasketReq[i].iTOTAL = 0;
        } else {
          oldBasketList[i] = true;
          GlobalParam.deliveryBasketReq[i].iQTY = value;
          GlobalParam.deliveryBasketReq[i].iTOTAL =
              int.parse(value.toStringAsFixed(0)) *
                  double.parse(GlobalParam.deliveryBasketList[i].iPRICE!);
        }
      }
      item += int.parse(
          '${GlobalParam.deliveryBasketReq[i].iQTY!.toStringAsFixed(0)}');
      total += GlobalParam.deliveryBasketReq[i].iTOTAL!;
    }
    setState(() {
      GlobalParam.deliveryBasketSum['item'] = '$item';
      GlobalParam.deliveryBasketSum['total'] = '$total';
    });
  }

  Future<void> _onPrintBill() async {
    final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();
    // final ReceiptSectionText receipt01 = ReceiptSectionText();

    // header
    receipt01.addText(
      'นายกัณฐ์ เทรดดิ้ง',
      size: ReceiptTextSizeType.large,
      style: ReceiptTextStyleType.bold,
    );
    receipt01.addText(
      'ใบส่งสินค้า',
      size: ReceiptTextSizeType.medium,
      style: ReceiptTextStyleType.bold,
    );
    receipt01.addSpacer(useDashed: true);

    // locationStore
    receipt01.addLeftRightText(
      GlobalParam.deliverySelectStore.cCUSTNM!,
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      GlobalParam.deliverySelectStore.cADDRESS!,
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      GlobalParam.deliverySelectStore.cSUBDIST!,
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      GlobalParam.deliverySelectStore.cDISTRICT!,
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      '${GlobalParam.deliverySelectStore.cPROVINCE} ${GlobalParam.deliverySelectStore.cPOSTCD}',
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addSpacer(useDashed: true);

    receipt01.addLeftRightText(
      'วันที่ ${dateNewF}',
      'เวลา $timeNow',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      'เลขที่ ${GlobalParam.deliveryPodtList[0].cPOCD}',
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addSpacer(useDashed: true);
    // productHeader
    receipt01.addLeftRightText(
      'รายละเอียด',
      'ยอดเงิน',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
      rightSize: ReceiptTextSizeType.medium,
      rightStyle: ReceiptTextStyleType.bold,
    );

    // productList() {
    for (int index = 0; index < GlobalParam.deliveryPodtList.length; index++) {
      String unitNM = '';
      double qty = 0, prince = 0;
      // ignore: unrelated_type_equality_checks
      if (GlobalParam.deliveryPodtList[index].iSSIZEQTY != 0) {
        qty = double.parse(GlobalParam.deliveryPodtList[index].iSSIZEQTY!);
        prince = double.parse(GlobalParam.deliveryPodtList[index].iSUNITPRICE!);
        unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM!;
        // ignore: unrelated_type_equality_checks
      }
      if (GlobalParam.deliveryPodtList[index].iMSIZEQTY != 0) {
        qty = double.parse(GlobalParam.deliveryPodtList[index].iMSIZEQTY!);
        prince = double.parse(GlobalParam.deliveryPodtList[index].iMUNITPRICE!);
        unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM!;
        // ignore: unrelated_type_equality_checks
      }
      if (GlobalParam.deliveryPodtList[index].iLSIZEQTY != 0) {
        qty = double.parse(GlobalParam.deliveryPodtList[index].iLSIZEQTY!);
        prince = double.parse(GlobalParam.deliveryPodtList[index].iLUNITPRICE!);
        unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM!;
      }

      receipt01.addLeftRightText(
        GlobalParam.deliveryPodtList[index].cPRODNM!,
        '',
        leftSize: ReceiptTextSizeType.medium,
        leftStyle: ReceiptTextStyleType.bold,
        // rightSize: ReceiptTextSizeType.medium,
        // rightStyle: ReceiptTextStyleType.bold,
      );
      receipt01.addLeftRightText(
        '$unitNM@${qty.toStringAsFixed(0)}',
        '${prince.toStringAsFixed(2)}',
        leftSize: ReceiptTextSizeType.medium,
        // leftStyle: ReceiptTextStyleType.bold,
        rightSize: ReceiptTextSizeType.medium,
        // rightStyle: ReceiptTextStyleType.bold,
      );
    }
    receipt01.addSpacer(useDashed: true);

    // incompHeader
    receipt01.addLeftRightText(
      'สินค้าขาด',
      'ยอดเงิน',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
      rightSize: ReceiptTextSizeType.medium,
      rightStyle: ReceiptTextStyleType.bold,
    );

    // incompList
    for (int index = 0; index < GlobalParam.deliveryPodtList.length; index++) {
      if (GlobalParam.deliveryPodtList[index].iSUNITPRICE == null) {
        GlobalParam.deliveryPodtList[index].iSUNITPRICE = '0.0';
      }
      if (GlobalParam.deliveryPodtList[index].iINCOMPRO == null) {
        GlobalParam.deliveryPodtList[index].iINCOMPRO = 0;
      }
      String unitNM = '';
      int qty = GlobalParam.deliveryPodtList[index].iINCOMPRO!;
      double prince = 0;
      // ignore: unrelated_type_equality_checks
      if (GlobalParam.deliveryPodtList[index].iSSIZEQTY != '0' &&
          GlobalParam.deliveryPodtList[index].iSSIZEQTY != null) {
        prince =
            qty * double.parse(GlobalParam.deliveryPodtList[index].iSUNITPRICE!);
        unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM!;
        // ignore: unrelated_type_equality_checks
      } else if (GlobalParam.deliveryPodtList[index].iMSIZEQTY != '0' &&
          GlobalParam.deliveryPodtList[index].iMSIZEQTY != null) {
        prince =
            qty * double.parse(GlobalParam.deliveryPodtList[index].iMUNITPRICE!);
        unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM!;
        // ignore: unrelated_type_equality_checks
      } else if (GlobalParam.deliveryPodtList[index].iLSIZEQTY != '0' &&
          GlobalParam.deliveryPodtList[index].iLSIZEQTY != null) {
        prince =
            qty * double.parse(GlobalParam.deliveryPodtList[index].iLUNITPRICE!);
        unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM!;
      }
      if (GlobalParam.deliveryPodtList[index].iINCOMPRO != 0 &&
          GlobalParam.deliveryPodtList[index].iINCOMPRO != null) {
        receipt01.addLeftRightText(
          GlobalParam.deliveryPodtList[index].cPRODNM!,
          '',
          leftSize: ReceiptTextSizeType.medium,
          leftStyle: ReceiptTextStyleType.bold,
          // rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
        receipt01.addLeftRightText(
          '$unitNM@${qty.toStringAsFixed(0)}',
          '${prince.toStringAsFixed(2)}',
          leftSize: ReceiptTextSizeType.medium,
          // leftStyle: ReceiptTextStyleType.bold,
          rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
      }
    }

    receipt01.addSpacer(useDashed: true);
    // cancelHeader
    receipt01.addLeftRightText(
      'ไม่รับ/คืน',
      'ยอดเงิน',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
      rightSize: ReceiptTextSizeType.medium,
      rightStyle: ReceiptTextStyleType.bold,
    );

    // cancelList
    for (int index = 0; index < GlobalParam.deliveryPodtList.length; index++) {
      if (GlobalParam.deliveryPodtList[index].iCANCLEPRO == null) {
        GlobalParam.deliveryPodtList[index].iCANCLEPRO = 0;
      }
      String unitNM = '';
      int qty = GlobalParam.deliveryPodtList[index].iCANCLEPRO!;
      double prince = 0;
      // ignore: unrelated_type_equality_checks
      if (GlobalParam.deliveryPodtList[index].iSSIZEQTY != 0) {
        prince =
            qty * double.parse(GlobalParam.deliveryPodtList[index].iSUNITPRICE!);
        unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM!;
        // ignore: unrelated_type_equality_checks
      } else if (GlobalParam.deliveryPodtList[index].iMSIZEQTY != 0) {
        prince =
            qty * double.parse(GlobalParam.deliveryPodtList[index].iMUNITPRICE!);
        unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM!;
        // ignore: unrelated_type_equality_checks
      } else if (GlobalParam.deliveryPodtList[index].iLSIZEQTY != 0) {
        prince =
            qty * double.parse(GlobalParam.deliveryPodtList[index].iLUNITPRICE!);
        unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM!;
      }
      if (GlobalParam.deliveryPodtList[index].iCANCLEPRO != 0) {
        receipt01.addLeftRightText(
          GlobalParam.deliveryPodtList[index].cPRODNM!,
          '',
          leftSize: ReceiptTextSizeType.medium,
          leftStyle: ReceiptTextStyleType.bold,
          // rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
        receipt01.addLeftRightText(
          '$unitNM@${qty.toStringAsFixed(0)} ',
          '${prince.toStringAsFixed(2)}',
          leftSize: ReceiptTextSizeType.medium,
          // leftStyle: ReceiptTextStyleType.bold,
          rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
      }
    }

    receipt01.addSpacer(useDashed: true);

    // lossHeader
    receipt01.addLeftRightText(
      'สินค้าขาด',
      'ยอดเงิน',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
      rightSize: ReceiptTextSizeType.medium,
      rightStyle: ReceiptTextStyleType.bold,
    );

    // lossList
    for (int index = 0; index < GlobalParam.deliveryPodtList.length; index++) {
      if (GlobalParam.deliveryPodtList[index].iLOSSPRO == null) {
        GlobalParam.deliveryPodtList[index].iLOSSPRO = 0;
      }
      String unitNM = '';
      int qty = GlobalParam.deliveryPodtList[index].iLOSSPRO!;
      double prince = 0;
      // ignore: unrelated_type_equality_checks
      if (GlobalParam.deliveryPodtList[index].iSSIZEQTY != 0) {
        print(GlobalParam.deliveryPodtList[index].iSUNITPRICE);
        prince =
            qty * double.parse(GlobalParam.deliveryPodtList[index].iSUNITPRICE!);
        unitNM = GlobalParam.deliveryPodtList[index].cSUOMNM!;
        // ignore: unrelated_type_equality_checks
      } else if (GlobalParam.deliveryPodtList[index].iMSIZEQTY != 0) {
        prince =
            qty * double.parse(GlobalParam.deliveryPodtList[index].iMUNITPRICE!);
        unitNM = GlobalParam.deliveryPodtList[index].cMUOMNM!;
        // ignore: unrelated_type_equality_checks
      } else if (GlobalParam.deliveryPodtList[index].iLSIZEQTY != 0) {
        prince =
            qty * double.parse(GlobalParam.deliveryPodtList[index].iLUNITPRICE!);
        unitNM = GlobalParam.deliveryPodtList[index].cLUOMNM!;
      }
      if (GlobalParam.deliveryPodtList[index].iLOSSPRO != 0) {
        receipt01.addText(
          GlobalParam.deliveryPodtList[index].cPRODNM!,
          size: ReceiptTextSizeType.medium,
        );
        receipt01.addLeftRightText(
          '$unitNM',
          '${qty.toStringAsFixed(0)}             ${prince.toStringAsFixed(2)}',
          leftSize: ReceiptTextSizeType.medium,
          // leftStyle: ReceiptTextStyleType.bold,
          rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
      }
    }

    receipt01.addSpacer(useDashed: true);

    // basketHeader
    receipt01.addLeftRightText(
      'คืนตะกร้า',
      'ยอดเงิน',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
      rightSize: ReceiptTextSizeType.medium,
      rightStyle: ReceiptTextStyleType.bold,
    );

    // basketList
    for (int index = 0; index < GlobalParam.deliveryBasketReq.length; index++) {
      String basName = '';
      double basTotal = 0;
      for (int i = 0; i < GlobalParam.deliveryBasketList.length; i++) {
        if (GlobalParam.deliveryBasketList[i].cBASKCD ==
            GlobalParam.deliveryBasketReq[index].cBASKCD) {
          basName = GlobalParam.deliveryBasketList[i].cBASKNM!;
          basTotal = GlobalParam.deliveryBasketReq[index].iQTY! *
              double.parse(GlobalParam.deliveryBasketList[i].iPRICE!);
        }
      }
      if (GlobalParam.deliveryBasketReq[index].iQTY != 0) {
        receipt01.addLeftRightText(
          '$basName@${GlobalParam.deliveryBasketReq[index].iQTY}',
          '${basTotal.toStringAsFixed(2)}',
          leftSize: ReceiptTextSizeType.medium,
          // leftStyle: ReceiptTextStyleType.bold,
          rightSize: ReceiptTextSizeType.medium,
          // rightStyle: ReceiptTextStyleType.bold,
        );
      }
    }
    receipt01.addSpacer(useDashed: true);
    // footer
    List unitName = [];
    double totalItem = 0;
    var listItem = [];
    for (int i = 0; i < GlobalParam.deliveryUnitList.length; i++) {
      unitName.add(GlobalParam.deliveryUnitList[i]['cUOMNM']);
    }

    var unitList = unitName.toSet().toList();

    for (int i = 0; i < unitList.length; i++) {
      int num = 0;
      double numItem = 0;

      for (int j = 0; j < GlobalParam.deliveryUnitList.length; j++) {
        if (unitList[i] == GlobalParam.deliveryUnitList[j]['cUOMNM']) {
          double total =
              double.parse(GlobalParam.deliveryUnitList[j]['iTOTAL']);
          double prince =
              double.parse(GlobalParam.deliveryUnitList[j]['iPRICE']);
          num++;
          numItem += total / prince;
        }
      }
      totalItem += numItem;
      var text = {
        "unitName": unitList[i],
        "qty": num,
        "sumItem": numItem.toStringAsFixed(0)
      };
      listItem.add(text);
    }

    receipt01.addLeftRightText(
      'รวมทั้งหมด',
      '${formatNum.format(double.parse(GlobalParam.deliveryStoreSum.iTOTAL!))}',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );

    receipt01.addLeftRightText(
      'รวม ${GlobalParam.deliveryStoreSum.iitems} รายการ',
      'จำนวน  ${totalItem.toStringAsFixed(0)} ชิ้น',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );

    receipt01.addLeftRightText(
      'ได้ตรวจรับสิ่งของและชำระเงินถูกต้องเรียบร้อยแล้ว',
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      'ผู้ส่งของ/รับเงิน',
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addText('',
        size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.bold);
    receipt01.addText('ลงชื่อ______________________',
        size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.bold);

    await _bluePrintPos.printReceiptText(receipt01, feedCount: 1).then(
        (value) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (comtext) => SupPay())));
  }

  Future<void> _onPrintReceipt() async {
    final ReceiptSectionText receipt01 = ReceiptSectionText();
    receipt01.addText(
      'พิมพ์ทดสอบ',
      size: ReceiptTextSizeType.large,
      style: ReceiptTextStyleType.bold,
    );

    receipt01.addLeftRightText(
      '${GlobalParam.selectDevice!.name}',
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      '${GlobalParam.selectDevice!.address}',
      '',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );
    receipt01.addLeftRightText(
      'วันที่ ${dateNewF}',
      'เวลา $timeNow',
      leftSize: ReceiptTextSizeType.medium,
      leftStyle: ReceiptTextStyleType.bold,
    );

    await _bluePrintPos.printReceiptText(receipt01, feedCount: 1);
  }
}
