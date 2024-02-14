import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getSaleStoreOrderReq.dart';
import 'package:vansale/api/class/response/routeMobile/MapRouteResp.dart';
import 'package:vansale/api/class/response/routeMobile/getSaleStoreOrderResp.dart';
import 'package:vansale/screens/sale/survey/sale_listSale.dart';

class SaleDelivery extends StatefulWidget {
  //const DeliveryList({ Key? key }) : super(key: key);
  final String typeMenuCode;
  SaleDelivery(this.typeMenuCode);
  @override
  _SaleDeliveryState createState() => _SaleDeliveryState();
}

class _SaleDeliveryState extends State<SaleDelivery> {
  DateTime dateNow = DateTime.now();
  List<GetSaleStoreOrderResp> saleList = [];
  List<GetSaleStoreOrderResp> notSaleList = [];
  List<GetSaleStoreOrderResp> saleListTem = [];
  List<GetSaleStoreOrderResp> notSaleListTem = [];
  List<MapRoute> lstProvices = [
    MapRoute(cRTECD: '', cRTENM: "ค้นหาสาย", cGRPCD: '', cBRANCD: '')
  ];
  String dropdownProvince = 'ค้นหาสาย';
  TextEditingController searchStore = TextEditingController();
  var routeSelect = GetSaleStoreOrderReq();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(new DateTime.now());
    getMapRoute();
    getSaleStoreOrder(GetSaleStoreOrderReq(
        cBRANCD: GlobalParam.deliveryRouteToday['cBRANCD'],
        cGRPCD: GlobalParam.deliveryRouteToday['cGRPCD'],
        cRTECD: GlobalParam.deliveryRouteToday['cRTECD'],
        dPODATE: outputDate));
    getRouteTransfers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'ขายสินค้า (${saleListTem.length}/${notSaleListTem.length + saleListTem.length})',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 48,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownProvince,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                              fontFamily: "Prompt",
                              fontSize: 16,
                              color: HexColor('#000000'),
                            ),
                            onChanged: (newValue) async {
                              print(newValue);
                              var dataselect = MapRoute(
                                  cBRANCD: '',
                                  cGRPCD: '',
                                  cRTECD: '',
                                  cRTENM: '');
                              for (var arr in lstProvices) {
                                dataselect = MapRoute(
                                    cBRANCD: arr.cBRANCD,
                                    cGRPCD: arr.cGRPCD,
                                    cRTECD: arr.cRTECD,
                                    cRTENM: arr.cRTENM);
                                if (arr.cRTENM == newValue) {
                                  break;
                                }
                              }
                              routeSelect = GetSaleStoreOrderReq(
                                  cBRANCD: dataselect.cBRANCD,
                                  cGRPCD: dataselect.cGRPCD,
                                  cRTECD: dataselect.cRTECD,
                                  dPODATE: DateFormat('yyyy-MM-dd')
                                      .format(new DateTime.now()));
                              getSaleStoreOrder(GetSaleStoreOrderReq(
                                  cBRANCD: dataselect.cBRANCD,
                                  cGRPCD: dataselect.cGRPCD,
                                  cRTECD: dataselect.cRTECD,
                                  dPODATE: DateFormat('yyyy-MM-dd')
                                      .format(new DateTime.now())));
                              setState(() {
                                dropdownProvince = newValue!;
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return lstProvices.map((MapRoute value) {
                                String color = '#00cb39';
                                if (value.cRTENM == 'ค้นหาสาย') {
                                  color = '#68879A';
                                }
                                return Text(
                                  value.cRTENM!,
                                  style: TextStyle(
                                      color: HexColor('$color'),
                                      fontFamily: "Prompt",
                                      fontSize: 16),
                                );
                              }).toList();
                            },
                            items: lstProvices.map<DropdownMenuItem<String>>(
                                (MapRoute value) {
                              // dropdownProvinceColor = '#000000';
                              return DropdownMenuItem<String>(
                                value: value.cRTENM,
                                child: Text(
                                  value.cRTENM!,
                                  // style: TextStyle(
                                  //     color: HexColor('${dropdownProvinceColor}')),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
                          child: TextFormField(
                              controller: searchStore,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "ค้นหาร้านค้า",
                                hintStyle: TextStyle(
                                    color: HexColor('#68879A'), fontSize: 14),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                setState(() {
                                  List<GetSaleStoreOrderResp> listSale = [];
                                  List<GetSaleStoreOrderResp> listNotSale = [];

                                  if (value != "") {
                                    for (var i = 0; i < saleList.length; i++) {
                                      if (saleList[i]
                                              .cCUSTNM!
                                              .startsWith(value) ==
                                          true) {
                                        listSale.add(saleList[i]);
                                      }
                                    }

                                    for (var i = 0;
                                        i < notSaleList.length;
                                        i++) {
                                      if (notSaleList[i]
                                              .cCUSTNM!
                                              .startsWith(value) ==
                                          true) {
                                        listNotSale.add(notSaleList[i]);
                                      }
                                    }
                                    saleList = [];
                                    notSaleList = [];
                                    saleList = listSale;
                                    notSaleList = listNotSale;
                                  } else {
                                    saleList = [];
                                    notSaleList = [];
                                    saleList = saleListTem;
                                    notSaleList = notSaleListTem;
                                    // getSaleStoreOrder(routeSelect);
                                  }
                                });
                              })),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                initialIndex: 1,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize:
                        Size.fromHeight(50.0), // here the desired height
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
                            text: 'ขายแล้ว',
                          ),
                          Tab(
                            text: 'รอขาย',
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      SaleListSale(data: saleList),
                      SaleListSale(data: notSaleList)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getMapRoute() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var result = await proxy.getMapRoute();
      GlobalParam.mapRoute = [];
      if (result.isNotEmpty) {
        for (var arr in result) {
          lstProvices.add(MapRoute(
              cRTECD: arr.cRTECD,
              cRTENM: arr.cRTENM,
              cGRPCD: arr.cGRPCD,
              cBRANCD: arr.cBRANCD));
        }
      }

      // setState(() {});
      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getSaleStoreOrder(GetSaleStoreOrderReq req) async {
    try {
      saleList = [];
      notSaleList = [];
      saleListTem = [];
      notSaleListTem = [];
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var result = await proxy.getSaleStoreOrder(req);
      GlobalParam.customerShowRecheckPROStockList = [];
      if (result.isNotEmpty) {
        for (var i = 0; i < result.length; i++) {
          if (result[i].cPOCD!.isNotEmpty) {
            var status = false;
            for (var arr in result[i].cPOCD!) {
              if (arr != '') {
                result[i].cPOCD![0] = arr;
                status = true;
                break;
              }
            }
            if (status) {
              saleList.add(result[i]);
              saleListTem.add(result[i]);
            } else {
              notSaleList.add(result[i]);
              notSaleListTem.add(result[i]);
            }
          } else {
            notSaleList.add(result[i]);
            notSaleListTem.add(result[i]);
          }
        }
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  getRouteTransfers() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var outputFormat = DateFormat('yyyy-MM-dd');
      var outputDate = outputFormat.format(new DateTime.now());
      // print(outputDate);

      var result = await proxy.getRouteTransfer(
          GlobalParam.deliveryRouteToday['cRTECD']!,
          outputDate,
          GlobalParam.deliveryRouteToday['cGRPCD']!,
          GlobalParam.deliveryRouteToday['cBRANCD']!,
          true);
      // var result = await proxy.getRouteTransfer('RBR013', '2022-11-28',
      //     'GRMON', GlobalParam.deliveryRouteToday['cBRANCD'], true);
      if (result.isNotEmpty) {
        GlobalParam.deliveryListStores = [];

        GlobalParam.deliveryListStores.addAll(result);
      }
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
