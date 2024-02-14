import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/Supplier/shipping/widgets/Footer4Layout.dart';
import 'package:vansale/screens/Supplier/supplier/confirmPages.dart';
import 'package:vansale/screens/Supplier/models/delayTime.dart';
import 'package:vansale/screens/Supplier/models/product.dart';
import 'package:vansale/screens/Supplier/transfer/transferDetail.dart';
import 'package:vansale/screens/home/home.dart';
import 'package:vansale/screens/Supplier/shipping/widgets/productCard.dart';

class TransferConfirm extends StatefulWidget {
  final String typeMenuCode;
  final String hearderTitle;
  const TransferConfirm({Key key, this.typeMenuCode, this.hearderTitle})
      : super(key: key);

  @override
  State<TransferConfirm> createState() => _TransferConfirmState();
}

class _TransferConfirmState extends State<TransferConfirm> {
  DelayTime delay = new DelayTime();

  List<ProductsModel> virtualProduct = [
    ProductsModel(
      id: 1,
      name: "AAAAAAAAAAAAAAAAAAAAAAAAAAA",
      uom1: " 999999 หีบ",
      uom2: " 999999 ห่อ",
      uom3: " 999999 ชิ้น",
      promo:
          'โปรโมชัน โปรโมชัน โปรโมชัน โปรโมชัน โปรโมชัน โปรโมชัน โปรโมชัน โปรโมชัน ',
      price: 9999.00,
      amount: 99999999.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product1.png",
      check: true,
    ),
    ProductsModel(
      id: 2,
      name: "สินค้า 2",
      uom1: "10 หีบ",
      uom2: "12 ห่อ",
      uom3: "1 ชิ้น",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product2.png",
      check: true,
    ),
    ProductsModel(
      id: 3,
      name: "สินค้า 3",
      uom1: "10 หีบ",
      uom2: "12 ห่อ",
      uom3: "1 ชิ้น",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product3.png",
      check: false,
    ),
    ProductsModel(
      id: 4,
      name: "สินค้า 4",
      uom1: "10 หีบ",
      uom2: "12 ห่อ",
      uom3: "1 ชิ้น",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product4.png",
      check: false,
    ),
    ProductsModel(
      id: 5,
      name: "สินค้า 5",
      uom1: "10 หีบ",
      uom2: "12 ห่อ",
      uom3: "1 ชิ้น",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product1.png",
      check: false,
    ),
    ProductsModel(
      id: 6,
      name: "สินค้า 6",
      uom1: "10 หีบ",
      uom2: "12 ห่อ",
      uom3: "1 ชิ้น",
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
            widget.hearderTitle,
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
                              hintText: "ค้นหาสินค้า / ประเภท / ห่อ",
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
                            onPressed: () {},
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
                        child: ShippingOrderCard("new", virtualProduct[index]),
                      );
                    }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Footer4Layout(
            typeMenuCode: widget.typeMenuCode,
            layout1Title: "จำนวนสินค้า",
            layout1Paramitor: "32",
            layout2Title: "จำนวนตะกร้า",
            layout2Paramitor: "4.00",
            layout3Title: "ราคารวม",
            layout3Paramitor: "3700.00",
            iconButton: LineAwesomeIcons.random,
            titleButton: "โอนย้าย",
            navigated: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (comtext) => TransferDetail(navigated: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (comtext) =>
                                ConfirmPages("T002", "โอนย้าย")));
                        Future.delayed(Duration(seconds: delay.getTimeDelay()),
                            () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomePage("T002")),
                              (Route<dynamic> route) => false);
                        });
                      })));
            }));
  }
}
