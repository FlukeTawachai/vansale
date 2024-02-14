import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/ic_vp_icons.dart';
import 'package:vansale/screens/Supplier/delivery/money/delivery_money_detail.dart';
import 'package:vansale/screens/Supplier/delivery/money/delivery_money_main_list.dart';
import 'package:vansale/screens/Supplier/delivery/money/delivery_money_new.dart';
class MoneyMain extends StatefulWidget {
  final String typeMenuCode;
  MoneyMain(this.typeMenuCode);

  @override
  State<MoneyMain> createState() => _MoneyMainState();
}

class _MoneyMainState extends State<MoneyMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ส่งเงิน'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MoneyNew(widget.typeMenuCode),
                  ),
                );
              },
              icon: Icon(Icvp.ellipsis_v_solid))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
        ),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  _date(),
                  _no(),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            DottedLine(
              dashColor: Colors.grey,
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text('ยอดขายทั้งหมด'),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: _totalPrice(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text('ค่าน้ำมัน'),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: _totalPriceRefuel(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            DottedLine(
              dashColor: Colors.grey,
            ),
            Expanded(
              child: Container(
                color: HexColor("#F2F3F4"),
                child: MoneyMainList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _btnSave(),
    );
  }

  Widget _date() {
    return Expanded(
      child: Container(
        child: Text(
          '08/05/65',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _no() {
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          'No.08-05-65 08:00',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _totalPriceRefuel() {
    return Utility.formateNumberOR18(500.00, 18.00);
  }

  Widget _totalPrice() {
    return Utility.formateNumberGN18(3200.00, 18.00);
  }

  Widget _btnSave() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: 140.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
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
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          'รวมเงินที่ต้องส่ง',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Utility.formateNumberGNSym(3200.00),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MoneyDetail(widget.typeMenuCode),
                    ),
                  );
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icvp.dollar_sign_solid,
                          size: 25.0,
                          color: HexColor('#00cb39'),
                        ),
                        /*child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(30 / 360),
                          
                        ),*/
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        //alignment: Alignment.centerLeft,
                        child: Text(
                          'ยืนยันการส่งเงิน',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor('#00cb39'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   child: Divider(
              //     height: 5.0,
              //     indent: 105.0,
              //     endIndent: 100.0,
              //     thickness: 2.0,
              //     color: HexColor('#00cb39'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
