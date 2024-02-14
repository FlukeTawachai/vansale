import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/getCustForSortingReq.dart';
import 'package:vansale/api/class/request/mobile/updateStroreSortingReq.dart';
import 'package:vansale/api/class/response/routeMobile/getCustForSortingResp.dart';
import 'package:vansale/screens/delivery/delivery_new_supplier/delivery_new_supplier_main.dart';
import 'package:vansale/screens/home/home.dart';

class TranferSort extends StatefulWidget {
  const TranferSort({
    Key key,
  }) : super(key: key);

  @override
  State<TranferSort> createState() => _TranferSortState();
}

class _TranferSortState extends State<TranferSort> {

  List<int> _items = List<int>.generate(50, (int index) => index);

  List<GetCustForSortingResp> storeList = [];
  double widthScreen = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustForSorting(GetCustForSortingReq(
        cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
        cVEHICD: GlobalParam.VEHICLE['cVEHICD'],
        cGRPCD: GlobalParam.deliveryRouteToday['cGRPCD'],
        cRTECD: GlobalParam.deliveryRouteToday['cRTECD']));
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'เรียงร้านค้า',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        // leading: Container(),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 48, 0, 0),
            child: ReorderableListView.builder(
              itemCount: storeList.length,
              itemBuilder: (context, index) {
                // if (storeList[index].iSEQROUTE == null) {
                //   updateStroreSorting(UpdateStroreSortingReq(
                //       cCUSTCD: storeList[index].cCUSTCD,
                //       cGRPCD: GlobalParam.deliveryRouteToday['cGRPCD'],
                //       cRTECD: GlobalParam.deliveryRouteToday['cRTECD'],
                //       iSEQROUTE: index,
                //       cUPDABY: GlobalParam.userID));
                // }
                return Container(
                  key: ValueKey('$index'),
                  height: 52,
                  decoration: BoxDecoration(
                    // color: Colors.green,
                    border: Border(
                      // top: BorderSide(width: 1.0, color: Colors.grey),
                      // left:
                      //     BorderSide(width: 1.0, color: Colors.grey),
                      // right:
                      //     BorderSide(width: 1.0, color: Colors.grey),
                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                    ),
                  ),
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                      // color: Colors.green,
                      border: Border(
                        // top: BorderSide(width: 1.0, color: Colors.grey),
                        left: BorderSide(width: 1.0, color: Colors.grey),
                        // right:
                        //     BorderSide(width: 1.0, color: Colors.grey),
                        // bottom:
                        //     BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              // color: Colors.green,
                              border: Border(
                                // top: BorderSide(width: 1.0, color: Colors.grey),
                                // left: BorderSide(width: 1.0, color: Colors.grey),
                                right:
                                    BorderSide(width: 1.0, color: Colors.grey),
                                // bottom:
                                //     BorderSide(width: 1.0, color: Colors.grey),
                              ),
                            ),
                            width: widthScreen * 0.2,
                            height: 64,
                            child: Center(
                              child: Text('${storeList[index].iSEQROUTE}',
                                  style: TextStyle(
                                    fontFamily: "Prompt",
                                    fontSize: 16,
                                    color: HexColor('#000000'),
                                    // fontFamily: "Prompt",
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: widthScreen * 0.5,
                                  child: Text(storeList[index].cCUSTNM,
                                      style: TextStyle(
                                        fontFamily: "Prompt",
                                        fontSize: 16,
                                        color: HexColor('#000000'),
                                        // fontFamily: "Prompt",
                                        overflow: TextOverflow.ellipsis
                                      ),
                                      textAlign: TextAlign.left),
                                ),
                                Container(
                                  width: widthScreen * 0.5,
                                  child: Text(
                                      'ระยะห่าง ${storeList[index].cDISTANCS} กม.',
                                      style: TextStyle(
                                        fontFamily: "Prompt",
                                        fontSize: 14,
                                        color: Colors.grey,
                                        // fontFamily: "Prompt",
                                      ),
                                      textAlign: TextAlign.left),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              GlobalParam.updateCustomerID = storeList[index].cCUSTCD;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DeliveryNewSupplierMain(
                                      GlobalParam.typeMenuCode)));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                updateStroreSorting(UpdateStroreSortingReq(
                    cCUSTCD: storeList[oldIndex].cCUSTCD,
                    cGRPCD: GlobalParam.deliveryRouteToday['cGRPCD'],
                    cRTECD: GlobalParam.deliveryRouteToday['cRTECD'],
                    iSEQROUTE: newIndex + 1,
                    cUPDABY: GlobalParam.userID));

                updateStroreSorting(UpdateStroreSortingReq(
                    cCUSTCD: storeList[newIndex].cCUSTCD,
                    cGRPCD: GlobalParam.deliveryRouteToday['cGRPCD'],
                    cRTECD: GlobalParam.deliveryRouteToday['cRTECD'],
                    iSEQROUTE: oldIndex + 1,
                    cUPDABY: GlobalParam.userID));
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final int item = _items.removeAt(oldIndex);
                  final newStores = storeList.removeAt(oldIndex);
                  _items.insert(newIndex, item);
                  storeList.insert(newIndex, newStores);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Row(children: [
                    Container(
                        width: widthScreen * 0.2,
                        child: Center(
                            child:
                                Text('ลำดับ', style: TextStyle(fontSize: 16)))),
                    Container(
                        width: widthScreen * 0.6,
                        child: Center(
                            child: Text('ชื่อร้าน',
                                style: TextStyle(fontSize: 16))))
                  ]),
                  Divider(color: Colors.black),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: InkWell(
      //   onTap: () {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (context) => HomePage("T001")));
      //   },
      //   child: Container(
      //     height: 64,
      //     color: Colors.white,
      //     child: Center(
      //       child: Container(
      //         child: Text(
      //           "บันทึก",
      //           style: TextStyle(
      //               fontFamily: "Prompt",
      //               fontSize: 20,
      //               color: HexColor('#00cb39')),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  getCustForSorting(GetCustForSortingReq req) async {
    try {
      // print("************** $nameOfRoute **************");

      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getCustForSorting(req);
      if (result.isNotEmpty) {
        storeList = [];
        for (int i = 0; i < result.length; i++) {
          if (result[i].iSEQROUTE == null) {
            updateStroreSorting(UpdateStroreSortingReq(
                cCUSTCD: result[i].cCUSTCD,
                cGRPCD: GlobalParam.deliveryRouteToday['cGRPCD'],
                cRTECD: GlobalParam.deliveryRouteToday['cRTECD'],
                iSEQROUTE: i + 1,
                cUPDABY: GlobalParam.userID));
          }
          storeList.add(result[i]);
        }
      }
      _items = List<int>.generate(result.length, (int index) => index);
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    setState(() {});
  }

  updateStroreSorting(UpdateStroreSortingReq req) async {
    try {
      // print("************** $nameOfRoute **************");

      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.updateStroreSorting(req);
      if (result.success == false) {
        wrongDialog('${result.message}');
      } else {
        storeList = [];
        getCustForSorting(GetCustForSortingReq(
            cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
            cVEHICD: GlobalParam.VEHICLE['cVEHICD'],
            cGRPCD: GlobalParam.deliveryRouteToday['cGRPCD'],
            cRTECD: GlobalParam.deliveryRouteToday['cRTECD']));
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
