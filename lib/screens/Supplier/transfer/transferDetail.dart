import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:vansale/screens/Supplier/models/product.dart';
import 'package:vansale/screens/Supplier/supplier/widgets/branchOrderCard.dart';
import 'package:vansale/screens/Supplier/transfer/transferDistance.dart';
import 'package:vansale/screens/home/home.dart';

class TransferDetail extends StatefulWidget {
  final VoidCallback? navigated;
  const TransferDetail({Key? key, this.navigated}) : super(key: key);

  @override
  State<TransferDetail> createState() => _TransferDetailState();
}

class _TransferDetailState extends State<TransferDetail> {
  List<ProductsModel> virtualProduct = [
    ProductsModel(
      id: 1,
      name: "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
      uom1: "99,999 หีบ",
      uom2: "99,999 ห่อ",
      uom3: "99,999 ชิ้น",
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
      promo: '* ลด 10 บาท แถม 1 ชิ้น',
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
          color: Colors.black, //change your color here
        ),
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(57, 203, 91, 1.0),
        centerTitle: true,
        title: Text(
          'รายละเอียดการโอนย้าย',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       Navigator.of(context).pop();
        //     });
        //   },
        // ),
        actions: [
          Row(
            children: [
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.print,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // setState(
                    //   () {
                    //     Navigator.of(context).pop(
                    //       MaterialPageRoute(
                    //         builder: (context) => SendMoney(),
                    //       ),
                    //     );
                    //   },
                    // );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        //alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              width: 414.0,
              height: 224.0,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: 350,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: label1(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DottedLine(
                            dashColor: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: InkWell(
                                onTap: () {
                                  widget.navigated!();

                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         OrderBranchCheck("T008", 0)));
                                },
                                child: TransferDistance()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              child: TransferPay(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: virtualProduct.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductList(
                    mode: "new",
                    product: virtualProduct[index],
                    checkBox: false);
              },
            )),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 80.0,
        color: Colors.green,
        child: Container(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage("T002")),
                  (Route<dynamic> route) => false);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //   width: 35.0,
                  //   alignment: Alignment.center,
                  //   child: Icon(
                  //     LineAwesomeIcons.map_marker,
                  //     color: Colors.green,
                  //     size: 25.0,
                  //   ),
                  // ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'กลับหน้าหลัก',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
    );
  }
}

Widget label1() {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            '27/09/63',
            style: TextStyle(
              color: Color.fromRGBO(130, 145, 169, 1),
              fontFamily: 'Prompt',
              fontSize: 20,
            ),
          ),
        ),
        Container(
          child: Text(
            'No. 630626-00XX',
            style: TextStyle(
              color: Color.fromRGBO(130, 145, 169, 1),
              fontFamily: 'Prompt',
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}
