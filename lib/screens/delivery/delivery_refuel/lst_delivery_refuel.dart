import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/searchRefuelReq.dart';
import 'package:vansale/api/class/response/routeMobile/searchRefuelResp.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/delivery/delivery_refuel/delivery_refuel_lst_detail.dart';

class ListDeliveryRefuel extends StatefulWidget {
  const ListDeliveryRefuel({Key key}) : super(key: key);

  @override
  State<ListDeliveryRefuel> createState() => _ListDeliveryRefuelState();
}

class _ListDeliveryRefuelState extends State<ListDeliveryRefuel> {
  List<SearchRefuelResp> refuelList = [];
  var outputFormat = DateFormat('dd-MM-yyyy');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var outputFormat = DateFormat('yyyy-MM-dd');
    // var outputDate = outputFormat.format(new DateTime.now());
    searchRefuel(SearchRefuelReq(
        cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
        cVEHICD: GlobalParam.VEHICLE['cVEHICD'],
        dINVENTDT: '%%'));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      itemCount: refuelList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => DeliveryRefuelListDetail(data:refuelList[index]),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  height: 80.0,
                  child: Row(
                    children: [
                      iconItem_(),
                      kilometer_(index),
                      nameTotal_(index),
                      dateUnit_(index),
                    ],
                  ),
                ),
                Container(
                  child: DottedLine(
                    dashColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget iconItem_() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      alignment: Alignment.centerRight,
      width: 80.0,
      child: Icon(
        LineAwesomeIcons.gas_pump,
        color: Colors.green,
        size: 40.0,
      ),
    );
  }

  Widget nameTotal_(index) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                refuelList[index].cFUELNM,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              child: Text(
                '${double.parse(refuelList[index].iLITER).toStringAsFixed(0)} ลิตร',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateUnit_(index) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                '${outputFormat.format(DateTime.parse(refuelList[index].dINVENTDT))}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Utility.formateNumberBK(
                        double.parse(refuelList[index].iTOTAL)),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    child: Text(
                      "THB",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget kilometer_(index) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'ระยะ',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              child: Text(
                '${double.parse(refuelList[index].iKM).toStringAsFixed(0)} กม.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  searchRefuel(SearchRefuelReq req) async {
    try {
      // print("************** $nameOfRoute **************");

      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.searchRefuel(req);
      if (result.isNotEmpty) {
        GlobalParam.refuelList.addAll(result);
        setState(() {
          refuelList.addAll(result);
        });
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
