import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/list_all.dart/lst_order.dart';
import 'package:vansale/screens/home/home.dart';

class ViewOrder extends StatefulWidget {
  final String typeMenuCode;
  ViewOrder(this.typeMenuCode);
  //const ViewOrder({ Key? key }) : super(key: key);

  @override
  _ViewOrderState createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'รายละเอียดการขาย',
          style: TextStyle(
            color: Colors.black,
            //color: Color.fromRGBO(0, 157, 181, 5),
            fontFamily: 'Prompt',
            fontSize: 18.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    HomePage(widget.typeMenuCode),
              ),
            );
          },
        ),
        /*actions: [
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
        ],*/
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
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
                            child: const Text(
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
                            child: const Text(
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
                  const DottedLine(
                    lineThickness: 2.0,
                    dashColor: Colors.black38,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
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
                                    padding: const EdgeInsets.all(3.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
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
                                    padding: const EdgeInsets.all(3.0),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: const Icon(
                                            LineAwesomeIcons.boxes,
                                            color: Colors.black38,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Container(
                                          child: const Text(
                                            '32 รายการ',
                                            style: TextStyle(
                                              fontFamily: 'Prompt',
                                              color: Colors.black54,
                                              //fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Container(
                                          child: const Text(
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
                                    padding: const EdgeInsets.all(3.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
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
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
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
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'ส่วนลดสินค้า',
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
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              '*ลด 10 บาท แถม 1 ชิ้น',
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
                              '3200.00',
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
            //--------List-----------------
            Expanded(
              child: Container(
                child: ListOrder("View"),
              ),
            ),
            //--------------
          ],
        ),
      ),
    );
  }
}
