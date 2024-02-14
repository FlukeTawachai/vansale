import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/models/delayTime.dart';
import 'package:vansale/screens/Supplier/models/product.dart';
import 'package:vansale/screens/Supplier/supplier/scanner.dart';
import 'package:vansale/screens/Supplier/supplier/widgets/basketCheckCard.dart';

DelayTime delay = new DelayTime();

class BasketCheck extends StatefulWidget {
  final String typeMenuCode;
  final int order_id;
  final VoidCallback navigated;
  BasketCheck(this.typeMenuCode, this.order_id, this.navigated);
  @override
  _BasketCheckState createState() => _BasketCheckState();
}

class _BasketCheckState extends State<BasketCheck> {
  String total = '3200.00';
  List<ProductsModel> virtualProduct = [
    ProductsModel(
      id: 0,
      name: "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
      uom1: "ยอดคืน",
      uom2: "นับได้",
      uom3: "ขาด/เกิน",
      promo: '* ลด 10 บาท แถม 1 ชิ้น',
      price: 9999.00,
      amount: 99999999.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product1.png",
      check: true,
    ),
    ProductsModel(
      id: 1,
      name: "ตะกร้า 2",
      uom1: "ยอดคืน",
      uom2: "นับได้",
      uom3: "ขาด/เกิน",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product2.png",
      check: true,
    ),
    ProductsModel(
      id: 2,
      name: "ตะกร้า 3",
      uom1: "ยอดคืน",
      uom2: "นับได้",
      uom3: "ขาด/เกิน",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product3.png",
      check: false,
    ),
    ProductsModel(
      id: 3,
      name: "ตะกร้า 4",
      uom1: "ยอดคืน",
      uom2: "นับได้",
      uom3: "ขาด/เกิน",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product4.png",
      check: false,
    ),
    ProductsModel(
      id: 4,
      name: "ตะกร้า 5",
      uom1: "ยอดคืน",
      uom2: "นับได้",
      uom3: "ขาด/เกิน",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product1.png",
      check: false,
    ),
    ProductsModel(
      id: 5,
      name: "ตะกร้า 6",
      uom1: "ยอดคืน",
      uom2: "นับได้",
      uom3: "ขาด/เกิน",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product2.png",
      check: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'ชื่อสาขา',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        // leading: Container(),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: HexColor('#6c7e9b'),
              height: 60.0,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: TextField(
                          style: TextStyle(
                            fontFamily: 'Prompt',
                          ),
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: "ค้นหาตะกร้า",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 5.0, top: 5.0),
                            prefixIcon: RotatedBox(
                              quarterTurns: 1,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: HexColor('#6c7e9b'),
                                ),
                                onPressed: () {},
                                iconSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        child: IconButton(
                          icon: const Icon(Icons.qr_code),
                          iconSize: 25.0,
                          color: Colors.black,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => QrScanner(),
                            ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: virtualProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: BasketCheckCard(
                          mode: "new", product: virtualProduct[index]),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 200.0,
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
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        '2 รายการ รับ(ตะกร้า)',
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
                        '32 ใบ',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        'ตะกร้า ขาด/เกิน',
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
                        '5 ใบ',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //--------------
            Container(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        'ตะกร้าใบละ(40฿)',
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
                        '1,280.00 ฿',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //--------------
            Container(
              padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        'รวมเป็นเงิน',
                        style: TextStyle(
                          fontSize: 18.0,
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
                        18.0,
                        14.0,
                        Colors.orange,
                        Colors.orange,
                        'Prompt',
                        'Prompt',
                        FontWeight.bold,
                        FontWeight.bold,
                        '฿',
                        18.0,
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
            SizedBox(
              height: 8,
            ),
            TextButton(
                onPressed: () {
                  widget.navigated();

                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (comtext) => ConfirmPages("T008", "คืนตะกร้า")));
                  // Future.delayed(Duration(seconds: delay.getTimeDelay()), () {
                  //   Navigator.of(context).pushAndRemoveUntil(
                  //       MaterialPageRoute(
                  //           builder: (context) => MainMenu("T008")),
                  //       (route) => false);
                  // });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon(Icons.check, size: 48, color: Colors.green),
                    // SizedBox(
                    //   width: 8,
                    // ),
                    Text(
                      "ยืนยันรับตะกร้า",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.green,
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
