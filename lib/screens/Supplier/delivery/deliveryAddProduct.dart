import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/newHistoyDetailCard.dart';
import 'package:vansale/screens/Supplier/models/product.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/deliveryAddProductCard.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/footerAddProduct.dart';
import 'package:vansale/screens/Supplier/supplier/confirmPages.dart';
import 'package:vansale/screens/Supplier/supplier/scanner.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_bad_product.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_Store_filter.dart';
import 'package:vansale/screens/delivery/delivery_store_footer.dart';
import 'package:vansale/screens/home/home.dart';

class DeliveryAddProduct extends StatefulWidget {
  //const MoreItem({ Key? key }) : super(key: key);
  final String typeMenuCode;
  DeliveryAddProduct(this.typeMenuCode);
  @override
  _DeliveryAddProductState createState() => _DeliveryAddProductState();
}

class _DeliveryAddProductState extends State<DeliveryAddProduct> {
  String total = '3200.00';
  double widthScreen = 0;
  List<ProductsModel> virtualProduct = [
    ProductsModel(
      id: 0,
      name: "AAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
      uom1: "Kg",
      uom2: "",
      uom3: "",
      promo: '* ลด 10 บาท แถม 1 ชิ้น',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product1.png",
      check: true,
    ),
    ProductsModel(
      id: 1,
      name: "สินค้า 2",
      uom1: "หีบ",
      uom2: "ห่อ",
      uom3: "",
      promo: '',
      price: 1000.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product2.png",
      check: true,
    ),
    ProductsModel(
      id: 2,
      name: "สินค้า 3",
      uom1: "หีบ",
      uom2: "แพ็ค",
      uom3: "ห่อ",
      promo: '',
      price: 10000.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product3.png",
      check: false,
    ),
    ProductsModel(
      id: 3,
      name: "สินค้า 4",
      uom1: "หีบ",
      uom2: "แพ็ค",
      uom3: "ห่อ",
      promo: '',
      price: 999999.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product4.png",
      check: false,
    ),
    ProductsModel(
      id: 4,
      name: "สินค้า 5",
      uom1: "หีบ",
      uom2: "แพ็ค",
      uom3: "ห่อ",
      promo: '',
      price: 10.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product1.png",
      check: false,
    ),
    ProductsModel(
      id: 5,
      name: "สินค้า 6",
      uom1: "หีบ",
      uom2: "แพ็ค",
      uom3: "ห่อ",
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
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'สินค้าไม่เคยสั่ง',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
        ),
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
              child: Row(
                children: [
                  Container(
                    width: widthScreen * 0.74,
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
                                hintText: "ค้นหา",
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
                  Container(
                    width: widthScreen * 0.2,
                    height: 48,
                    child: Card(
                      elevation: 0.0,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FilterPage(pageNumber: '',)));
                        },
                        child: Container(
                          color: Colors.black12,
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Text(
                            'ประเภท',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: virtualProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: DeliveryBadProductCard(),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DeliveryFooter(
        title1: 'บันทึกเพิ่มสินค้า',
        title2: '',
        navigated1: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (comtext) =>
                  ConfirmPages(widget.typeMenuCode, "เพิ่มสินค้า")));
          Future.delayed(Duration(seconds: delay.getTimeDelay()), () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => HomePage(widget.typeMenuCode)),
                (route) => false);
          });
        },
        icon1: Icon(
          LineAwesomeIcons.check_circle,
          color: Colors.green,
          size: 25.0,
        ),
      ),
    );
  }
}
