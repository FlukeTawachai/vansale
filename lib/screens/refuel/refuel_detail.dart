import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/common_screen.dart/appbar.dart';

class RefuelDetail extends StatefulWidget {
  //const RefuelDetail({ Key? key }) : super(key: key);
  final String typeMenuCode;
  RefuelDetail(this.typeMenuCode);
  @override
  _RefuelDetailState createState() => _RefuelDetailState();
}

class _RefuelDetailState extends State<RefuelDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 180.0,
              margin: const EdgeInsets.all(20.0),
              child: Image.asset('assets/images/pt.png'),
              //StoreImgList(),
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                width: 30.0,
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  LineAwesomeIcons.map_marker,
                                  color: Colors.grey,
                                  size: 25.0,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '123 แขวง/ตำบล เขต/อำเภอ จังหวัด ',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 100.0,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(150),
                                    border: new Border.all(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                    /*boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],*/
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      icon: const Icon(
                                          LineAwesomeIcons.map_marked),
                                      iconSize: 20.0,
                                      color: Colors.green,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                AppbarPage(4.toString(),
                                                    widget.typeMenuCode),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //-----------------
                        Container(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: DottedLine(
                            dashColor: Colors.grey,
                          ),
                        ),
                        //-----------------
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Container(
                                width: 30.0,
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  LineAwesomeIcons.calendar,
                                  color: Colors.grey,
                                  size: 25.0,
                                ),
                              ),
                              Container(
                                width: 100.0,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'วันที่',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Prompt',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '27 กย. 2563',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //-----------------
                        Container(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: DottedLine(
                            dashColor: Colors.grey,
                          ),
                        ),
                        //-----------------
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Container(
                                width: 30.0,
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  LineAwesomeIcons.gas_pump,
                                  color: Colors.grey,
                                  size: 25.0,
                                ),
                              ),
                              Container(
                                width: 100.0,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'สถานที่เติม',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Prompt',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'บีที หาดใหญ่',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //-----------------
                        Container(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: DottedLine(
                            dashColor: Colors.grey,
                          ),
                        ),
                        //-----------------
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Container(
                                width: 30.0,
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  LineAwesomeIcons.oil_can,
                                  color: Colors.grey,
                                  size: 25.0,
                                ),
                              ),
                              Container(
                                width: 100.0,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'เชื้อเพลง',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Prompt',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'ดีเซล',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //-----------------
                        Container(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: DottedLine(
                            dashColor: Colors.grey,
                          ),
                        ),
                        //-----------------
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Container(
                                width: 30.0,
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  LineAwesomeIcons.alternate_tachometer,
                                  color: Colors.grey,
                                  size: 25.0,
                                ),
                              ),
                              Container(
                                width: 100.0,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'เลขไมล์',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Prompt',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '258,385 * 258,633 (400 กม)',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //-----------------
                        Container(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: DottedLine(
                            dashColor: Colors.grey,
                          ),
                        ),
                        //-----------------
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomSheet: Container(
        alignment: Alignment.center,
        height: 125.0,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'จำนวนลิตร',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
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
                          '40.00 ลิตร',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                            fontFamily: 'Prompt',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'ราคาต่อลิตร',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
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
                          '20.00 บาท',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                            fontFamily: 'Prompt',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                indent: 10.0,
                endIndent: 10.0,
                thickness: 1.0,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'ราคารวม',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
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
                          '800.00 บาท',
                          style: TextStyle(
                            fontSize: 16.0,
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
            ],
          ),
        ),
      ),
    );
  }
}
