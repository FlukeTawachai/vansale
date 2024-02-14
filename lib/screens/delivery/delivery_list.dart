import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/pocdResp.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/delivery/delivery_bill/thermalPrint.dart';
import 'package:vansale/screens/delivery/delivery_list_today.dart';
import 'package:vansale/screens/home/home.dart';
import 'package:vansale/screens/navigatorStore/selectGroupRoute.dart';

class DeliveryList extends StatefulWidget {
  //const DeliveryList({ Key? key }) : super(key: key);
  final String typeMenuCode;
  DeliveryList(this.typeMenuCode);
  @override
  _DeliveryListState createState() => _DeliveryListState();
}

class _DeliveryListState extends State<DeliveryList> {
  List<RouteCusResp> routeCusList = [];
  List<RouteCusResp> completeList = [];
  List<RouteCusResp> inCompleteList = [];
  double numBasket = 0;
  PocdResp pocdResp = PocdResp(cCUSTCD: '', cPOCD: '', dPODATE: '');
  PoHDAndPoDTResp sumBaskets = PoHDAndPoDTResp(
      cCUSTCD: '', cPOCD: '', iitems: '0', ibasket: '0', iTOTAL: '0.00');
  double itemNum = 0, basketNum = 0;
  double amount = 0.0;
  List<PoHDAndPoDTResp> sumOfStore = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRouteTransfers(GlobalParam.deliveryRouteToday['cRTECD']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text('ส่งสินค้า (${completeList.length}/${routeCusList.length})'),
        leading: IconButton(
          onPressed: () {
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    HomePage(widget.typeMenuCode),
              ),
            );
          },
          icon: Icon(LineAwesomeIcons.home),
        ),
      ),
      body:
          // Center(child: SelectGroupRoute())
          DefaultTabController(
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
                  // Tab(
                  //   text: Utility.formatDatetimeYesterday(DateTime.now()),
                  // ),
                  Tab(
                    text: 'ส่งแล้ว',
                  ),
                  Tab(
                    text: 'รอส่ง',
                  ),
                  // Tab(
                  //   text: Utility.formatDatetimeTomorrow(DateTime.now()),
                  // ),
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
                child: DeliveryListToday(completeList, sumOfStore),
              ),
              Card(
                elevation: 0.0,
                color: HexColor("#F2F3F4"),
                child: DeliveryListToday(inCompleteList, sumOfStore),
              ),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //       // Navigator.of(context).push(
          //     //     MaterialPageRoute(builder: (context) => ThermalPrint()));
          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => ThermalPrint()));
          //   },
          //   child: Icon(LineAwesomeIcons.print),
          // ),
        ),
      ),
    );
  }

  getRouteTransfers(String id) async {
    if (id != '') {
      try {
        AllApiProxyMobile proxy = AllApiProxyMobile();

        var outputFormat = DateFormat('yyyy-MM-dd');
        var outputDate = outputFormat.format(new DateTime.now());
        // print(outputDate);

        var result = await proxy.getRouteTransfer(
            id,
            outputDate,
            GlobalParam.deliveryRouteToday['cGRPCD'],
            GlobalParam.VEHICLE['cBRANCD'],
            true);
        // var result = await proxy.getRouteTransfer('RBR013', '2022-11-28',
        //     'GRMON', GlobalParam.deliveryRouteToday['cBRANCD'], true);
        if (result.isNotEmpty) {
          routeCusList.clear();
          sumOfStore.clear();
          GlobalParam.deliveryListStores.clear();

          for (int i = 0; i < result.length; i++) {
            if (result[i].cPREPAIRCFSTATUS == "Y") {
              routeCusList.add(result[i]);
            }
            // GlobalParam.deliveryListStores.add(result[i]);
            if (result[i].cPOSTATUS == '4') {
              completeList.add(result[i]);
            } else {
              if (result[i].cPREPAIRCFSTATUS == 'Y') {
                inCompleteList.add(result[i]);
              }
            }
            // print(result[i].cADDRESS);
          }

          for (int i = 0; i < routeCusList.length; i++) {
            getPocdOfcustomer(routeCusList[i].cCUSTCD);
          }
          setState(() {
            GlobalParam.deliveryListStores = routeCusList;
          });
        } else {
          routeCusList.clear();
        }
      } on SocketException catch (e) {
        wrongDialog(e.message);
      } on Exception catch (e) {
        wrongDialog(e.toString());
      }
    } else {
      wrongDialog('กรุณาระบุชื่อสาย');
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

  getPocdOfcustomer(String custcd) async {
    if (custcd != '') {
      if (custcd != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();
          var outputFormat = DateFormat('yyyy-MM-dd');
          var outputDate = outputFormat.format(new DateTime.now());
          print(outputDate);

          var result = await proxy.getPocd(custcd, outputDate);
          if ((result.cPOCD != '')) {
            // print("+++++++++++++++++ ${result.cPOCD} +++++++++++++++++");
            setState(() {
              pocdResp = result;
              getBasketsofCustomer(pocdResp.cCUSTCD, pocdResp.cPOCD);
            });
          } else {
            // print("+++++++++++++++++ null +++++++++++++++++");
            setState(() {
              pocdResp = PocdResp(cCUSTCD: custcd, cPOCD: '', dPODATE: '');
            });
          }
        } on SocketException catch (e) {
          wrongDialog(e.message);
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
      }
    } else {
      wrongDialog("custcd is null.");
    }
  }

  getBasketsofCustomer(String custcd, String pocd) async {
    if (custcd != '') {
      if (custcd != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result = await proxy.getBaskets(custcd, pocd, '%%', '%%');
          // sumOfStore.clear();
          if ((result.isNotEmpty)) {
            // print("+++++++++++++++++ ${result.cPOCD} +++++++++++++++++");
            itemNum = 0;
            basketNum = 0;
            amount = 0;
            for (int i = 0; i < result.length; i++) {
              itemNum += double.parse(result[i].iitems);
              basketNum += double.parse(result[i].ibasket);
              amount += double.parse(result[i].iTOTAL);
            }
            setState(() {
              sumBaskets = PoHDAndPoDTResp(
                  cCUSTCD: custcd,
                  cPOCD: pocd,
                  iitems: itemNum.toString(),
                  ibasket: basketNum.toString(),
                  iTOTAL: amount.toStringAsFixed(2));
              sumOfStore.add(sumBaskets);
            });
          } else {
            // print("+++++++++++++++++ null +++++++++++++++++");
            setState(() {
              sumBaskets = PoHDAndPoDTResp(
                  cCUSTCD: custcd,
                  cPOCD: pocd,
                  iitems: '0',
                  ibasket: '0',
                  iTOTAL: '0.0');
              sumOfStore.add(sumBaskets);
            });
          }
          // print('++++++++++++ ${sumOfStore.length} ++++++++++++');
        } on SocketException catch (e) {
          wrongDialog(e.message);
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
      }
    } else {
      wrongDialog("custcd is null.");
    }
  }
}
