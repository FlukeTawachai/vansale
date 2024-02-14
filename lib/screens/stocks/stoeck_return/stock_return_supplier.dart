import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/getSupplierResp.dart';
import 'package:vansale/screens/stocks/stoeck_return/stock_return_basket.dart';

class SupplierList extends StatefulWidget {
  const SupplierList({Key? key}) : super(key: key);

  @override
  State<SupplierList> createState() => _SupplierListState();
}

class _SupplierListState extends State<SupplierList> {
  List<GetSupplierResp> supplierList = [];
  double widthScreen = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchProductBranch();
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
            'ซัพพลายเออร์',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Prompt',
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: supplierList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: InkWell(
                  onTap: () {
                    GlobalParam.stockSupSelect = supplierList[index];
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StockBasketReturn(
                            typeMenuCode: GlobalParam.typeMenuCode!,
                            supplier: supplierList[index])));
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: 90.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: widthScreen * 0.8,
                          height: 24,
                          alignment: Alignment.topLeft,
                          child: Text(
                            supplierList[index].cSUPNM!,
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Container(
                          width: widthScreen * 0.8,
                          height: 24,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'ติดต่อ : ${supplierList[index].cCONTACT}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          width: widthScreen * 0.8,
                          height: 24,
                          alignment: Alignment.topLeft,
                          child: Text(
                            'โทร : ${supplierList[index].cCONTTEL}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        DottedLine(
                          dashColor: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  searchProductBranch() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var result = await proxy.getSupplier();

      if (result.isNotEmpty) {
        supplierList.addAll(result);
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
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
