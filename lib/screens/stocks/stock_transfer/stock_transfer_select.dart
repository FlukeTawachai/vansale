import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getGroupRouteReq.dart';
import 'package:vansale/api/class/request/mobile/getProductReturnOfRouteReq.dart';
import 'package:vansale/api/class/response/routeMobile/getGroupRouteResp.dart';

import 'package:vansale/screens/stocks/stock_transfer/stock_transfer_miss.dart';

class StockSelectGroup extends StatefulWidget {
  const StockSelectGroup({Key? key}) : super(key: key);

  @override
  State<StockSelectGroup> createState() => _StockSelectGroupState();
}

class _StockSelectGroupState extends State<StockSelectGroup> {
  List<GetGroupRouteResp> StockSelectGroup = [];
  double widthScreen = 0.0;
  String dayName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String cGRPCD = "";
    final moonLanding = new DateTime.now();
    // print(moonLanding.weekday); // 7
    if (moonLanding.weekday == 7) {
      cGRPCD = "GRSUN";
      dayName = 'วันอาทิตย์';
    } else if (moonLanding.weekday == 1) {
      cGRPCD = "GRMON";
      dayName = 'วันจันทร์';
    } else if (moonLanding.weekday == 2) {
      cGRPCD = "GRTUE";
      dayName = 'วันอังคาร';
    } else if (moonLanding.weekday == 3) {
      cGRPCD = "GRWED";
      dayName = 'วันพุธ';
    } else if (moonLanding.weekday == 4) {
      cGRPCD = "GRTHU";
      dayName = 'วันพฤหัสบดี';
    } else if (moonLanding.weekday == 5) {
      cGRPCD = "GRFRI";
      dayName = 'วันศุกร์';
    } else if (moonLanding.weekday == 6) {
      cGRPCD = "GRSAT";
      dayName = 'วันเสาร์';
    }
    getRouteGroup(cGRPCD);
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            dayName,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Prompt',
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          child: ListView.builder(
              itemCount: StockSelectGroup.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  child: InkWell(
                    onTap: () {
                      var outputFormat = DateFormat('yyyy-MM-dd');
                      var outputDate = outputFormat.format(new DateTime.now());
                      GlobalParam.stockTransferReq = GetProductReturnOfRouteReq(
                        cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                        cGRPCD: StockSelectGroup[index].cGRPCD,
                        cRTECD: StockSelectGroup[index].cRTECD,
                        dRETDT: outputDate,
                      );
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              StockTransferReturnMissPro(true)));
                    },
                    child: Container(
                      alignment: Alignment.topLeft,
                      height: 56.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: widthScreen * 0.8,
                            height: 24,
                            alignment: Alignment.topLeft,
                            child: Text(
                              StockSelectGroup[index].cRTENM!,
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          DottedLine(
                            dashColor: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }

  getRouteGroup(String cGRPCD) async {
    if (cGRPCD != '') {
      if (cGRPCD != null) {
        try {
          AllApiProxyMobile proxy = AllApiProxyMobile();

          var result = await proxy.getRouteGroup(GetGroupRouteReq(
              cBRANCD: GlobalParam.VEHICLE["cBRANCD"], cGRPCD: cGRPCD));
          if ((result.isNotEmpty)) {
            setState(() {
              StockSelectGroup = [];
              StockSelectGroup.addAll(result);
            });
          }
        } on SocketException catch (e) {
          wrongDialog(e.message);
        } on Exception catch (e) {
          wrongDialog(e.toString());
        }
      }
    } else {}
  }

  wrongDialog(var msg) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('Information'),
        content: Text(
          '$msg',
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
