import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:vansale/screens/Supplier/supplier/branchDetail.dart';
import 'package:vansale/screens/Supplier/models/product.dart';
import 'package:vansale/screens/Supplier/supplier/widgets/branchOrderCard.dart';

class BranchOrder extends StatefulWidget {
  final VoidCallback? navigated;
  const BranchOrder({Key? key, this.navigated}) : super(key: key);

  @override
  State<BranchOrder> createState() => _BranchOrderState();
}

class _BranchOrderState extends State<BranchOrder> {
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
          'รายละเอียดการขาย',
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
              // width: 414.0,
              height: 280.0,
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
                                child: BranchDetail()),
                          ),
                          Container(
                            child: BranchDetailPay(),
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
                    checkBox: true);
              },
            )),
          ],
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
