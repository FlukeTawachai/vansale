import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/screens/Supplier/models/supOrderDetail.dart';

class ListProduct extends StatelessWidget {
  final SupOrderDetailModel orderDetail;
  const ListProduct({ Key key, this.orderDetail }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatNum = new NumberFormat("#,###.0#", "en_US");
    return Container(
      color: HexColor("#F2F3F4"),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            height: 110.0,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    orderDetail.img,
                    fit: BoxFit.cover,
                    width: 100.0,
                    height: 150.0,
                  ),
                ),
                //----------------------1
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    // width: widthScreen * 0.2,
                                    child: Text(
                                      orderDetail.name,
                                      style: TextStyle(
                                          fontFamily: 'Prompt', fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                               
                              ],
                            ),
                          ),
                          //--------------------2
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "จำนวนสินค้า: ${orderDetail.number}",
                                      style: TextStyle(
                                          fontFamily: 'Prompt', fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //----------------------------3
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "ราคาสุทธิ: ${formatNum.format(orderDetail.price)} ฿",
                              style: TextStyle(
                                  // color: Colors.black54,
                                  fontFamily: 'Prompt',
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DottedLine(
            dashColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
