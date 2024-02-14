import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getStoreDetailReq.dart';
import 'package:vansale/api/class/response/routeMobile/BasketReturnResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSaleStoreOrderResp.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/home/home.dart';
import 'package:vansale/screens/sale/survey/sale_StoreHeader.dart';
import 'package:vansale/screens/sale/survey/sale_setailMenu.dart';

class SaleStoreHome extends StatefulWidget {
  final String typeMenuCode;
  final String storeName;
  final GetSaleStoreOrderResp store;
  SaleStoreHome(this.typeMenuCode, this.storeName, this.store);

  @override
  State<SaleStoreHome> createState() => _SaleStoreHomeState();
}

class _SaleStoreHomeState extends State<SaleStoreHome> {
  String poDate = DateFormat('dd-MM-yy').format(DateTime.now());
  String poNo = "No. 632606-00xx";
  final formatNum = NumberFormat("#,###.##", "en_US");
  RouteCusResp deliverySelectStore = GlobalParam.deliverySelectStore;
  yearThai() {
    var _podate = poDate.split('-');
    var _day = _podate[0];
    var _month = _podate[1];
    var _year = _podate[2];
    int cal = int.parse(_year) + 43;
    String poDatethai = _day + '/' + _month + '/' + cal.toString();
    return poDatethai;
  }

  PoHDAndPoDTResp deliveryStoreSum = PoHDAndPoDTResp(
    cCUSTCD: "",
    cTYPE: "",
    cPOCD: "",
    cPRODCD: "",
    cPRODNM: "",
    cBASKCD: "",
    cBASKNM: "",
    iitems: "0.0",
    ibasket: "0.0",
    iTOTAL: "0.0",
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.store.cPOCD.isNotEmpty) {
      if (widget.store.cPOCD[0] != '') {
        loadData();
      }
    }
    // var stores = GlobalParam.deliveryHistoryStores;

    // for (var i = 0; i < stores.length; i++) {
    //   if (widget.storeName == stores[i]['name']) {
    //     store = stores[i];
    //     print(store);
    //   }
    // }
  }

  loadData() async {
    GlobalParam.basketReturn = {
      "basketReturnCount": 0,
      "basketReturnTotaliQTY": 0,
      "basketReturnPrice": 0.0,
      "xbasketReturnTotaliQTY": 0
    };
    await getHisBasket();
    await getStoreDetail();
    await getPoHDAndPoDT();
    await getBasketReturn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ขายสินค้า'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => HomePage(GlobalParam.typeMenuCode),
                ),
                (Route<dynamic> route) => false);
          },
          icon: Icon(Icons.home_outlined),
        ),
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
              child: SaleStoreListMainMenuHD(
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
                    // ------------------
                    Expanded(
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
        "",
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
      padding: const EdgeInsets.all(5.0),
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
                      '${formatNum.format(double.parse(deliveryStoreSum.iitems))} รายการ ,${formatNum.format(double.parse(deliveryStoreSum.ibasket))} ตระกร้า',
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
              double.parse(deliveryStoreSum.iTOTAL),
              18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryReturn() {
    return Container(
      padding: const EdgeInsets.all(5.0),
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
                      '${GlobalParam.basketReturn['basketReturnCount']} รายการ ,${GlobalParam.basketReturn['basketReturnTotaliQTY']} ตระกร้า',
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
                      GlobalParam.basketReturn['basketReturnPrice'], 18),
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
      height: MediaQuery.of(context).size.height / 2.8,
      child: SaleStoreMainMenu(widget.typeMenuCode, widget.store),
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

  getPoHDAndPoDT() async {
    try {
      GlobalParam.PoHDAndPoDT = [];
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getBaskets(
          widget.store.cCUSTCD, widget.store.cPOCD[0], "%%", "%%");
      double iitems = 0;
      double ibasket = 0;
      double iTOTAL = 0;
      if (result.isNotEmpty) {
        for (var i = 0; i < result.length; i++) {
          iitems += double.parse(result[i].iitems);
          ibasket += double.parse(result[i].ibasket);
          iTOTAL += double.parse(result[i].iTOTAL);
        }
        GlobalParam.PoHDAndPoDT = result;
        deliveryStoreSum = PoHDAndPoDTResp(
          cCUSTCD: result[0].cCUSTCD,
          cTYPE: result[0].cTYPE,
          cPOCD: result[0].cPOCD,
          cPRODCD: "",
          cPRODNM: "",
          cBASKCD: "",
          cBASKNM: "",
          iitems: "$iitems",
          ibasket: "$ibasket",
          iTOTAL: "$iTOTAL",
        );
        GlobalParam.deliveryStoreSum = deliveryStoreSum;

        // print(result.iTOTAL);
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }

  getBasketReturn() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      List<BasketReturnResp> result = await proxy.getBasketReturn({
        "cREF_DOC": GlobalParam.PoHDAndPoDT[0]?.cPOCD ?? '',
        "cBASKCD": GlobalParam.PoHDAndPoDT[0]?.cBASKCD ?? '',
        "cTYPE": "CTS",
        "cSENDER": GlobalParam.PoHDAndPoDT[0]?.cCUSTCD ?? '',
      });

      if (result.isNotEmpty) {
        // end set pay //
        GlobalParam.basketReturn['basketReturnCount'] = result.length;
        for (var i = 0; i < result.length; i++) {
          GlobalParam.basketReturn['basketReturnTotaliQTY'] += result[i].iQTY;
          GlobalParam.basketReturn['basketReturnPrice'] +=
              double.tryParse(result[i].iTOTAL) ?? 0.0;
        }
      }
      GlobalParam.basketReturn['xbasketReturnTotaliQTY'] =
          (double.parse(deliveryStoreSum.ibasket).toInt() -
              GlobalParam.basketReturn['basketReturnTotaliQTY'].toInt());
      print(
          '${double.parse(deliveryStoreSum.ibasket).toInt()} - ${GlobalParam.basketReturn['basketReturnTotaliQTY'].toInt()} = ${GlobalParam.basketReturn['xbasketReturnTotaliQTY']}');
      // print('$basketReturnCount $basketReturnTotaliQTY $basketReturnPrice');
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }

  getStoreDetail() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy
          .getStoreDetail(GetStoreDetailReq(cCUSTCD: widget.store.cCUSTCD));
      if (result.cCUSTCD != '') {
        GlobalParam.deliveryStoreDetail = result;
        // print(result.iTOTAL);
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }

  getHisBasket() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy
          .getHisBasket(GetStoreDetailReq(cCUSTCD: widget.store.cCUSTCD));
      if (result.isNotEmpty) {
        GlobalParam.deliveryHisBasket = result;
        // print(result[0].iTOTAL);
      }
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
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
