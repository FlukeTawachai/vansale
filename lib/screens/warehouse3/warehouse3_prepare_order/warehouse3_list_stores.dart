import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/pocdResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';
import 'package:vansale/screens/warehouse3/warehouse3_prepare_order/newStoreCard.dart';
import 'package:vansale/screens/warehouse3/warehouse3_prepare_order/warehouse3StoreCard.dart';

class Warehouse3StoreList extends StatefulWidget {
  //const Warehouse3StoreList({ Key? key }) : super(key: key);
  final String typeMenuCode;
  final String title;
  final String cRTECD;
  final String cGRPCD;
  Warehouse3StoreList(this.typeMenuCode, this.title, this.cRTECD, this.cGRPCD);
  @override
  _Warehouse3StoreListState createState() => _Warehouse3StoreListState();
}

class _Warehouse3StoreListState extends State<Warehouse3StoreList> {
  DateTime dateNow = DateTime.now();
  List<RouteCusResp> routeCusList = [];
  List<PocdResp> pocdResp = [];

  @override
  void initState() {
    getRouteTransfers(widget.cRTECD);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
            body: ListView.builder(
          // padding: const EdgeInsets.all(5),
          itemCount: routeCusList.length,
          itemBuilder: (BuildContext context, int index) {
            // routeCusList.sort((a, b) {
            //   return b.amount.compareTo(a.amount);
            // });
            return NewWarehouse3StoreCard(
                widget.typeMenuCode, routeCusList[index]);
          },
        )),
      ),
    );
  }

  getRouteTransfers(String id) async {
    if (widget.cRTECD != '') {
      try {
        AllApiProxyMobile proxy = AllApiProxyMobile();

        var outputFormat = DateFormat('yyyy-MM-dd');
        var outputDate = outputFormat.format(new DateTime.now());
        List<RouteCusResp> uniqueRouteCusList = [];
        var custList = Set<RouteCusResp>();
        ;
        // print(outputDate);

        var result = await proxy.getRouteTransfer(id, outputDate, widget.cGRPCD,
            GlobalParam.VEHICLE['cBRANCD']!, false);
        if (result.isNotEmpty) {
          routeCusList.clear();
          pocdResp.clear();
          for (int i = 0; i < result.length; i++) {
            if (result[i].cPOSTATUS != '3' &&
                result[i].cPOSTATUS != '4' &&
                result[i].cPOSTATUS != '5' &&
                result[i].cPOSTATUS != '6') {
              routeCusList.add(result[i]);
            }
          }

          uniqueRouteCusList =
              routeCusList.where((value) => custList.add(value)).toList();
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
