import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/delivery/historyDetail.dart';

class DeliveryHistoryCard extends StatelessWidget {
  final String typeMenuCode;
  final String billno;
  final String status;
  final String date;
  final String group;
  final String price;
  final String unit;
  const DeliveryHistoryCard({
    Key key,
    this.typeMenuCode,
    this.billno,
    this.status,
    this.date,
    this.group,
    this.price,
    this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12,5,12,5),
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
                    builder: (BuildContext context) => HistoryDetail(typeMenuCode),
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
                                  date +
                                      " " +
                                      group,
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
                                status,
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
                                    price.toString(),
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
          DottedLine(
            lineThickness: 2.0,
            dashColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
