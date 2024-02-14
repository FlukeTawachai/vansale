import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/supplier/confirmPages.dart';
import 'package:vansale/screens/Supplier/models/delayTime.dart';
import 'package:vansale/screens/home/home.dart';

DelayTime delay = new DelayTime();

class FooterAddProduct extends StatefulWidget {
  final String typeMenuCode;
  const FooterAddProduct(this.typeMenuCode);

  @override
  State<FooterAddProduct> createState() => _FooterAddProductState();
}

class _FooterAddProductState extends State<FooterAddProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 96,
                  height: 96,
                  child: Icon(LineAwesomeIcons.dolly, size: 48),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                '32 รายการ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
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
                                '3700.00',
                                16.0,
                                14.0,
                                Colors.orange,
                                Colors.orange,
                                'Prompt',
                                'Prompt',
                                FontWeight.bold,
                                FontWeight.bold,
                                '',
                                14.0,
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
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'ตะกร้า 2 ใบ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
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
                                  "บาท",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: 'Prompt',
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            DottedLine(
              dashColor: Colors.grey,
            ),
            Expanded(
              child: Card(
                elevation: 0.0,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (comtext) =>
                                    ConfirmPages(widget.typeMenuCode, "เพิ่มสินค้า")));
                            Future.delayed(
                                Duration(seconds: delay.getTimeDelay()), () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(widget.typeMenuCode)),
                                  (route) => false);
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Icon(
                                  LineAwesomeIcons.box,
                                  size: 25.0,
                                  color: HexColor('#00cb39'),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                //alignment: Alignment.centerLeft,
                                child: Text(
                                  'บันทึกเพิ่มสินค้า',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: HexColor('#00cb39'),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
