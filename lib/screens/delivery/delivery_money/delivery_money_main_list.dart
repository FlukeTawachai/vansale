import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/utility.dart';

class DeliveryMoneyMainList extends StatefulWidget {
  @override
  State<DeliveryMoneyMainList> createState() => _DeliveryMoneyMainListState();
}

class _DeliveryMoneyMainListState extends State<DeliveryMoneyMainList> {
  var details = [
    {
      'code': "650508-0001",
      'name': "รับเงินสดจาก",
      'price': "400.00",
      'type': "1",
      'createdate': "08-05-65 08:00",
    },
    {
      'code': "650508-0002",
      'name': "จ่ายค่าใช้จ่ายเรื่อง",
      'price': "400.00",
      'type': "2",
      'createdate': "08-05-65 08:00",
    },
  ];
  Utility utility = Utility();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return GlobalParam.deliveryAddSendMoney.iCOST != 0 
              
            ? Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 5.0,
                  top: 10.0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // _price(index),
                        Utility.formateNumberGN18(
                          GlobalParam.deliveryAddSendMoney.iCOST,
                          14.0,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _name(index),
                              _code(index),
                              // _createDate(index),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    DottedLine(
                      dashColor: Colors.grey,
                    ),
                  ],
                ),
              )
            : Container();
      },
    );
  }

  Widget _price(index) {
    Widget result;
    switch (details[index]['type']) {
      case "1":
        result = Utility.formateNumberOR18(
            double.parse(details[index]['price']), 14.0);
        break;
      case "2":
        result = Utility.formateNumberGN18(
          double.parse(details[index]['price']),
          14.0,
        );
        break;
    }
    return result;
  }

  Widget _name(index) {
    return Container(
      child: Text(GlobalParam.deliveryAddSendMoney.cCOSNM),
    );
  }

  Widget _code(index) {
    return Container(
      child: Text(
        GlobalParam.deliveryAddSendMoney.cREMARK,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 10.0,
        ),
      ),
    );
  }

  Widget _createDate(index) {
    return Container(
      child: Text(
        details[index]['createdate'],
        style: TextStyle(
          color: Colors.grey,
          fontSize: 10.0,
        ),
      ),
    );
  }
}
