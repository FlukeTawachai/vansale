import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';
import 'package:vansale/screens/Supplier/transfer/transferSort.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_GetBad_Product.dart';

import 'package:vansale/screens/warehouse3/warehouse3_prepare_order/warehouse3_list_stores.dart';

class Warehouse3SearchCard extends StatefulWidget {
  final String? cRTECD;
  final String? cRTENM;
  final String? cGRPCD;
  const Warehouse3SearchCard({Key? key, this.cRTECD, this.cRTENM, this.cGRPCD})
      : super(key: key);

  @override
  State<Warehouse3SearchCard> createState() => _Warehouse3SearchCardState();
}

class _Warehouse3SearchCardState extends State<Warehouse3SearchCard> {
  List<RouteCusResp> routeCusList = [];
  List<RouteCusResp> routeCusYstatusList = [];
  Future<int>? storeNumber;

  @override
  void initState() {
    routeCusList.clear();
    setState(() {
      storeNumber = getRouteTransfers(widget.cRTECD!);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: storeNumber,
        builder: (context, AsyncSnapshot<int> allStore) {
          if (allStore.hasData) {
            return Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (GlobalParam.typeMenuCode == 'T006') {
                        if (GlobalParam.subMenuCode == "001") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Warehouse3StoreList(
                                      GlobalParam.typeMenuCode!,
                                      widget.cRTENM!,
                                      widget.cRTECD!,
                                      widget.cGRPCD!),
                            ),
                          );
                        } else if (GlobalParam.subMenuCode == "003") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DeliveryStoreGetBadProduct(
                                      GlobalParam.typeMenuCode!, widget.cRTENM!),
                            ),
                          );
                        }
                      } else if (GlobalParam.typeMenuCode == 'T001') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TranferSort(),
                          ),
                        );
                      }
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      "${widget.cRTENM}",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "รวม ${allStore.data} ร้าน",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'จัดแล้ว ${routeCusYstatusList.length} ร้าน',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  child: Text(
                                    'รอจัด ${allStore.data! - routeCusYstatusList.length} ร้าน',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
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
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  getRouteTransfers(String id) async {
    if ((id != null) && (id != '')) {
      try {
        AllApiProxyMobile proxy = AllApiProxyMobile();
        var outputFormat = DateFormat('yyyy-MM-dd');
        var outputDate = outputFormat.format(new DateTime.now());
        // print(outputDate);

        var result = await proxy.getRouteTransfer(id, outputDate, widget.cGRPCD!,
            GlobalParam.VEHICLE['cBRANCD']!, false);

        // print(id);
        // print(outputDate);
        // print(widget.cGRPCD);
        // print(GlobalParam.deliveryRouteToday['cBRANCD']);
        if (result.isNotEmpty) {
          // routeCusList.clear();
          routeCusYstatusList.clear();
          int num = 0;
          for (int i = 0; i < result.length; i++) {
            if (result[i].cPOSTATUS != '3' &&
                result[i].cPOSTATUS != '4' &&
                result[i].cPOSTATUS != '5' &&
                result[i].cPOSTATUS != '6') {
              num++;
              if (result[i].cPREPAIRCFSTATUS == 'Y') {
                routeCusYstatusList.add(result[i]);
              }
            }
          }
          return num;
        } else {
          // routeCusList.clear();
          routeCusYstatusList.clear();
          return 0;
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
