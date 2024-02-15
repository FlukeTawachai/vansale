import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/unitSlider.dart';
import 'package:vansale/screens/Supplier/models/delayTime.dart';
import 'package:vansale/screens/Supplier/models/product.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryAddProduct.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryConfirmDetail.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/historyDetailCard.dart';
import 'package:vansale/screens/delivery/delivery_store_footer.dart';

class HistoryDetail extends StatefulWidget {
  //const Reorder({ Key? key }) : super(key: key);
  final String typeMenuCode;
  HistoryDetail(this.typeMenuCode);
  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  DelayTime delay = new DelayTime();
// hohoho
  List<ProductsModel> virtualProduct = [
    ProductsModel(
      id: 1,
      name: "AAAAAAAAAAAAAAAAAAAAAAAAAAA",
      uom1: "สต็อก",
      uom2: "15-0-0",
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
      uom1: "สต็อก",
      uom2: "15-0-0",
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
      uom1: "สต็อก",
      uom2: "15-0-0",
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
      uom1: "สต็อก",
      uom2: "15-0-0",
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
      uom1: "สต็อก",
      uom2: "15-0-0",
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
      uom1: "สต็อก",
      uom2: "15-0-0",
      uom3: "1 ชิ้น",
      promo: '',
      price: 100.00,
      amount: 10000.00,
      orderno: 'No.630626-xxxxxxx',
      img: "assets/images/Product2.png",
      check: false,
    ),
  ];
  String total = '3200.00';

  var storeDetail = [
    {'list': UnitSlider(item: 6, unit: 32, unitName: 'ชิ้น')},
    {'list': UnitSlider(item: 6, unit: 32, unitName: 'กล่อง')},
    {'list': UnitSlider(item: 6, unit: 32, unitName: 'แพ็ค')}
  ];
  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'ประวัติการสั่งซื้อ',
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
            // Container(
            //   alignment: Alignment.centerLeft,
            //   color: HexColor('#6c7e9b'),
            //   height: 60.0,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(8, 0, 12, 0),
            //         child: Container(
            //           // alignment: Alignment.center,
            //           // margin: const EdgeInsets.all(10.0),
            //           width: widthScreen * 0.72,
            //           height: 48.0,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(5),
            //               topRight: Radius.circular(5),
            //               bottomLeft: Radius.circular(5),
            //               bottomRight: Radius.circular(5),
            //             ),
            //           ),
            //           child: Container(
            //             alignment: Alignment.center,
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(100),
            //             ),
            //             child: Center(
            //               child: TextField(
            //                 style: TextStyle(
            //                   fontFamily: 'Prompt',
            //                 ),
            //                 textInputAction: TextInputAction.search,
            //                 decoration: InputDecoration(
            //                   hintText: "ค้นหา",
            //                   border: InputBorder.none,
            //                   // contentPadding: EdgeInsets.only(left: 5.0, top: 5.0),
            //                   prefixIcon: RotatedBox(
            //                     quarterTurns: 1,
            //                     child: IconButton(
            //                       icon: Icon(
            //                         Icons.search,
            //                         color: HexColor('#6c7e9b'),
            //                       ),
            //                       onPressed: () {},
            //                       iconSize: 25.0,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       // Spacer(),
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            //         child: InkWell(
            //           onTap: (){},
            //           child: Container(
            //             width: widthScreen * 0.2,
            //             height: 48.0,
            //             decoration: BoxDecoration(
            //               color: Colors.grey.shade300,
            //               borderRadius: BorderRadius.only(
            //                 topLeft: Radius.circular(5),
            //                 topRight: Radius.circular(5),
            //                 bottomLeft: Radius.circular(5),
            //                 bottomRight: Radius.circular(5),
            //               ),
            //             ),
            //             child: Container(
            //                 alignment: Alignment.centerLeft,
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(100),
            //                 ),
            //                 child: Center(child: Text('ประเภท'))),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                  itemCount: virtualProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: HistoryDetailCard("new", virtualProduct[index]),
                    );
                  }),
            ),
            Container(
                height: 136.0,
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
                child: DeliveryFooter(
                  title1: 'สั่งซื้อ',
                  title2: 'สินค้าไม่เคยสั่งซื้อ',
                  navigated1: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DeliveryConfirmDetail(widget.typeMenuCode),
                      ),
                    );
                  },
                  navigated2: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DeliveryAddProduct(widget.typeMenuCode),
                      ),
                    );
                  },
                  icon1: const Icon(
                    LineAwesomeIcons.boxes,
                    color: Colors.green,
                    size: 25.0,
                  ),
                  icon2: const Icon(
                    LineAwesomeIcons.check_circle,
                    color: Colors.green,
                    size: 25.0,
                  ),
                  item: 0,
                )),
          ],
        ),
      ),
    );
  }
}
