import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getSPOrderDTReq.dart';
import 'package:vansale/api/class/response/routeMobile/getSupplierOrderResp.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/stocks/stockOrderDetail.dart';

class StockPOSuccList extends StatefulWidget {
  const StockPOSuccList({Key? key}) : super(key: key);

  @override
  State<StockPOSuccList> createState() => _StockPOSuccListState();
}

class _StockPOSuccListState extends State<StockPOSuccList> {
  String poDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  List<GetSupplierOrderResp> orderList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < GlobalParam.supplierOrderList.length; i++) {
      if (GlobalParam.supplierOrderList[i].cPOSTATUS == '3' ||
          GlobalParam.supplierOrderList[i].cPOSTATUS == '4' ||
          GlobalParam.supplierOrderList[i].cPOSTATUS == '5')
        orderList.add(GlobalParam.supplierOrderList[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (BuildContext context, int index) {
          var item = 0;
          var total = 0.0;

          DateTime tempDate =
              new DateFormat("dd-MM-yyyy").parse(orderList[index].dPODATE!);

          DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .parse(orderList[index].dPODATE!);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('dd-MM-yyyy');
          var outputDate = outputFormat.format(inputDate);
          for (int i = 0; i < GlobalParam.supplierOrProductList.length; i++) {
            if (GlobalParam.supplierOrProductList[i].cPOCD ==
                orderList[index].cPOCD) {
              total +=
                  double.parse(GlobalParam.supplierOrProductList[i].iNETPRICE!);
              item++;
            }
          }

          return InkWell(
            onTap: () {
              GlobalParam.supplierSelectOrder = orderList[index];
              GlobalParam.deliveryRegetPODT = true;
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StockOrderDetail()));
            },
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(orderList[index].cSUPPNM!,
                            style: TextStyle(
                                fontFamily: 'Prompt',
                                fontSize: 16,
                                fontWeight: FontWeight.bold))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                    child: Row(
                      children: [
                        Container(
                            child: Text('เลขที่ ${orderList[index].cPOCD}',
                                style: TextStyle(
                                  fontFamily: 'Prompt',
                                  fontSize: 14,
                                ))),
                        Spacer(),
                        Container(
                            child: Text('วันที่ $outputDate',
                                style: TextStyle(
                                  fontFamily: 'Prompt',
                                  fontSize: 14,
                                ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    child: Row(
                      children: [
                        Container(
                            child: Text('${item} รายการ',
                                style: TextStyle(
                                  fontFamily: 'Prompt',
                                  fontSize: 16,
                                ))),
                        Spacer(),
                        Container(
                          height: 24,
                          alignment: Alignment.centerRight,
                          child: SubstringPrice(
                            '${total}',
                            18.0,
                            14.0,
                            Colors.orange,
                            Colors.orange,
                            'Prompt',
                            'Prompt',
                            FontWeight.bold,
                            FontWeight.bold,
                            '฿',
                            18.0,
                            Colors.orange,
                            'Prompt',
                            FontWeight.bold,
                            FontStyle.normal,
                            FontStyle.normal,
                            FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DottedLine(
                    dashColor: Colors.grey,
                  ),
                ],
              ),
            ),
          );
        });
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
