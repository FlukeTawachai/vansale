import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vansale/list_all.dart/lst_shipping_return.dart';

class ShippingListReturn extends StatefulWidget {
  //const ShippingListReturn({ Key? key }) : super(key: key);

  @override
  _ShippingListReturnState createState() => _ShippingListReturnState();
}

class _ShippingListReturnState extends State<ShippingListReturn> {
  String poDate = DateFormat('dd-MM-yy').format(DateTime.now());
  String poNo = "No. 632606-00xx";

  yearThai() {
    var _podate = poDate.split('-');
    var _day = _podate[0];
    var _month = _podate[1];
    var _year = _podate[2];
    int cal = int.parse(_year) + 43;
    String poDatethai = _day + '/' + _month + '/' + cal.toString();
    return poDatethai;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: ListShippingReturn(),
            ),
          ),
          Container(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.white,
                /*borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),*/
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150.0,
                      alignment: Alignment.centerRight,
                      child: Icon(
                        LineAwesomeIcons.check_circle,
                        color: Colors.green,
                        size: 25.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'บันทึกรับคืนสินค้า',
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
