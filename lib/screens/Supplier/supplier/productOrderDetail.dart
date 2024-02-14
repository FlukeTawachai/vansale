import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/models/supOrderDetail.dart';
import 'package:vansale/screens/Supplier/supplier/widgets/orderDetailCard.dart';
import 'package:vansale/screens/home/home.dart';

class SupOrderDetail extends StatefulWidget {
  final String typeMenuCode;
  final int order_id;
  SupOrderDetail(this.typeMenuCode, this.order_id);
  @override
  _SupOrderDetailState createState() => _SupOrderDetailState();
}

class _SupOrderDetailState extends State<SupOrderDetail> {
  String total = '3200.00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'สินค้ารวมทุกสาขา',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        leading: Container(),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 5.0, right: 10.0),
            child: IconButton(
                icon: Icon(
                  Icons.print,
                  color: Colors.black,
                ),
                onPressed: () {}),
          ),
        ],
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
                            hintText: "ค้นหาสินค้า",
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
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    List<SupOrderDetailModel> virtualOrder = [
                      SupOrderDetailModel(
                          id: index,
                          orderId: widget.order_id,
                          name: "สินค้า ${index + 1}",
                          number: (index + 1) * 2,
                          price: (index + 1) * 2.26,
                          amount: index * 158.01,
                          img: "assets/images/Product1.png"),
                      SupOrderDetailModel(
                          id: index,
                          orderId: widget.order_id,
                          name: "สินค้า ${index + 1}",
                          number: (index + 1) * 2,
                          price: (index + 1) * 2.26,
                          amount: index * 158.01,
                          img: "assets/images/Product2.png"),
                      SupOrderDetailModel(
                          id: index,
                          orderId: widget.order_id,
                          name: "สินค้า ${index + 1}",
                          number: (index + 1) * 2,
                          price: (index + 1) * 2.26,
                          amount: index * 8.00,
                          img: "assets/images/Product3.png"),
                      SupOrderDetailModel(
                          id: index,
                          orderId: widget.order_id,
                          name:
                              "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAสินค้า ${index + 1}",
                          number: (index + 1) * 2,
                          price: 99999999.99,
                          amount: index * 5.01,
                          img: "assets/images/Product4.png"),
                    ];
                    return Container(
                      child: ListProduct(orderDetail: virtualOrder[index]),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
                        'ยอดรวมทั้งหมด',
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
                        '32 ชิ้น',
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
                        'เป็นเงินทั้งหมด',
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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomePage("T008")),
                            (Route<dynamic> route) => false);
                      },
                      child: Text(
                        "กลับหน้าหลัก",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.green,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
                        ),
                      )),
                  SizedBox(
                    width: 48,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "ไปหน้าสาขา",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.green,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
