import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/Supplier/delivery/refuel/delivery_refuel_lst_detail.dart';

class ListRefuel extends StatefulWidget {
  const ListRefuel({Key key}) : super(key: key);

  @override
  State<ListRefuel> createState() => _ListRefuelState();
}

class _ListRefuelState extends State<ListRefuel> {
  var refuels = [
    {
      "name": "ดีเซล",
      "total": "40 ลิตร",
      "date": "29 กย 2563",
      "price": "800.00",
      "unit": "THB"
    },
    {
      "name": "ดีเซล",
      "total": "40 ลิตร",
      "date": "29 กย 2563",
      "price": "800.00",
      "unit": "THB"
    },
    {
      "name": "ดีเซล",
      "total": "40 ลิตร",
      "date": "29 กย 2563",
      "price": "800.00",
      "unit": "THB"
    },
    {
      "name": "ดีเซล",
      "total": "40 ลิตร",
      "date": "29 กย 2563",
      "price": "800.00",
      "unit": "THB"
    },
    {
      "name": "ดีเซล",
      "total": "40 ลิตร",
      "date": "29 กย 2563",
      "price": "800.00",
      "unit": "THB"
    },
    {
      "name": "ดีเซล",
      "total": "40 ลิตร",
      "date": "29 กย 2563",
      "price": "800.00",
      "unit": "THB"
    },
    {
      "name": "ดีเซล",
      "total": "40 ลิตร",
      "date": "29 กย 2563",
      "price": "800.00",
      "unit": "THB"
    },
    {
      "name": "ดีเซล",
      "total": "40 ลิตร",
      "date": "29 กย 2563",
      "price": "800.00",
      "unit": "THB"
    },
    {
      "name": "ดีเซล",
      "total": "40 ลิตร",
      "date": "29 กย 2563",
      "price": "800.00",
      "unit": "THB"
    },
    {
      "name": "ดีเซล",
      "total": "40 ลิตร",
      "date": "29 กย 2563",
      "price": "800.00",
      "unit": "THB"
    },
    {
      "name": "ดีเซล",
      "total": "40 ลิตร",
      "date": "29 กย 2563",
      "price": "800.00",
      "unit": "THB"
    },
    {
      "name": "ดีเซล",
      "total": "40 ลิตร",
      "date": "29 กย 2563",
      "price": "800.00",
      "unit": "THB"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      itemCount: refuels.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => RefuelListDetail(),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  height: 80.0,
                  child: Row(
                    children: [
                      iconItem_(),
                      nameTotal_(index),
                      dateUnit_(index),
                    ],
                  ),
                ),
                Container(
                  child: DottedLine(
                    dashColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget iconItem_() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      alignment: Alignment.centerRight,
      width: 80.0,
      child: Icon(
        LineAwesomeIcons.gas_pump,
        color: Colors.green,
        size: 40.0,
      ),
    );
  }

  Widget nameTotal_(index) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                refuels[index]['name'],
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              child: Text(
                refuels[index]['total'],
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateUnit_(index) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                refuels[index]['date'],
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Utility.formateNumberBK(
                        double.parse(refuels[index]['price'])),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    child: Text(
                      refuels[index]['unit'],
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
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
    );
  }
}
