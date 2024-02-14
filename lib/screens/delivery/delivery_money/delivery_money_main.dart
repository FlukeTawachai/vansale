import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/routeCusReq.dart';
import 'package:vansale/api/class/request/mobile/searchRefuelReq.dart';
import 'package:vansale/api/class/response/routeMobile/addSendMoneyReq.dart';
import 'package:vansale/api/class/response/routeMobile/getRefuelHisOfDayResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSumMoneyResp.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/ic_vp_icons.dart';
import 'package:vansale/screens/delivery/delivery_money/delivery_money_detail.dart';
import 'package:vansale/screens/delivery/delivery_money/delivery_money_main_list.dart';
import 'package:vansale/screens/delivery/delivery_money/delivery_money_new.dart';
import 'package:vansale/screens/home/home.dart';

class DeliveryMoneyMain extends StatefulWidget {
  final String typeMenuCode;
  final bool reset;
  const DeliveryMoneyMain(this.typeMenuCode, this.reset, {super.key});

  @override
  State<DeliveryMoneyMain> createState() => _DeliveryMoneyMainState();
}

class _DeliveryMoneyMainState extends State<DeliveryMoneyMain> {
  String poDate = DateFormat('dd-MM-yy').format(DateTime.now());
  String newDate = DateFormat('dd-MM-yy HH:mm').format(DateTime.now());
  GetSumMoneyResp sumTotal = GetSumMoneyResp(iTOTAL: '0.0');
  double money = 0;
  double refuelTotal = 0;
  double iCASH = 0;
  double iTRANSFER = 0;
  double iCHECK = 0;
  double iTOTALWAGE = 0;
  List<GetRefuelHisOfDayResp> refuelList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSumMoney();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ส่งเงิน'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DeliveryMoneyNew(widget.typeMenuCode),
                  ),
                );
              },
              icon: const Icon(Icvp.ellipsis_v_solid))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
        ),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  _dateHD(),
                  _no(),
                ],
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const DottedLine(
              dashColor: Colors.grey,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: const Text('ยอดขายทั้งหมด'),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: _totalPrice(),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 15.0,
            // ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: const Text('เงินสด'),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        const Spacer(),
                        Utility.formateNumberOR18(iCASH, 18.00),
                        Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            " ฿",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: const Text('เงินโอน'),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        const Spacer(),
                        Utility.formateNumberOR18(iTRANSFER, 18.00),
                        Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            " ฿",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: const Text('เช็ค'),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        const Spacer(),
                        Utility.formateNumberOR18(iCHECK, 18.00),
                        Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            " ฿",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: const Text('ค่าแรง'),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        const Spacer(),
                        Utility.formateNumberOR18(iTOTALWAGE, 18.00),
                        Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            " ฿",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: const Text('ค่าน้ำมัน'),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: _totalPriceRefuel(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            const DottedLine(
              dashColor: Colors.grey,
            ),
            Expanded(
              child: Container(
                color: HexColor("#F2F3F4"),
                child: DeliveryMoneyMainList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _btnSave(),
    );
  }

  yearThai() {
    var _podate = poDate.split('-');
    var _day = _podate[0];
    var _month = _podate[1];
    var _year = _podate[2];
    int cal = int.parse(_year) + 43;
    String poDatethai = _day + '/' + _month + '/' + cal.toString();
    return poDatethai;
  }

  Widget _dateHD() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        yearThai(),
        style: const TextStyle(
          fontFamily: 'Prompt',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _no() {
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          'No.$newDate',
          style: const TextStyle(
            fontFamily: 'Prompt',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _totalPriceRefuel() {
    return Row(
      children: [
        const Spacer(),
        Utility.formateNumberOR18(refuelTotal, 18.00),
        Container(
          alignment: Alignment.centerRight,
          child: const Text(
            " ฿",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _totalPrice() {
    return Row(
      children: [
        const Spacer(),
        Utility.formateNumberGN18(
            GlobalParam.deliveryAddSendMoney.iTOTAL ?? 0, 18.00),
        Container(
          alignment: Alignment.centerRight,
          child: const Text(
            " ฿",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _btnSave() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: 140.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: const Text(
                            'รวมเงินที่ต้องส่ง(เงินสด)',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              const Spacer(),
                              Utility.formateNumberGN18(
                                  iCASH - refuelTotal - iTOTALWAGE, 18.00),
                              Container(
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  " ฿",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DeliveryMoneyDetail(() {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(GlobalParam.typeMenuCode ?? '')),
                            (route) => false);
                      }),
                    ),
                  );
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icvp.dollar_sign_solid,
                          size: 25.0,
                          color: HexColor('#00cb39'),
                        ),
                        /*child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(30 / 360),
                          
                        ),*/
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        //alignment: Alignment.centerLeft,
                        child: Text(
                          'ยืนยันการส่งเงิน',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: HexColor('#00cb39'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   child: Divider(
              //     height: 5.0,
              //     indent: 105.0,
              //     endIndent: 100.0,
              //     thickness: 2.0,
              //     color: HexColor('#00cb39'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  getSumMoney() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var outputFormat = DateFormat('yyyy-MM-dd');
      var outputDate = outputFormat.format(new DateTime.now());
      // print(outputDate);

      var result = await proxy.getSumMoney(RouteCusReq(
          cRTECD: GlobalParam.deliveryRouteToday['cRTECD'],
          dSHIPDATE: outputDate,
          cGRPCD: GlobalParam.deliveryRouteToday['cGRPCD'],
          cBRANCD: GlobalParam.deliveryRouteToday['cBRANCD']));
      if (result.cBRANCD != '') {
        setState(() {
          GlobalParam.sumSendMony = result;
          GlobalParam.deliveryAddSendMoney.cRTECD =
              GlobalParam.deliveryRouteToday['cRTECD'];
          GlobalParam.deliveryAddSendMoney.cGRPCD =
              GlobalParam.deliveryRouteToday['cGRPCD'];
          GlobalParam.deliveryAddSendMoney.cBRANCD =
              GlobalParam.deliveryRouteToday['cBRANCD'];
          GlobalParam.deliveryAddSendMoney.cVEHICD =
              GlobalParam.VEHICLE['cVEHICD'];
          GlobalParam.deliveryAddSendMoney.cDRIVER = GlobalParam.userID;

          GlobalParam.deliveryAddSendMoney.cCREABY = GlobalParam.userID;
          sumTotal = result;
          money = (GlobalParam.deliveryAddSendMoney.iTOTAL ?? 0) -
              (GlobalParam.deliveryAddSendMoney.iCOST ?? 0);
          iCASH = double.parse(result.iCASH ?? '0');
          iTRANSFER = double.parse(result.iTRANSFER ?? '0');
          iCHECK = double.parse(result.iCHECK ?? '0');
          iTOTALWAGE = double.parse(result.iWAGE ?? '0') +
              double.parse(result.iTOTALWAGE ?? '0');
          GlobalParam.deliveryAddSendMoney.iTOTAL =
              iCASH - refuelTotal - iTOTALWAGE;
        });
        getRefuelHisOfDay(SearchRefuelReq(
            cBRANCD: GlobalParam.deliveryRouteToday['cBRANCD'],
            cVEHICD: GlobalParam.VEHICLE['cVEHICD'],
            dINVENTDT: outputDate));
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getRefuelHisOfDay(SearchRefuelReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getRefuelHisOfDay(req);
      if (result.isNotEmpty) {
        setState(() {
          refuelList.addAll(result);
          for (var item in result) {
            refuelTotal += double.parse(item.iTOTAL ?? '0');
          }
        });
        GlobalParam.deliveryAddSendMoney.iREFUEL = refuelTotal;
      }
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
}
