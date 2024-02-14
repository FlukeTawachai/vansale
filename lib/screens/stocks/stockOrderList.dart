import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getSPOrderDTReq.dart';
import 'package:vansale/api/class/request/mobile/getSupplierOrderReq.dart';
import 'package:vansale/api/class/response/routeMobile/getSupplierOrderResp.dart';
import 'package:vansale/screens/home/home.dart';
import 'package:vansale/screens/stocks/stockPOList.dart';
import 'package:vansale/screens/stocks/stockPOSuccList.dart';

class StockOrderList extends StatefulWidget {
  //const DeliveryList({ Key? key }) : super(key: key);

  StockOrderList();
  @override
  _StockOrderListState createState() => _StockOrderListState();
}

class _StockOrderListState extends State<StockOrderList> {
  String mount = DateFormat('MM').format(DateTime.now());
  String year = DateFormat('yyyy').format(DateTime.now());
  List<GetSupplierOrderResp> orderSucList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GlobalParam.supplierOrProductList = [];
    GlobalParam.supplierOrProductShowList = [];
    getSupplierOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            'ออเดอร์ (${orderSucList.length}/${GlobalParam.supplierOrderList.length})'),
        leading: IconButton(
          onPressed: () {
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    HomePage(GlobalParam.typeMenuCode),
              ),
            );
          },
          icon: Icon(LineAwesomeIcons.home),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), // here the desired height
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: Colors.green,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black38,
                labelStyle: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Prompt',
                    fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    text: 'รับแล้ว',
                  ),
                  Tab(
                    text: 'รอรับ',
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              // Card(
              //   elevation: 0.0,
              //   color: HexColor("#F2F3F4"),
              //   child: DeliveryListYesterday(widget.typeMenuCode),
              // ),
              Card(
                elevation: 0.0,
                color: HexColor("#F2F3F4"),
                child: StockPOSuccList(),
              ),
              Card(
                elevation: 0.0,
                color: HexColor("#F2F3F4"),
                child: StockPOList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getSupplierOrder() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getSupplierOrder(GetSupplierOrderReq(
          cBRANCD: GlobalParam.VEHICLE['cBRANCD'], dPODATE: '$year-$mount-01'));

      if (result.isNotEmpty) {
        orderSucList = [];
        GlobalParam.supplierOrProductList = [];
        GlobalParam.supplierOrderList = result;
        for (int i = 0; i < result.length; i++) {
          if (result[i].cPOSTATUS == '3' ||
              result[i].cPOSTATUS == '4' ||
              result[i].cPOSTATUS == '5') {
            orderSucList.add(result[i]);
          }

          getSPOrderDT(result[i].cPOCD);
        }
      } else {
        wrongDialog('ไม่พบออเดอร์');
      }
      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getSPOrderDT(String cPOCD) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getSPOrderDT(
          GetSPOrderDTReq(cPOCD: cPOCD, cPRODNM: '%%', cPRODCD: '%%'));

      // GlobalParam.supplierOrProductList = [];
      // GlobalParam.supplierOrProductShowList = [];
      if (result.isNotEmpty) {
        orderSucList = [];
        for (int i = 0; i < result.length; i++) {
          if (double.parse(result[i].iPURCHASE) > 0) {
            GlobalParam.supplierOrProductList.add(result[i]);
            GlobalParam.supplierOrProductShowList.add(result[i]);
          }
        }
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
