import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/common_screen.dart/confirm_page.dart';
import 'package:vansale/function/substring_price.dart';

class CustomerTranserPayment extends StatefulWidget {
  final String typeMenuCode;
  CustomerTranserPayment(this.typeMenuCode);

  @override
  State<CustomerTranserPayment> createState() => _CustomerTranserPaymentState();
}

class _CustomerTranserPaymentState extends State<CustomerTranserPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'รับชำระโอน',
          style: TextStyle(
            color: Colors.black,
            //color: Color.fromRGBO(0, 157, 181, 5),
            fontFamily: 'Prompt',
            fontSize: 18.0,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Icon(
                    LineAwesomeIcons.print,
                    color: Colors.black54,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Icon(
                    LineAwesomeIcons.vertical_ellipsis,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                height: 50.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '07/09/64',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black54,
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
                                          'No 640907-xxxxx',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black38,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DottedLine(
                                lineThickness: 2.0,
                                dashColor: Colors.black38,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                //color: HexColor("#F2F3F4"),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Container(
                                          //color: Colors.amber,
                                          width: 70.0,
                                          height: 70.0,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey,
                                            image: DecorationImage(
                                              image: new AssetImage(
                                                'assets/images/brandon.png',
                                              ),
                                              scale: 1.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                            top: 5.0,
                                            right: 5.0,
                                            bottom: 5.0,
                                            left: 10.0,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'ชื่อร้านค้า',
                                                  style: TextStyle(
                                                    fontFamily: 'Prompt',
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'ที่อยู่',
                                                  style: TextStyle(
                                                    fontFamily: 'Prompt',
                                                    color: Colors.grey,
                                                    //fontWeight: FontWeight.bold,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      child: Icon(
                                                        LineAwesomeIcons.boxes,
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '32 รายการ',
                                                        style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          color: Colors.black54,
                                                          //fontWeight: FontWeight.bold,
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '32 ตระกร้า',
                                                        style: TextStyle(
                                                          fontFamily: 'Prompt',
                                                          color: Colors.black54,
                                                          //fontWeight: FontWeight.bold,
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'No 640907-xxxxx',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black38,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: 'Prompt',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'ยอดค้างชำระ',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black38,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: SubstringPrice(
                                          '200.00',
                                          14.0,
                                          14.0,
                                          Colors.black38,
                                          Colors.black38,
                                          'Prompt',
                                          'Prompt',
                                          FontWeight.normal,
                                          FontWeight.normal,
                                          'บาท',
                                          14.0,
                                          Colors.black38,
                                          'Prompt',
                                          FontWeight.normal,
                                          FontStyle.normal,
                                          FontStyle.normal,
                                          FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'ส่วนลดท้ายบิล',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black38,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: SubstringPrice(
                                          '50.00',
                                          14.0,
                                          14.0,
                                          Colors.black38,
                                          Colors.black38,
                                          'Prompt',
                                          'Prompt',
                                          FontWeight.normal,
                                          FontWeight.normal,
                                          'บาท',
                                          14.0,
                                          Colors.black38,
                                          'Prompt',
                                          FontWeight.normal,
                                          FontStyle.normal,
                                          FontStyle.normal,
                                          FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'ยอดปัจจุบัน',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black38,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: SubstringPrice(
                                          '3000.00',
                                          14.0,
                                          14.0,
                                          Colors.black38,
                                          Colors.black38,
                                          'Prompt',
                                          'Prompt',
                                          FontWeight.normal,
                                          FontWeight.normal,
                                          'บาท',
                                          14.0,
                                          Colors.black38,
                                          'Prompt',
                                          FontWeight.normal,
                                          FontStyle.normal,
                                          FontStyle.normal,
                                          FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'รวมทั้งหมด',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black38,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: SubstringPrice(
                                          '3100.00',
                                          16.0,
                                          14.0,
                                          Colors.orange,
                                          Colors.orange,
                                          'Prompt',
                                          'Prompt',
                                          FontWeight.bold,
                                          FontWeight.bold,
                                          'THB',
                                          14.0,
                                          Colors.black38,
                                          'Prompt',
                                          FontWeight.bold,
                                          FontStyle.normal,
                                          FontStyle.normal,
                                          FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //--------QR Image-----------------
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Container(
                                height: 150.0,
                                width: 150.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: new AssetImage(
                                      'assets/images/qr.png',
                                    ),
                                    scale: 1.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //------กรอกยอดชำระ----------
                        Container(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 100.0,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'กรอกยอดชำระ',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black38,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: 'Prompt',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  alignment: Alignment.centerLeft,
                                  height: 45.0,
                                  /*decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.grey),
                                  ),*/
                                  child: Theme(
                                    data: new ThemeData(
                                      primaryColor: Colors.green,
                                      //primaryColorDark: Colors.grey,
                                    ),
                                    child: new TextFormField(
                                      maxLength: 15,
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.green,
                                      style: TextStyle(color: Colors.black),
                                      decoration: new InputDecoration(
                                        border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey),
                                        ),
                                        counterText: "",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //-----------------
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'จำนวนที่ชำระ',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38,
                                      //fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: SubstringPrice(
                                    '3000.00',
                                    14.0,
                                    12.0,
                                    Colors.green,
                                    Colors.green,
                                    'Prompt',
                                    'Prompt',
                                    FontWeight.bold,
                                    FontWeight.bold,
                                    '฿',
                                    12.0,
                                    Colors.green,
                                    'Prompt',
                                    FontWeight.bold,
                                    FontStyle.normal,
                                    FontStyle.normal,
                                    FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //--------------
                        Container(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'ยอดที่ต้องชำระ',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38,
                                      //fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: SubstringPrice(
                                    '3100.00',
                                    14.0,
                                    12.0,
                                    Colors.red,
                                    Colors.red,
                                    'Prompt',
                                    'Prompt',
                                    FontWeight.bold,
                                    FontWeight.bold,
                                    '฿',
                                    12.0,
                                    Colors.red,
                                    'Prompt',
                                    FontWeight.bold,
                                    FontStyle.normal,
                                    FontStyle.normal,
                                    FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //--------------
                        Container(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'รวมเป็นเงิน',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38,
                                      //fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: SubstringPrice(
                                    '100.00',
                                    14.0,
                                    12.0,
                                    Colors.orange,
                                    Colors.orange,
                                    'Prompt',
                                    'Prompt',
                                    FontWeight.bold,
                                    FontWeight.bold,
                                    '฿',
                                    12.0,
                                    Colors.orange,
                                    'Prompt',
                                    FontWeight.bold,
                                    FontStyle.normal,
                                    FontStyle.normal,
                                    FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //--------------
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //---------bottom บันทึการชำระ-------
            Card(
              elevation: 0.0,
              child: Container(
                alignment: Alignment.center,
                height: 80.0,
                //width: 200.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ConfirmPage(
                            widget.typeMenuCode, "รับชำระ", "เรียบร้อยแล้ว"),
                      ),
                    );
                  },
                  child: Container(
                    //width: 180.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Icon(
                            LineAwesomeIcons.check_circle,
                            color: Colors.green,
                            size: 25.0,
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'บันทึกการชำระ',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.green,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
