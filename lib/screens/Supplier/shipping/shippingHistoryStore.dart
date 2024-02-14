
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class StoreHistory extends StatefulWidget {
  const StoreHistory({ Key key }) : super(key: key);

  @override
  State<StoreHistory> createState() => _StoreHistoryState();
}

class _StoreHistoryState extends State<StoreHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          left: 10.0,
        ),
        alignment: Alignment.centerLeft,
        color: HexColor("#F2F3F4"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 30.0,
                    child: Icon(
                      LineAwesomeIcons.user_check,
                      size: 35.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ประวัติ',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'เยี่ยมครั้งสุดท้าย',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),

                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '12 ต.ค. 2563 13.10 น.',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.blue,
                          //fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'สั่งครั้งสุดท้าย',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '10 ต.ค. 2563 16.10 น.',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.blue,
                          //fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'เลขบิลครั้งสุดท้าย',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 60.0,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Q-3102',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.blue,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'ยอดสั่งซื้อ',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.green,
                          //fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 60.0,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${NumberFormat("#,###", "en_US").format(int.parse('20000'))}',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.blue,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
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