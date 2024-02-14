import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getStoreDetailReq.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_list_main_menu.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_main_menu.dart';
import 'package:vansale/screens/home/home.dart';

class DeliveryStoreHome extends StatefulWidget {
  final String typeMenuCode;
  final String storeName;
  DeliveryStoreHome(this.typeMenuCode, this.storeName);

  @override
  State<DeliveryStoreHome> createState() => _DeliveryStoreHomeState();
}

class _DeliveryStoreHomeState extends State<DeliveryStoreHome> {
  String poDate = DateFormat('dd-MM-yy').format(DateTime.now());
  String poNo = "No. 632606-00xx";
  RouteCusResp deliverySelectStore = GlobalParam.deliverySelectStore;
  PoHDAndPoDTResp deliveryStoreSum = GlobalParam.deliveryStoreSum;
  yearThai() {
    var _podate = poDate.split('-');
    var _day = _podate[0];
    var _month = _podate[1];
    var _year = _podate[2];
    int cal = int.parse(_year) + 43;
    String poDatethai = _day + '/' + _month + '/' + cal.toString();
    return poDatethai;
  }

  String total = '3200.00';
  String totalreturn = '-3200.00';
  var store;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var stores = GlobalParam.deliveryHistoryStores;

    // for (var i = 0; i < stores.length; i++) {
    //   if (widget.storeName == stores[i]['name']) {
    //     store = stores[i];
    //     print(store);
    //   }
    // }

    // getHisBasket();
    // getStoreDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ส่งสินค้า'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => HomePage(GlobalParam.typeMenuCode)),
                  (Route<dynamic> route) => false);
            },
            icon: Icon(Icons.home_outlined)),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              height: 40.0,
              child: Row(
                children: [
                  Expanded(
                    child: _dateHD(),
                  ),
                  Expanded(
                    child: _poNo(),
                  ),
                ],
              ),
            ),
            Container(
              height: 135,
              child: DeliveryStoreListMainMenuHD(
                storeName: widget.storeName,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _summaryDelivery(),
                    _summaryReturn(),
                    //------------------
                    Container(
                      height: 360,
                      child: _gridMenu(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 80.0,
      //   child:  _btnCheckIn(),
      // ),
    );
  }

  Widget _dateHD() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        yearThai(),
        style: TextStyle(
          fontFamily: 'Prompt',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _poNo() {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        deliveryStoreSum.cPOCD,
        style: TextStyle(
          fontFamily: 'Prompt',
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _summaryDelivery() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70.0,
            child: AutoSizeText(
              'รวมส่ง',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 8.0,
              maxFontSize: 14.0,
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: AutoSizeText(
                      '${deliveryStoreSum.iitems} รายการ ,${deliveryStoreSum.ibasket} ตระกร้า',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      minFontSize: 8.0,
                      maxFontSize: 14.0,
                    ),
                  ),
                  Container(
                    child: Text(
                      deliveryStoreSum.cPOCD,
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              child: Utility.formateNumberGN18(
                  double.parse(deliveryStoreSum.iTOTAL), 18)),
        ],
      ),
    );
  }

  Widget _summaryReturn() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70.0,
            child: AutoSizeText(
              'รวมรับคืน',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 8.0,
              maxFontSize: 14.0,
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: AutoSizeText(
                      '${double.parse(GlobalParam.deliveryStoreReturn.ibasket).toStringAsFixed(0)} รายการ ,${double.parse(GlobalParam.deliveryStoreReturn.iitems).toStringAsFixed(0)}  ตระกร้า',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      minFontSize: 8.0,
                      maxFontSize: 14.0,
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Utility.formateNumberOR18(
                      double.parse(GlobalParam.deliveryStoreReturn.iTOTAL), 18),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 5.0),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'บาท',
                    style: TextStyle(
                      fontFamily: 'Prompt',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridMenu() {
    return Container(
      alignment: Alignment.center,
      color: HexColor("#F2F3F4"),
      // height: MediaQuery.of(context).size.height / 3,
      child: DeliveryStoreMainMenu(widget.typeMenuCode),
    );
  }

  Widget _btnCheckIn() {
    return Card(
      elevation: 0.0,
      color: Colors.white,
      child: Container(
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.0,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 35.0,
                      alignment: Alignment.center,
                      child: Icon(
                        LineAwesomeIcons.map_marker,
                        color: Colors.green,
                        size: 25.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'เช็คอิน',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Divider(
              //   color: Colors.green,
              //   thickness: 2.0,
              //   indent: 140.0,
              //   endIndent: 125.0,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  getStoreDetail() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy
          .getStoreDetail(GetStoreDetailReq(cCUSTCD: deliveryStoreSum.cCUSTCD));
      if (result.cCUSTCD != '') {
        GlobalParam.deliveryStoreDetail = result;
        // print(result.iTOTAL);
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getHisBasket() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy
          .getHisBasket(GetStoreDetailReq(cCUSTCD: deliveryStoreSum.cCUSTCD));
      if (result.isNotEmpty) {
        GlobalParam.deliveryHisBasket = result;
        // print(result[0].iTOTAL);
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
