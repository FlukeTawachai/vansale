import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/common_screen.dart/confirm_page.dart';
import 'package:vansale/ic_vp_icons.dart';

class MoneyDetail extends StatefulWidget {
  final String typeMenuCode;
  MoneyDetail(this.typeMenuCode);

  @override
  State<MoneyDetail> createState() => _MoneyDetailState();
}

class _MoneyDetailState extends State<MoneyDetail> {
  TextEditingController price = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ส่งเงิน - บันทึกรายละเอียดเงินสด'),
      ),
      body: ListView(
        children: [
          _totalPrice(),
          _totaltransfer(),
          _cheque(),
          _bankNo(),
          _bankName(),
          _price(),
          _bill1000(),
          _bill500(),
          _bill100(),
          _bill50(),
          _bill20(),
        ],
      ),
      bottomNavigationBar: _btnSave(),
    );
  }

  Widget _totalPrice() {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 5.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'รวมเงินสดที่ต้องส่ง',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 5.0),
              alignment: Alignment.centerLeft,
              child: Utility.formateNumberGNSym(2000.00),
            ),
          ),
        ],
      ),
    );
  }

  Widget _totaltransfer() {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 5.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'เงินโอน',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 5.0),
              alignment: Alignment.centerLeft,
              child: Utility.formateNumberGN18(0, 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cheque() {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 5.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'เช็ค',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 5.0),
              alignment: Alignment.centerLeft,
              child: Utility.formateNumberGN18(0, 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bankNo() {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 5.0),
              alignment: Alignment.center,
              child: Text(
                'บัญชีที่ต้องโอน TMB 405-603-xxxx',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bankName() {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 5.0),
              alignment: Alignment.center,
              child: Text(
                'ชื่อบัญชี บริษัท xxxxxxxx',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _price() {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 130.0,
            padding: const EdgeInsets.only(right: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'จำนวนเงินที่ฝาก',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 40),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey,
                ),
                controller: price,
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
                ),
              ),
            ),
          ),
          Container(
            width: 30.0,
            padding: const EdgeInsets.only(left: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'บาท',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bill1000() {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 130.0,
            padding: const EdgeInsets.only(right: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'ธนบัตร 1000 บาท',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 40),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey,
                ),
                controller: price,
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
                ),
              ),
            ),
          ),
          Container(
            width: 30.0,
            padding: const EdgeInsets.only(left: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'ใบ',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bill500() {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 130.0,
            padding: const EdgeInsets.only(right: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'ธนบัตร 500 บาท',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 40),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey,
                ),
                controller: price,
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
                ),
              ),
            ),
          ),
          Container(
            width: 30.0,
            padding: const EdgeInsets.only(left: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'ใบ',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bill100() {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 130.0,
            padding: const EdgeInsets.only(right: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'ธนบัตร 100 บาท',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 40),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey,
                ),
                controller: price,
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
                ),
              ),
            ),
          ),
          Container(
            width: 30.0,
            padding: const EdgeInsets.only(left: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'ใบ',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bill50() {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 130.0,
            padding: const EdgeInsets.only(right: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'ธนบัตร 50 บาท',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 40),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey,
                ),
                controller: price,
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
                ),
              ),
            ),
          ),
          Container(
            width: 30.0,
            padding: const EdgeInsets.only(left: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'ใบ',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bill20() {
    return Container(
      margin: const EdgeInsets.only(
          left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 130.0,
            padding: const EdgeInsets.only(right: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'ธนบัตร 20 บาท',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 40),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey,
                ),
                controller: price,
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 15, right: 15),
                ),
              ),
            ),
          ),
          Container(
            width: 30.0,
            padding: const EdgeInsets.only(left: 5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'ใบ',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnSave() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: 80.0,
      color: Colors.white,
      /*decoration: BoxDecoration(
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
      ),*/
      child: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ConfirmPage(
                          'T002', 'บันทึกการส่งเงิน', 'เรียบร้อยแล้ว'),
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
                          Icvp.check_circle_solid,
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
