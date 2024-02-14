import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/response/routeMobile/pocdResp.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/api/class/response/routeMobile/routeCusResp.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_home.dart';
import 'package:vansale/screens/warehouse3/warehouse3_prepare_order/warehouse3_prepare_product.dart';

class NewWarehouse3StoreCard extends StatefulWidget {
  //const DeliveryListToday({ Key? key }) : super(key: key);
  final String typeMenuCode;
  final RouteCusResp store;
  // final PocdResp pocd;
  NewWarehouse3StoreCard(this.typeMenuCode, this.store);
  @override
  _NewWarehouse3StoreCardState createState() => _NewWarehouse3StoreCardState();
}

class _NewWarehouse3StoreCardState extends State<NewWarehouse3StoreCard> {
  PocdResp pocdResp = PocdResp(cCUSTCD: '', cPOCD: '', dPODATE: '');
  PoHDAndPoDTResp sumBaskets = PoHDAndPoDTResp(
      cCUSTCD: '', cPOCD: '', iitems: '0', ibasket: '0', iTOTAL: '0.00');
  List<PoHDAndPoDTResp> baskets = [];
  double itemNum = 0, basketNum = 0;
  double amount = 0.0;
  @override
  void initState() {
    setState(() {
      getPocdOfcustomer(widget.store.cCUSTCD!);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(3.0),
      color: HexColor("#F2F3F4"),
      child: SingleChildScrollView(
        child: Container(
          // padding: const EdgeInsets.all(5.0),
          height: 136.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Container(
                    // color:Colors.red,
                    child: Row(
                  children: [
                    Container(
                      width: widthScreen * 0.2,
                      child: widget.store.cPHOTOSERV != ''
                          ? CircleAvatar(
                              radius: 36.0,
                              backgroundImage: NetworkImage(
                                  'http://${widget.store.cPHOTOSERV}/${widget.store.cPHOTOPATH}'),
                              backgroundColor: Colors.transparent,
                            )
                          : CircleAvatar(
                              radius: 36.0,
                              backgroundColor: Colors.white,
                              child: Image.asset(
                                "assets/images/no_image.png",
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: widthScreen * 0.55,
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.store.cCUSTNM!,
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Container(
                            width: widthScreen * 0.55,
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.store.cADDRESS!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: widthScreen * 0.1,
                        child: IconButton(
                          icon: Icon(LineAwesomeIcons.dolly,
                              color: Colors.green, size: 24),
                          onPressed: () {
                            if (widget.typeMenuCode == 'T006') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      WarehousePrepareProduct(
                                          widget.typeMenuCode,
                                          widget.store.cCUSTTYPE == "Wholesale"
                                              ? true
                                              : false,
                                          sumBaskets.cPOCD!),
                                ),
                              );
                            } else if (widget.typeMenuCode == 'T001') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DeliveryStoreHome(
                                          widget.typeMenuCode, "A Store"),
                                ),
                              );
                            }
                          },
                          iconSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Container(
                    // color:Colors.green,
                    child: Row(
                  children: [
                    Container(
                      width: widthScreen * 0.2,
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.boxes,
                          color: Colors.grey,
                          size: 20.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: widthScreen * 0.7,
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    "${sumBaskets.ibasket} รายการ ,${sumBaskets.ibasket} ตระกร้า",
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: SubstringPrice(
                                      sumBaskets.iTOTAL,
                                      14.0,
                                      12.0,
                                      Colors.orange,
                                      Colors.orange,
                                      'Prompt',
                                      'Prompt',
                                      FontWeight.bold,
                                      FontWeight.bold,
                                      '',
                                      12.0,
                                      Colors.orange,
                                      'Prompt',
                                      FontWeight.bold,
                                      FontStyle.normal,
                                      FontStyle.normal,
                                      FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: widthScreen * 0.7,
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    "No. ${pocdResp.cPOCD}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    child: Text(
                                      'THB',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
              DottedLine(
                dashColor: Colors.grey,
              ),
            ],
          ),
        ),
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
          // print(outputDate);

          var result = await proxy.getPocd(custcd, outputDate);
          if ((result.cPOCD != '')) {
            // print("+++++++++++++++++ ${result.cPOCD} +++++++++++++++++");
            setState(() {
              pocdResp = result;
            });
            getBasketsofCustomer(pocdResp.cCUSTCD!, pocdResp.cPOCD!);
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
          if ((result.isNotEmpty)) {
            // print("+++++++++++++++++ ${result.cPOCD} +++++++++++++++++");
            for (int i = 0; i < result.length; i++) {
              itemNum += double.parse(result[i].iitems!);
              basketNum += double.parse(result[i].ibasket!);
              amount += double.parse(result[i].iTOTAL!);
            }
            setState(() {
              sumBaskets = PoHDAndPoDTResp(
                  cCUSTCD: custcd,
                  cPOCD: pocd,
                  iitems: itemNum.toStringAsFixed(0),
                  ibasket: basketNum.toStringAsFixed(0),
                  iTOTAL: amount.toStringAsFixed(2));
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
