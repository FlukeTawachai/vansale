import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/getSaleStoreOrderResp.dart';
import 'package:vansale/api/class/response/routeMobile/pohdAndPodtResp.dart';
import 'package:vansale/screens/Supplier/PayForBasketReturn/pay_components.dart';
import 'package:vansale/screens/Supplier/PayForBasketReturn/storeName_for_basketReturn.dart';
import 'package:vansale/screens/sale/survey/sale_storeDetail.dart';

class SupPayBasketReturn extends StatefulWidget {
  final GetSaleStoreOrderResp? store;
  final PoHDAndPoDTResp? poHDAndPoDTResp;
  const SupPayBasketReturn({Key? key, this.store, this.poHDAndPoDTResp})
      : super(key: key);
  @override
  _SupPayBasketReturnState createState() => _SupPayBasketReturnState();
}

class _SupPayBasketReturnState extends State<SupPayBasketReturn> {
  String poDate = DateFormat('dd-MM-yy').format(DateTime.now());
  bool isSale = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var data = widget.poHDAndPoDTResp;
    if (data!.cPOCD != "" &&
        data.cCUSTCD != "" &&
        data.cPOCD != null &&
        data.cCUSTCD != null) {
      getBaskets();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(57, 203, 91, 1.0),
        centerTitle: true,
        title: Text(
          'รับชำระ',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() async {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SaleStoreHome(
                      GlobalParam.deliverySelectStore.cCUSTNM!,
                      GlobalParam.typeMenuCode!,
                      widget.store!)));
            });
          },
        ),
        // actions: [
        //   Row(
        //     children: [
        //       Container(
        //         child: IconButton(
        //           icon: Icon(
        //             Icons.print,
        //             color: Colors.black,
        //           ),
        //           onPressed: () {
        //             setState(
        //               () {
        //                 Navigator.of(context).pop();
        //               },
        //             );
        //           },
        //         ),
        //       ),
        //       Container(
        //         child: IconButton(
        //           icon: Icon(
        //             Icons.more_vert,
        //             color: Colors.black,
        //           ),
        //           onPressed: () {
        //             setState(
        //               () {
        //                 Navigator.of(context).pop(
        //                   MaterialPageRoute(
        //                     builder: (context) => SendMoney(),
        //                   ),
        //                 );
        //               },
        //             );
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
      ),
      body: Container(
        //alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              width: 414.0,
              height: 240.0,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: 350,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: label1(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DottedLine(
                            dashColor: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Details_Main_BasketReturn(
                              IsSale: isSale,
                            ),
                          ),
                          Container(
                            child: Details_Main_BasketReturn_Pay(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: PayBody(),
              ),
            ),
            // Container(
            //   child: savebutton(),
            // ),
          ],
        ),
      ),
    );
  }

  yearThai() {
    var _podate = poDate.split('-');
    var _day = _podate[0];
    var _month = _podate[1];
    var _year = _podate[2];
    int cal = int.parse(_year) + 43;
    String poDatethai = _day + '/' + _month + '/' + cal.toString();
    return poDatethai;
  }

  Widget _dateHD() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        yearThai(),
        style: TextStyle(
          fontFamily: 'Prompt',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget label1() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dateHD(),
          Container(
            child: GlobalParam.PoHDAndPoDT.isEmpty == true
                ? Text(
                    '',
                    style: TextStyle(
                      color: Color.fromRGBO(130, 145, 169, 1),
                      fontFamily: 'Prompt',
                      fontSize: 16,
                    ),
                  )
                : Text(
                    GlobalParam.PoHDAndPoDT[0].cPOCD!,
                    style: TextStyle(
                      color: Color.fromRGBO(130, 145, 169, 1),
                      fontFamily: 'Prompt',
                      fontSize: 16,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget savebutton() {
    return Container(
      color: Colors.white,
      height: 85.0,
      child: Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40.0,
                width: 190,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: HexColor('#00cb39'),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      //alignment: Alignment.centerRight,
                      child: Icon(
                        FontAwesomeIcons.checkCircle,
                        size: 20.0,
                        color: HexColor('#00cb39'),
                      ),
                    ),
                    Container(
                      //alignment: Alignment.centerLeft,
                      child: Text(
                        ' บันทึกการชำระสินค้า',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: HexColor('#00cb39'),
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
      ),
    );
  }

  getBaskets() async {
    try {
      EasyLoading.show();
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.getBaskets(widget.poHDAndPoDTResp!.cCUSTCD!,
          widget.poHDAndPoDTResp!.cPOCD!, "%%", "%%");

      if (result.isNotEmpty == true) {
        GlobalParam.PoHDAndPoDT = [];
        GlobalParam.PoHDAndPoDT = result;
        var newData = PoHDAndPoDTResp(
            cCUSTCD: widget.poHDAndPoDTResp!.cCUSTCD,
            cPOCD: widget.poHDAndPoDTResp!.cPOCD);
        double iitems = 0;
        double ibasket = 0;
        for (var i = 0; i < result.length; i++) {
          iitems += double.parse(result[i].iitems!);
          ibasket += double.parse(result[i].ibasket!);
        }
        newData.iitems = iitems.toStringAsFixed(2);
        newData.ibasket = ibasket.toStringAsFixed(2);
        GlobalParam.deliveryStoreSum.cCUSTCD = newData.cCUSTCD;
        GlobalParam.deliveryStoreSum.cPRODCD = newData.cPRODCD;
        GlobalParam.deliveryStoreSum.iitems = newData.iitems;
        GlobalParam.deliveryStoreSum.ibasket = newData.ibasket;
        setState(() {
          isSale = true;
        });
      }
      EasyLoading.dismiss();
      setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  wrongDialog(String msg) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('แจ้งเตือน'),
        content: Text(
          msg,
          style: const TextStyle(fontSize: 16.0),
        ),
        actions: <Widget>[
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.8,
          ),
          Container(
            height: 50.0,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      'ตกลง',
                    );
                  },
                  child: const Text(
                    'ตกลง',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
