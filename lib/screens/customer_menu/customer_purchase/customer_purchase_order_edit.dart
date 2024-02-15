import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/addCustomerOrderReq.dart';
import 'package:vansale/api/class/request/mobile/getProductStockReq.dart';
import 'package:vansale/api/class/request/mobile/queryPodtReq.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryAddProduct.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryConfirmDetail.dart';
import 'package:vansale/screens/customer_menu/customer_purchase/customerConfirm.dart';
import 'package:vansale/screens/customer_menu/customer_purchase/customer_filter.dart';
import 'package:vansale/screens/customer_menu/customer_purchase/customer_footer.dart';
import 'package:vansale/screens/customer_menu/customer_purchase/customer_products.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/screens/customer_menu/custommer_Order/customer_add_order.dart';
import 'package:vansale/screens/delivery/delivery_scanner.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_filter.dart';

class CustomerPurchaseOrderEdit extends StatefulWidget {
  final String typeMenuCode;
  final bool reset;
  CustomerPurchaseOrderEdit(this.typeMenuCode, this.reset);

  @override
  State<CustomerPurchaseOrderEdit> createState() =>
      _CustomerPurchaseOrderEditState();
}

class _CustomerPurchaseOrderEditState extends State<CustomerPurchaseOrderEdit> {
  double total = 3200.00;
  double widthScreen = 0;
  var search = TextEditingController();
  var searchData = '';
  var formatNum = new NumberFormat("#,###.##", "en_US");
  // ignore: deprecated_member_use
  List<TextEditingController> incleaseCon = [];
  // ignore: deprecated_member_use
  List<TextEditingController> decleaseCon = [];

