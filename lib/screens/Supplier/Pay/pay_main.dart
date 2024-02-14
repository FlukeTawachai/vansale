import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/class/globalparam.dart';

import 'package:vansale/screens/Supplier/Pay/pay_components.dart';
import 'package:vansale/screens/SendMoney/main_SendMoney.dart';

import 'storeName.dart';

class SupPay extends StatefulWidget {
  @override
  _SupPayState createState() => _SupPayState();
}

class _SupPayState extends State<SupPay> {
  String poDate = DateFormat('dd-MM-yy').format(DateTime.now());
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
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       Navigator.of(context).pop();
        //     });
        //   },
        // ),
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
                            child: Details_Main(),
                          ),
                          Container(
                            child: Details_Main_Pay(),
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
            child: Text(
              GlobalParam.deliveryPodtList[0].cPOCD,
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
}
