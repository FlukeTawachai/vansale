import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:vansale/api/class/utility.dart';

class MoneyMainList extends StatefulWidget {
  @override
  State<MoneyMainList> createState() => _MoneyMainListState();
}

class _MoneyMainListState extends State<MoneyMainList> {
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: details.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
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
                  _price(index),
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
                        _createDate(index),
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
        );
      },
    );
  }

  Widget _price(index) {
    Widget result =Utility.formateNumberOR18(
            double.parse(details[index]['price']!), 14.0);
    switch (details[index]['type']) {
      case "1":
        result = Utility.formateNumberOR18(
            double.parse(details[index]['price']!), 14.0);
        break;
      case "2":
        result = Utility.formateNumberGN18(
          double.parse(details[index]['price']!),
          14.0,
        );
        break;
    }
    return result;
  }

  Widget _name(index) {
    return Container(
      child: Text(details[index]['name']!),
    );
  }

  Widget _code(index) {
    return Container(
      child: Text(
        'No. ${details[index]['code']}',
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
        details[index]['createdate']!,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 10.0,
        ),
      ),
    );
  }
}