  List<QueryPodtResp> orderList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.reset == true) {
      GlobalParam.deliveryPodtList = [];
      GlobalParam.deliveryPodtShow = [];
      for (int i = 0; i < GlobalParam.customerPODTList.length; i++) {
        if (GlobalParam.customerPODTList[i].cPOCD ==
            GlobalParam.customerPOHDSelect!.cPOCD) {
          GlobalParam.deliveryPodtList.add(GlobalParam.customerPODTList[i]);
          GlobalParam.deliveryPodtShow.add(GlobalParam.customerPODTList[i]);
          orderList.add(GlobalParam.customerPODTList[i]);
        }
      }
    }

    GlobalParam.customerStockProductList = [];
    for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
      getProductStock(GetProductStockReq(
          cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
          cPRODCD: '%${GlobalParam.customerProductList[i].cPRODCD}%',
          cWH: '%FG%'));
    }
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'สั่งซื้อ',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: HexColor('#6c7e9b'),
              height: 60.0,
              child: Row(
                children: [
                  Container(
                    width: widthScreen * 0.74,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: TextField(
                              controller: search,
                              onChanged: (value) {
                                setState(() {
                                  searchData = value;
                                });
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  search.text = value;
                                  searchData = value;
                                });
                                getPodtSearch(searchData);
                              },
                              style: const TextStyle(
                                fontFamily: 'Prompt',
                              ),
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                hintText: "ค้นหา",
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.only(left: 5.0, top: 5.0),
                                prefixIcon: RotatedBox(
                                  quarterTurns: 1,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: HexColor('#6c7e9b'),
                                    ),
                                    onPressed: () {
                                      getPodtSearch(searchData);
                                    },
                                    iconSize: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                            child: IconButton(
                              icon: const Icon(Icons.qr_code),
                              iconSize: 25.0,
                              color: Colors.black,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DeliveryQrScanner(
                                          code: '007',
                                          navigator: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CustomerPurchaseOrderEdit(
                                                            GlobalParam
                                                                    .typeMenuCode ??
                                                                '',
                                                            false)));
                                          },
                                        )));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: widthScreen * 0.2,
                    height: 48,
                    child: Card(
                      elevation: 0.0,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CustomerFilterPage(
                                    pageNumber: '001',
                                  )));
                        },
                        child: Container(
                          color: Colors.black12,
                          height: 50.0,
                          alignment: Alignment.center,
                          child: const Text(
                            'ประเภท',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: productList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: footer(),
    );
  }

  Widget productList() {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: GlobalParam.deliveryPodtShow.length,
                itemBuilder: (BuildContext context, int index) {
                  double unitPrice = 0.0;
                  double qty = 0.0;
                  double stock = 0.0;
                  String unitCode = '';
                  String unitName = '';
                  String size = '';
                  incleaseCon.add(new TextEditingController());
                  decleaseCon.add(new TextEditingController());
                  if (GlobalParam.deliveryPodtShow[index].iSSIZEQTY == '') {
                    GlobalParam.deliveryPodtShow[index].iSSIZEQTY = '0';
                  }
                  if (GlobalParam.deliveryPodtShow[index].iMSIZEQTY == '') {
                    GlobalParam.deliveryPodtShow[index].iMSIZEQTY = '0';
                  }
                  if (GlobalParam.deliveryPodtShow[index].iLSIZEQTY == '') {
                    GlobalParam.deliveryPodtShow[index].iLSIZEQTY = '0';
                  }
                  if (GlobalParam.deliveryPodtShow[index].cSUOMCD != "") {
                    qty = double.parse(
                        GlobalParam.deliveryPodtShow[index].iSSIZEQTY ?? '0');
                    unitPrice = double.parse(
                        GlobalParam.deliveryPodtShow[index].iSUNITPRICE ?? '0');
                    unitName =
                        GlobalParam.deliveryPodtShow[index].cSUOMNM ?? '';
                    unitCode =
                        GlobalParam.deliveryPodtShow[index].cSUOMCD ?? '';
                    size = "S";
                  }
                  if (GlobalParam.deliveryPodtShow[index].cMUOMCD != "") {
                    qty = double.parse(
                        GlobalParam.deliveryPodtShow[index].iMSIZEQTY ?? '0');
                    unitPrice = double.parse(
                        GlobalParam.deliveryPodtShow[index].iMUNITPRICE ?? '0');
                    unitName =
                        GlobalParam.deliveryPodtShow[index].cMUOMNM ?? '';
                    unitCode =
                        GlobalParam.deliveryPodtShow[index].cMUOMCD ?? '';
                    size = "M";
                  }
                  if (GlobalParam.deliveryPodtShow[index].cLUOMCD != "") {
                    qty = double.parse(
                        GlobalParam.deliveryPodtShow[index].iLSIZEQTY ?? '0');
                    unitPrice = double.parse(
                        GlobalParam.deliveryPodtShow[index].iLUNITPRICE ?? '0');
                    unitName =
                        GlobalParam.deliveryPodtShow[index].cLUOMNM ?? '';
                    unitCode =
                        GlobalParam.deliveryPodtShow[index].cLUOMCD ?? '';
                    size = "L";
                  }

                  for (var i = 0;
                      i < GlobalParam.customerStockProductList.length;
                      i++) {
                    if (GlobalParam.deliveryPodtShow[index].cPRODCD ==
                        GlobalParam.customerStockProductList[i].cPRODCD) {
                      if (GlobalParam.customerStockProductList[i].cUOMCD ==
                          unitCode) {
                        stock = double.parse(
                            GlobalParam.customerStockProductList[i].iQTY ??
                                '0');
                      }
                    }
                  }
                  return Container(
                    color: HexColor("#F2F3F4"),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          height: 128.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                    image: GlobalParam.deliveryPodtShow[index]
                                                .cPHOTOPATH !=
                                            ''
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              'http://${GlobalParam.deliveryPodtShow[index].cPHOTOSERV}/${GlobalParam.deliveryPodtShow[index].cPHOTOPATH}',
                                            ),
                                            scale: 1.0,
                                            fit: BoxFit.cover,
                                          )
                                        : const DecorationImage(
                                            image: AssetImage(
                                              "assets/images/no_image.png",
                                            ),
                                            scale: 1.0,
                                            fit: BoxFit.cover,
                                          ),
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                    border: Border.all(color: Colors.grey)),
                              ),
                              //----------------------1
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: 128,
                                              child: Text(
                                                GlobalParam
                                                        .deliveryPodtShow[index]
                                                        .cPRODNM ??
                                                    '',
                                                style: const TextStyle(
                                                    fontFamily: 'Prompt',
                                                    fontSize: 16),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              LineAwesomeIcons.trash,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              resetProductOrder(
                                                  size,
                                                  GlobalParam
                                                      .deliveryPodtShow[index],
                                                  index);
                                            },
                                            iconSize: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                    //--------------------2
                                    Expanded(
                                      child: Container(
                                        // width: 128,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "สต็อก ${stock.toStringAsFixed(0)} ${unitName}",
                                          style: const TextStyle(
                                              fontFamily: 'Prompt',
                                              fontSize: 12,
                                              color: Colors.green),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    //--------------------3
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              width: 80.0,
                                              // padding: const EdgeInsets.all(5.0),
                                              alignment: Alignment.centerLeft,
                                              child: const Center(
                                                child: Text(
                                                  "ยอดสั่งซื้อ",
                                                  style: TextStyle(
                                                      fontFamily: 'Prompt',
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: 80.0,
                                              alignment: Alignment.centerLeft,
                                              child: const Center(
                                                child: Text(
                                                  "ลด",
                                                  style: TextStyle(
                                                      fontFamily: 'Prompt',
                                                      color: Colors.red,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: 80.0,
                                              alignment: Alignment.centerLeft,
                                              child: const Center(
                                                child: Text(
                                                  "เพิ่ม",
                                                  style: TextStyle(
                                                      fontFamily: 'Prompt',
                                                      color: Colors.green,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   child: Container(
                                          //     alignment: Alignment.centerLeft,
                                          //     child: Text(
                                          //       "คงค้าง",
                                          //       style: TextStyle(
                                          //           fontFamily: 'Prompt',
                                          //           color: Colors.blue),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    //----------------------------4
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // ----------------------5
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              height: 30.0,
                                              width: 80.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade400,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                  ),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Center(
                                                child: Text(
                                                    qty < 0
                                                        ? "0"
                                                        : '${qty.toStringAsFixed(0)}',
                                                    style: const TextStyle(
                                                        fontFamily: 'Prompt',
                                                        fontSize: 16)),
                                              ),
                                            ),
                                          ),
                                          // -------------2
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              height: 30.0,
                                              width: 80.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                  ),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Center(
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                  controller:
                                                      incleaseCon[index],
                                                  onChanged: (value) {
                                                    if (value != '' &&
                                                        value != null) {
                                                      decleaseProductOrder(
                                                          size,
                                                          double.parse(value),
                                                          GlobalParam
                                                                  .deliveryPodtShow[
                                                              index]);
                                                    } else {
                                                      decleaseProductOrder(
                                                          size,
                                                          0,
                                                          GlobalParam
                                                                  .deliveryPodtShow[
                                                              index]);
                                                    }
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    // contentPadding: EdgeInsets.only(
                                                    //     left: 15,
                                                    //     bottom: 11,
                                                    //     top: 15,
                                                    //     right: 15),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // -------------3
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              height: 30.0,
                                              width: 80.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                  ),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Center(
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.green),
                                                  controller:
                                                      decleaseCon[index],
                                                  onChanged: (value) {
                                                    if (value != '' &&
                                                        value != null) {
                                                      incleaseProductOrder(
                                                          size,
                                                          double.parse(value),
                                                          GlobalParam
                                                                  .deliveryPodtShow[
                                                              index]);
                                                    } else {
                                                      incleaseProductOrder(
                                                          size,
                                                          0,
                                                          GlobalParam
                                                                  .deliveryPodtShow[
                                                              index]);
                                                    }
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    // contentPadding: EdgeInsets.only(
                                                    //     left: 15,
                                                    //     bottom: 11,
                                                    //     top: 15,
                                                    //     right: 15),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // ----------------------------------------------------------------4
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // height: 48,
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'Prompt',
                                              ),
                                            ),
                                          ),
                                          Container(
                                              alignment: Alignment.centerRight,
                                              width: 150.0,
                                              child: Text(
                                                'ต่อหน่วย ${formatNum.format(unitPrice)} ฿',
                                                style: const TextStyle(
                                                    fontFamily: 'Prompt',
                                                    fontSize: 12),
                                              )),
                                          const SizedBox(
                                            width: 12,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Colors.grey,
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  getProductStock(GetProductStockReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var result = await proxy.getProductStock(req);

      if (result.isNotEmpty) {
        for (int i = 0; i < result.length; i++) {
          GlobalParam.customerStockProductList.add(result[i]);
        }
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

  Widget footer() {
    double widthScreen = MediaQuery.of(context).size.width;
    List<QueryPodtResp> showData = [];
    var unitList = [];
    double productTotal = 0;

    for (var i = 0; i < orderList.length; i++) {
      if (orderList[i].cPOCD == GlobalParam.customerPOHDSelect!.cPOCD) {
        double sQty = double.parse(orderList[i].iSSIZEQTY ?? '0');
        double mQty = double.parse(orderList[i].iMSIZEQTY ?? '0');
        double lQty = double.parse(orderList[i].iLSIZEQTY ?? '0');
        double sPrice = double.parse(orderList[i].iSUNITPRICE ?? '0');
        double mPrice = double.parse(orderList[i].iMUNITPRICE ?? '0');
        double lPrice = double.parse(orderList[i].iLUNITPRICE ?? '0');
        if ((sQty + mQty + lQty) > 0) {
          showData.add(orderList[i]);
          productTotal += (sQty * sPrice) + (mQty * mPrice) + (lQty * lPrice);
          if (sQty > 0) {
            var data = {
              "cPRODCD": orderList[i].cPRODCD,
              "cUOMNM": orderList[i].cSUOMNM,
              "iPRICE": double.parse(orderList[i].iSUNITPRICE ?? '0'),
              "iTOTAL": double.parse(orderList[i].iSSIZEQTY ?? '0')
            };
            unitList.add(data);
          }
          if (mQty > 0) {
            var data = {
              "cUOMNM": orderList[i].cMUOMNM,
              "iPRICE": double.parse(orderList[i].iMUNITPRICE ?? '0'),
              "iTOTAL": double.parse(orderList[i].iMSIZEQTY ?? '0')
            };
            unitList.add(data);
          }
          if (lQty > 0) {
            var data = {
              "cUOMNM": orderList[i].cLUOMNM,
              "iPRICE": double.parse(orderList[i].iLUNITPRICE ?? '0'),
              "iTOTAL": double.parse(orderList[i].iLSIZEQTY ?? '0')
            };
            unitList.add(data);
          }
        }
      }
    }

    return Container(
      height: 136.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(children: [
        Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
              child: Row(
                children: [
                  Container(
                      width: widthScreen * 0.46,
                      height: 24,
                      child: Text(
                        '${showData.length} รายการ',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
                        ),
                      )),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'รายละเอียด',
                                style: TextStyle(
                                    fontFamily: 'Prompt', fontSize: 16),
                              ),
                              content: setupAlertDialoadContainer(
                                  unitList, widthScreen),
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
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      width: widthScreen * 0.4,
                      height: 24,
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'แสดงรายละเอียด',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 24,
            // ),
            //--------------
            Container(
              padding: const EdgeInsets.only(top: 5.0, left: 12.0, right: 12.0),
              child: Row(
                children: [
                  Container(
                    width: widthScreen * 0.4,
                    height: 24,
                    child: const Text(
                      'รวมเป็นเงิน',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: widthScreen * 0.4,
                    // height: 24,
                    alignment: Alignment.centerRight,
                    child: SubstringPrice(
                      '$productTotal',
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

            //--------------
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    addCustomerOrder();
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child: const Icon(
                              LineAwesomeIcons.boxes,
                              color: Colors.green,
                              size: 25.0,
                            )),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text(
                          'สั่งซื้อ',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                            fontFamily: 'Prompt',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 64.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CustomerAddOrder(widget.typeMenuCode, true)));
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const Icon(
                            LineAwesomeIcons.check_circle,
                            color: Colors.green,
                            size: 25.0,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text(
                          'สินค้าไม่เคยสั่งซื้อ',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.green,
                            fontFamily: 'Prompt',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        //--------------
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 64),
        //   child: SliderCard(),
        // ),
      ]),
    );
  }

  Widget setupAlertDialoadContainer(var data, double widthScreen) {
    List unitName = [];
    var listItem = [];
    for (int i = 0; i < data.length; i++) {
      unitName.add(data[i]['cUOMNM']);
    }

    var unitList = unitName.toSet().toList();

    for (int i = 0; i < unitList.length; i++) {
      int num = 0;
      double numItem = 0;
      for (int j = 0; j < data.length; j++) {
        if (unitList[i] == data[j]['cUOMNM']) {
          double total = data[j]['iTOTAL'];
          double prince = data[j]['iPRICE'];
          num++;
          numItem += total;
        }
      }
      var text = {
        "unitName": unitList[i],
        "qty": num,
        "sumItem": numItem.toStringAsFixed(0)
      };
      listItem.add(text);
    }

    return Container(
      height: data.length * 48.0, // Change as per your requirement
      width: widthScreen * 0.8, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listItem.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 48,
            child: Row(
              children: [
                Text('${listItem[index]['qty']} รายการ'),
                const Spacer(),
                Text(
                    '${listItem[index]['sumItem']} ${listItem[index]['unitName']}')
              ],
            ),
          );
        },
      ),
    );
  }

  addCustomerOrder() async {
    try {
      EasyLoading.show(status: 'loading...');
      AllApiProxyMobile proxy = AllApiProxyMobile();
      AddCustomerOrderReq req = AddCustomerOrderReq(
          cCUSTCD: GlobalParam.customer['cCUSTCD'],
          cCREABY: GlobalParam.userData.cUSRNM,
          aPRODUCT: []);

      for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
        if (GlobalParam.customerProductList[i].cPOCD ==
            GlobalParam.customerPOHDSelect!.cPOCD) {
          APRODUCT product = APRODUCT(
              cPRODCD: GlobalParam.customerProductList[i].cPRODCD,
              iSSIZEQTY: double.parse(
                  GlobalParam.customerProductList[i].iSSIZEQTY ?? '0'),
              iMSIZEQTY: double.parse(
                  GlobalParam.customerProductList[i].iMSIZEQTY ?? '0'),
              iLSIZEQTY: double.parse(
                  GlobalParam.customerProductList[i].iLSIZEQTY ?? '0'));
          req.aPRODUCT!.add(product);
        }
      }
      var result = await proxy.addCustomerOrder(req);

      if (result.success == false) {
        wrongDialog('${result.message}');
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                CustomerOrderConfirm(widget.typeMenuCode),
          ),
        );
      }

      setState(() {});
      EasyLoading.dismiss();
    } on SocketException catch (e) {
      EasyLoading.dismiss();
      wrongDialog(e.message);
    } on Exception catch (e) {
      EasyLoading.dismiss();
      wrongDialog(e.toString());
    }

    EasyLoading.dismiss();
  }

  getPodtSearch(String cPRODNM) async {
    try {
      List<QueryPodtResp> podtList = [];

      var unitList = [];
      AllApiProxyMobile proxy = AllApiProxyMobile();
      var result = await proxy.getPodt(QueryPodtReq(
          cPOCD: GlobalParam.customerPOHDSelect!.cPOCD,
          cPRODCD: '%%',
          cPRODNM: '%$cPRODNM%',
          cCUSTTYPE: GlobalParam.customer['cCUSTTYPE']));

      if (result.isNotEmpty) {
        // GlobalParam.customerProductList = [];
        // GlobalParam.customerProductList.addAll(result);
        for (int i = 0; i < result.length; i++) {
          // sumItem += double.parse(result[i].iSSIZEQTY) +
          //     double.parse(result[i].iMSIZEQTY) +
          //     double.parse(result[i].iLSIZEQTY);

          if (double.parse(result[i].iSSIZEQTY ?? '0') > 0) {
            var data = {
              "cPRODCD": result[i].cPRODCD,
              "cUOMNM": result[i].cSUOMNM,
              "iPRICE": double.parse(result[i].iSUNITPRICE ?? '0'),
              "iTOTAL": double.parse(result[i].iSSIZEQTY ?? '0')
            };
            unitList.add(data);
            QueryPodtResp product = QueryPodtResp(
              cBASKCD: result[i].cBASKCD,
              cBASKNM: result[i].cBASKNM,
              cBRNDCD: result[i].cBRNDCD,
              cBRNDNM: result[i].cBRNDNM,
              cCATECD: result[i].cCATECD,
              cCATENM: result[i].cCATENM,
              cCREABY: result[i].cCREABY,
              cDISCOUNT: result[i].cDISCOUNT,
              cINSERTYPE: result[i].cINSERTYPE,
              cLUOMCD: '',
              cLUOMNM: '',
              cMUOMCD: '',
              cMUOMNM: '',
              cPHOTOPATH: result[i].cPHOTOPATH,
              cPHOTOSERV: result[i].cPHOTOSERV,
              cPOCD: result[i].cPOCD,
              cPREPAIRSTATUS: result[i].cPREPAIRSTATUS ?? 'N',
              cPRODCD: result[i].cPRODCD,
              cPRODNM: result[i].cPRODNM,
              cPROMO: result[i].cPROMO,
              cSTATUS: result[i].cSTATUS,
              cSUBCATECD: result[i].cSUBCATECD,
              cSUBCATENM: result[i].cSUBCATENM,
              cSUOMCD: result[i].cSUOMCD,
              cSUOMNM: result[i].cSUOMNM,
              cTYPE: result[i].cTYPE,
              cTYPENM: result[i].cTYPENM,
              cUPDABY: result[i].cUPDABY,
              dCREADT: result[i].dCREADT,
              dUPDADT: result[i].dUPDADT,
              iCANCLEPRO: 0,
              iDISCOUNT: result[i].iDISCOUNT,
              iFREE: result[i].iFREE,
              iINCOMPRO: 0,
              iLOSSPRO: 0,
              iLSIZEQTY: '0.0',
              iLUNITPRICE: result[i].iLUNITPRICE,
              iMSIZEQTY: '0.0',
              iMUNITPRICE: result[i].iMUNITPRICE,
              iNETTOTAL: result[i].iNETTOTAL ?? '0',
              iPREPAIRAMOUT: result[i].iPREPAIRAMOUT ?? '0',
              iSEQ: result[i].iSEQ,
              iSSIZEQTY: result[i].iSSIZEQTY,
              iSUNITPRICE: result[i].iSUNITPRICE,
              iTOTAL:
                  "${double.parse(result[i].iSSIZEQTY ?? '0') * double.parse(result[i].iSUNITPRICE ?? '0')}",
            );

            podtList.add(product);
          }
          if (double.parse(result[i].iMSIZEQTY ?? '0') > 0) {
            var data = {
              "cUOMNM": result[i].cMUOMNM,
              "iPRICE": double.parse(result[i].iMUNITPRICE ?? '0'),
              "iTOTAL": double.parse(result[i].iMSIZEQTY ?? '0')
            };
            unitList.add(data);
            QueryPodtResp product = QueryPodtResp(
              cBASKCD: result[i].cBASKCD,
              cBASKNM: result[i].cBASKNM,
              cBRNDCD: result[i].cBRNDCD,
              cBRNDNM: result[i].cBRNDNM,
              cCATECD: result[i].cCATECD,
              cCATENM: result[i].cCATENM,
              cCREABY: result[i].cCREABY,
              cDISCOUNT: result[i].cDISCOUNT,
              cINSERTYPE: result[i].cINSERTYPE,
              cSUOMCD: '',
              cSUOMNM: '',
              cLUOMCD: '',
              cLUOMNM: '',
              cMUOMCD: result[i].cMUOMCD,
              cMUOMNM: result[i].cMUOMNM,
              cPHOTOPATH: result[i].cPHOTOPATH,
              cPHOTOSERV: result[i].cPHOTOSERV,
              cPOCD: result[i].cPOCD,
              cPREPAIRSTATUS: result[i].cPREPAIRSTATUS ?? 'N',
              cPRODCD: result[i].cPRODCD,
              cPRODNM: result[i].cPRODNM,
              cPROMO: result[i].cPROMO,
              cSTATUS: result[i].cSTATUS,
              cSUBCATECD: result[i].cSUBCATECD,
              cSUBCATENM: result[i].cSUBCATENM,
              cTYPE: result[i].cTYPE,
              cTYPENM: result[i].cTYPENM,
              cUPDABY: result[i].cUPDABY,
              dCREADT: result[i].dCREADT,
              dUPDADT: result[i].dUPDADT,
              iCANCLEPRO: 0,
              iDISCOUNT: result[i].iDISCOUNT,
              iFREE: result[i].iFREE,
              iINCOMPRO: 0,
              iLOSSPRO: 0,
              iLSIZEQTY: '0.0',
              iLUNITPRICE: result[i].iLUNITPRICE,
              iMSIZEQTY: result[i].iMSIZEQTY,
              iMUNITPRICE: result[i].iMUNITPRICE,
              iNETTOTAL: result[i].iNETTOTAL ?? '0',
              iPREPAIRAMOUT: result[i].iPREPAIRAMOUT ?? '0',
              iSEQ: result[i].iSEQ,
              iSSIZEQTY: '0.0',
              iSUNITPRICE: result[i].iSUNITPRICE,
              iTOTAL:
                  "${double.parse(result[i].iMSIZEQTY ?? '0') * double.parse(result[i].iMUNITPRICE ?? '0')}",
            );

            podtList.add(product);
          }
          if (double.parse(result[i].iLSIZEQTY ?? '0') > 0) {
            var data = {
              "cUOMNM": result[i].cLUOMNM,
              "iPRICE": double.parse(result[i].iLUNITPRICE ?? '0'),
              "iTOTAL": double.parse(result[i].iLSIZEQTY ?? '0')
            };
            unitList.add(data);
            QueryPodtResp product = QueryPodtResp(
              cBASKCD: result[i].cBASKCD,
              cBASKNM: result[i].cBASKNM,
              cBRNDCD: result[i].cBRNDCD,
              cBRNDNM: result[i].cBRNDNM,
              cCATECD: result[i].cCATECD,
              cCATENM: result[i].cCATENM,
              cCREABY: result[i].cCREABY,
              cDISCOUNT: result[i].cDISCOUNT,
              cINSERTYPE: result[i].cINSERTYPE,
              cSUOMCD: '',
              cSUOMNM: '',
              cLUOMCD: result[i].cLUOMCD,
              cLUOMNM: result[i].cLUOMNM,
              cMUOMCD: '',
              cMUOMNM: '',
              cPHOTOPATH: result[i].cPHOTOPATH,
              cPHOTOSERV: result[i].cPHOTOSERV,
              cPOCD: result[i].cPOCD,
              cPREPAIRSTATUS: result[i].cPREPAIRSTATUS ?? 'N',
              cPRODCD: result[i].cPRODCD,
              cPRODNM: result[i].cPRODNM,
              cPROMO: result[i].cPROMO,
              cSTATUS: result[i].cSTATUS,
              cSUBCATECD: result[i].cSUBCATECD,
              cSUBCATENM: result[i].cSUBCATENM,
              cTYPE: result[i].cTYPE,
              cTYPENM: result[i].cTYPENM,
              cUPDABY: result[i].cUPDABY,
              dCREADT: result[i].dCREADT,
              dUPDADT: result[i].dUPDADT,
              iCANCLEPRO: 0,
              iDISCOUNT: result[i].iDISCOUNT,
              iFREE: result[i].iFREE,
              iINCOMPRO: 0,
              iLOSSPRO: 0,
              iLSIZEQTY: result[i].iLSIZEQTY,
              iLUNITPRICE: result[i].iLUNITPRICE,
              iMSIZEQTY: '0.0',
              iMUNITPRICE: result[i].iMUNITPRICE,
              iNETTOTAL: result[i].iNETTOTAL ?? '0',
              iPREPAIRAMOUT: result[i].iPREPAIRAMOUT ?? '0',
              iSEQ: result[i].iSEQ,
              iSSIZEQTY: '0.0',
              iSUNITPRICE: result[i].iSUNITPRICE,
              iTOTAL:
                  "${double.parse(result[i].iLSIZEQTY ?? '0') * double.parse(result[i].iLUNITPRICE ?? '0')}",
            );

            podtList.add(product);
          }
        }
        GlobalParam.deliveryPodtShow = [];
        for (int i = 0; i < podtList.length; i++) {
          GlobalParam.deliveryPodtShow.add(podtList[i]);
        }
      } else {
        GlobalParam.deliveryPodtShow = [];
      }

      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  incleaseProductOrder(String size, double value, QueryPodtResp product) {
    double inclease = 0;

    if (value > 0) {
      inclease = value;
    }

    if (size == "L") {
      double sum = 0;
      for (var i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
        if (GlobalParam.deliveryPodtList[i].cPOCD ==
            GlobalParam.customerPOHDSelect!.cPOCD) {
          if (GlobalParam.deliveryPodtList[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.deliveryPodtList[i].cLUOMCD == product.cLUOMCD) {
              sum = double.parse(
                      GlobalParam.deliveryPodtList[i].iLSIZEQTY ?? '0') +
                  inclease;
            }
          }
        }
      }
      setState(() {
        if (sum < 0) {
          sum = 0;
        }
        for (var i = 0; i < orderList.length; i++) {
          if (orderList[i].cPRODCD == product.cPRODCD) {
            if (orderList[i].cLUOMCD == product.cLUOMCD) {
              orderList[i].iLSIZEQTY = '${sum.toStringAsFixed(0)}';
            }
          }
        }

        for (var i = 0; i < GlobalParam.deliveryPodtShow.length; i++) {
          if (GlobalParam.deliveryPodtShow[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.deliveryPodtShow[i].cLUOMCD == product.cLUOMCD) {
              GlobalParam.deliveryPodtShow[i].iLSIZEQTY = "$sum";
            }
          }
        }

        for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
          if (GlobalParam.customerProductList[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.customerProductList[i].cLUOMCD == product.cLUOMCD) {
              GlobalParam.customerProductList[i].iLSIZEQTY = "$sum";
            }
          }
        }
      });
    }

    if (size == "M") {
      double sum = 0;
      for (var i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
        if (GlobalParam.deliveryPodtList[i].cPOCD ==
            GlobalParam.customerPOHDSelect!.cPOCD) {
          if (GlobalParam.deliveryPodtList[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.deliveryPodtList[i].cMUOMCD == product.cMUOMCD) {
              sum = double.parse(
                      GlobalParam.deliveryPodtList[i].iMSIZEQTY ?? '0') +
                  inclease;
            }
          }
        }
      }
      setState(() {
        if (sum < 0) {
          sum = 0;
        }
        for (var i = 0; i < orderList.length; i++) {
          if (orderList[i].cPRODCD == product.cPRODCD) {
            if (orderList[i].cLUOMCD == product.cLUOMCD) {
              orderList[i].iMSIZEQTY = '${sum.toStringAsFixed(0)}';
            }
          }
        }

        for (var i = 0; i < GlobalParam.deliveryPodtShow.length; i++) {
          if (GlobalParam.deliveryPodtShow[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.deliveryPodtShow[i].cMUOMCD == product.cMUOMCD) {
              GlobalParam.deliveryPodtShow[i].iMSIZEQTY = "$sum";
            }
          }
        }

        for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
          if (GlobalParam.customerProductList[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.customerProductList[i].cMUOMCD == product.cMUOMCD) {
              GlobalParam.customerProductList[i].iMSIZEQTY = "$sum";
            }
          }
        }
      });
    }

    if (size == "S") {
      double sum = 0;
      for (var i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
        if (GlobalParam.deliveryPodtList[i].cPOCD ==
            GlobalParam.customerPOHDSelect!.cPOCD) {
          if (GlobalParam.deliveryPodtList[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.deliveryPodtList[i].cSUOMCD == product.cSUOMCD) {
              sum = double.parse(
                      GlobalParam.deliveryPodtList[i].iSSIZEQTY ?? '0') +
                  inclease;
            }
          }
        }
      }

      setState(() {
        if (sum < 0) {
          sum = 0;
        }
        for (var i = 0; i < orderList.length; i++) {
          if (orderList[i].cPRODCD == product.cPRODCD) {
            if (orderList[i].cSUOMCD == product.cSUOMCD) {
              orderList[i].iLSIZEQTY = '${sum.toStringAsFixed(0)}';
            }
          }
        }

        for (var i = 0; i < GlobalParam.deliveryPodtShow.length; i++) {
          if (GlobalParam.deliveryPodtShow[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.deliveryPodtShow[i].cSUOMCD == product.cSUOMCD) {
              GlobalParam.deliveryPodtShow[i].iSSIZEQTY = "$sum";
            }
          }
        }

        for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
          if (GlobalParam.customerProductList[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.customerProductList[i].cSUOMCD == product.cSUOMCD) {
              GlobalParam.customerProductList[i].iSSIZEQTY = "$sum";
            }
          }
        }
      });
    }
  }

  decleaseProductOrder(String size, double value, QueryPodtResp product) {
    double declease = 0;

    if (value > 0) {
      declease = value;
    }

    if (size == "L") {
      double sum = 0;
      for (var i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
        if (GlobalParam.deliveryPodtList[i].cPOCD ==
            GlobalParam.customerPOHDSelect!.cPOCD) {
          if (GlobalParam.deliveryPodtList[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.deliveryPodtList[i].cLUOMCD == product.cLUOMCD) {
              sum = double.parse(
                      GlobalParam.deliveryPodtList[i].iLSIZEQTY ?? '0') -
                  declease;
            }
          }
        }
      }
      setState(() {
        if (sum < 0) {
          sum = 0;
        }
        for (var i = 0; i < orderList.length; i++) {
          if (orderList[i].cPRODCD == product.cPRODCD) {
            if (orderList[i].cSUOMCD == product.cSUOMCD) {
              orderList[i].iLSIZEQTY = '${sum.toStringAsFixed(0)}';
            }
          }
        }

        for (var i = 0; i < GlobalParam.deliveryPodtShow.length; i++) {
          if (GlobalParam.deliveryPodtShow[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.deliveryPodtShow[i].cLUOMCD == product.cLUOMCD) {
              GlobalParam.deliveryPodtShow[i].iLSIZEQTY = "$sum";
            }
          }
        }

        for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
          if (GlobalParam.customerProductList[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.customerProductList[i].cLUOMCD == product.cLUOMCD) {
              GlobalParam.customerProductList[i].iLSIZEQTY = "$sum";
            }
          }
        }
      });
    }

    if (size == "M") {
      double sum = 0;
      for (var i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
        if (GlobalParam.deliveryPodtList[i].cPOCD ==
            GlobalParam.customerPOHDSelect!.cPOCD) {
          if (GlobalParam.deliveryPodtList[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.deliveryPodtList[i].cMUOMCD == product.cMUOMCD) {
              sum = double.parse(
                      GlobalParam.deliveryPodtList[i].iMSIZEQTY ?? '0') -
                  declease;
            }
          }
        }
      }
      setState(() {
        if (sum < 0) {
          sum = 0;
        }
        for (var i = 0; i < orderList.length; i++) {
          if (orderList[i].cPRODCD == product.cPRODCD) {
            if (orderList[i].cSUOMCD == product.cSUOMCD) {
              orderList[i].iLSIZEQTY = '${sum.toStringAsFixed(0)}';
            }
          }
        }

        for (var i = 0; i < GlobalParam.deliveryPodtShow.length; i++) {
          if (GlobalParam.deliveryPodtShow[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.deliveryPodtShow[i].cMUOMCD == product.cMUOMCD) {
              GlobalParam.deliveryPodtShow[i].iMSIZEQTY = "$sum";
            }
          }
        }

        for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
          if (GlobalParam.customerProductList[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.customerProductList[i].cMUOMCD == product.cMUOMCD) {
              GlobalParam.customerProductList[i].iMSIZEQTY = "$sum";
            }
          }
        }
      });
    }

    if (size == "S") {
      double sum = 0;
      for (var i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
        if (GlobalParam.deliveryPodtList[i].cPOCD ==
            GlobalParam.customerPOHDSelect!.cPOCD) {
          if (GlobalParam.deliveryPodtList[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.deliveryPodtList[i].cSUOMCD == product.cSUOMCD) {
              sum = double.parse(
                      GlobalParam.deliveryPodtList[i].iSSIZEQTY ?? '0') -
                  declease;
            }
          }
        }
      }
      setState(() {
        if (sum < 0) {
          sum = 0;
        }
        for (var i = 0; i < orderList.length; i++) {
          if (orderList[i].cPRODCD == product.cPRODCD) {
            if (orderList[i].cSUOMCD == product.cSUOMCD) {
              orderList[i].iLSIZEQTY = '${sum.toStringAsFixed(0)}';
            }
          }
        }

        for (var i = 0; i < GlobalParam.deliveryPodtShow.length; i++) {
          if (GlobalParam.deliveryPodtShow[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.deliveryPodtShow[i].cSUOMCD == product.cSUOMCD) {
              GlobalParam.deliveryPodtShow[i].iSSIZEQTY = "$sum";
            }
          }
        }

        for (var i = 0; i < GlobalParam.customerProductList.length; i++) {
          if (GlobalParam.customerProductList[i].cPRODCD == product.cPRODCD) {
            if (GlobalParam.customerProductList[i].cLUOMCD == product.cLUOMCD) {
              GlobalParam.customerProductList[i].iLSIZEQTY = "$sum";
            }
          }
        }
      });
    }
  }

  resetProductOrder(String size, QueryPodtResp product, int index) {
    setState(() {
      for (var i = 0; i < GlobalParam.deliveryPodtShow.length; i++) {
        if (GlobalParam.deliveryPodtShow[i].cPRODCD == product.cPRODCD) {
          if (GlobalParam.deliveryPodtShow[i].cSUOMCD == product.cSUOMCD) {
            if (size == "S") {
              GlobalParam.deliveryPodtShow[index].iSSIZEQTY = "0";
            } else if (size == "M") {
              GlobalParam.deliveryPodtShow[index].iMSIZEQTY = "0";
            } else if (size == "L") {
              GlobalParam.deliveryPodtShow[index].iLSIZEQTY = "0";
            }
          }
        }
      }
      incleaseCon[index].clear();
      decleaseCon[index].clear();
    });
  }
}
