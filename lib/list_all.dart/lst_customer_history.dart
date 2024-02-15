import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/customer/re-order.dart';

class ListCustomerHistory extends StatefulWidget {
  //const ListCustomerHistory({ Key? key }) : super(key: key);
  final String typeMenuCode;
  ListCustomerHistory(this.typeMenuCode);
  @override
  _ListCustomerHistoryState createState() => _ListCustomerHistoryState();
}

class _ListCustomerHistoryState extends State<ListCustomerHistory> {
  var history = [
    {
      'billno': "0001",
      'status': "ส่งแล้ว",
      'date': "22 ก.ย. 63",
      'group': "(วันจันทร์)",
      'price': "3200.00",
      'unit': "บาท",
    },
    {
      'billno': "0002",
      'status': "ส่งแล้ว",
      'date': "22 ก.ย. 63",
      'group': "(วันจันทร์)",
      'price': "3200.00",
      'unit': "บาท",
    },
    {
      'billno': "0003",
      'status': "ส่งแล้ว",
      'date': "22 ก.ย. 63",
      'group': "(วันจันทร์)",
      'price': "3200.00",
      'unit': "บาท",
    },
    {
      'billno': "0004",
      'status': "ส่งแล้ว",
      'date': "22 ก.ย. 63",
      'group': "(วันจันทร์)",
      'price': "3200.00",
      'unit': "บาท",
    },
    {
      'billno': "0005",
      'status': "ส่งแล้ว",
      'date': "22 ก.ย. 63",
      'group': "(วันจันทร์)",
      'price': "3200.00",
      'unit': "บาท",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Reorder(widget.typeMenuCode),
                      ),
                    );
                  },
                  child: Container(
                    height: 100.0,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'วันที่บิล',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        //fontWeight: FontWeight.bold,
                                        fontFamily: 'Prompt',
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'สถานะ',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.green,
                                        //fontWeight: FontWeight.bold,
                                        fontFamily: 'Prompt',
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'ยอดเงิน',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.green,
                                        //fontWeight: FontWeight.bold,
                                        fontFamily: 'Prompt',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //------------------------
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      history[index]['date']! +
                                          " " +
                                          history[index]['group']!,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        //fontWeight: FontWeight.bold,
                                        fontFamily: 'Prompt',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    history[index]['status']!,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      //fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      child: SubstringPrice(
                                        history[index]['price'].toString(),
                                        16.0,
                                        12.0,
                                        Colors.orange,
                                        Colors.orange,
                                        'Prompt',
                                        'Prompt',
                                        FontWeight.bold,
                                        FontWeight.bold,
                                        'บาท',
                                        12.0,
                                        Colors.black,
                                        'Prompt',
                                        FontWeight.bold,
                                        FontStyle.normal,
                                        FontStyle.normal,
                                        FontStyle.normal,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //----เส้นประ---------
              DottedLine(
                lineThickness: 2.0,
                dashColor: Colors.grey,
              ),
            ],
          ),
        );
      },
    );
  }
}
