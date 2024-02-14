import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/common_screen.dart/appbar.dart';

class ListRefuel extends StatefulWidget {
  //const ListRefuel({ Key? key }) : super(key: key);
  final String typeMenuCode;
  ListRefuel(this.typeMenuCode);
  @override
  _ListRefuelState createState() => _ListRefuelState();
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
      padding: const EdgeInsets.all(5),
      itemCount: refuels.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AppbarPage(7.toString(), widget.typeMenuCode),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  height: 80.0,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        alignment: Alignment.centerRight,
                        width: 80.0,
                        child: Icon(
                          LineAwesomeIcons.gas_pump,
                          color: Colors.green,
                          size: 40.0,
                        ),
                      ),
                      Expanded(
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
                      ),
                      Expanded(
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
                                      child: substring(refuels[index]['price']),
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
                      ),
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

  substring(String a) {
    var stotal = a.split('.');
    var bb = '';
    var cc = '';
    bb = stotal[0];
    cc = stotal[1];
    var aa = RichText(
      text: TextSpan(
        text: '$bb',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Prompt',
        ),
        children: <TextSpan>[
          TextSpan(
            text: '.',
          ),
          TextSpan(
            text: '$cc',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
        ],
      ),
    );
    return aa;
  }
}
