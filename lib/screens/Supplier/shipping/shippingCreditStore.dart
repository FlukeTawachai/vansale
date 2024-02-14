
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class StoreCredit extends StatefulWidget {
  const StoreCredit({ Key? key }) : super(key: key);

  @override
  State<StoreCredit> createState() => _StoreCreditState();
}

class _StoreCreditState extends State<StoreCredit> {
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
                      LineAwesomeIcons.donate,
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
                      'เครดิต',
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
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 50.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ยอดค้าง',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.red,
                          //fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${NumberFormat("#,###", "en_US").format(int.parse('12000'))}',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.red,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'บาท',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.red,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
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
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 50.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'วงเงินเครดิต',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.grey,
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${NumberFormat("#,###", "en_US").format(int.parse('10000'))}',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.grey,
                        //fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text(
                      'บาท',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.grey,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
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
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 50.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'วงเงินคงเหลือ',
                        style: TextStyle(
                          fontFamily: 'Prompt',
                          color: Colors.green,
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${NumberFormat("#,###", "en_US").format(int.parse('8100'))}',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'บาท',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
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