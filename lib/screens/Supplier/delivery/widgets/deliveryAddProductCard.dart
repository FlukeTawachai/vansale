
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/models/product.dart';

class DeliveryAddProductCard extends StatefulWidget {
  final String? mode;
  final ProductsModel? product;
  DeliveryAddProductCard({this.mode, this.product});
  @override
  _DeliveryAddProductCardState createState() => _DeliveryAddProductCardState();
}

class _DeliveryAddProductCardState extends State<DeliveryAddProductCard> {
  var chestValue = TextEditingController();
  var wrapValue = TextEditingController();
  var itemValue = TextEditingController();

  @override
  void initState() {
    super.initState();
    chestValue.text = 1.toString();
    wrapValue.text = 1.toString();
    itemValue.text = 1.toString();
  }

  //     void _showDeleteDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text(
  //             'ลบรายการสินค้า',
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontFamily: 'Prompt',
  //             ),
  //           ),
  //           content: Text('ต้องการลบชิ้นค้านี้ออกจากรายการสั่งซื้อหรือไม่'),
  //           actions: <Widget>[
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text(
  //                   'ยกเลิก',
  //                   style: TextStyle(
  //                       color: Colors.green,
  //                       fontFamily: 'Prompt',
  //                       fontSize: 16),
  //                 )),
  //             TextButton(
  //               onPressed: () {
  //                 print('ลบสินค้าสำเร็จ');
  //                 Navigator.pop(context);
  //               },
  //               child: Text(
  //                 'ตกลง',
  //                 style: TextStyle(
  //                     color: Colors.green, fontFamily: 'Prompt', fontSize: 16),
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#F2F3F4"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            height: 128.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    widget.product!.img!,
                    fit: BoxFit.cover,
                    width: 100.0,
                    height: 150.0,
                  ),
                ),
                //----------------------1
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 136,
                                  child: Text(
                                    widget.product!.name!,
                                    style: TextStyle(
                                        fontFamily: 'Prompt', fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              
                              // widget.product.check == true
                              //     ? Expanded(
                              //         child: Container(
                              //             alignment: Alignment.center,
                              //             margin: const EdgeInsets.only(
                              //                 left: 5.0, right: 5.0),
                              //             height: 30.0,
                              //             width: 80.0,
                              //             decoration: BoxDecoration(
                              //               color: Colors.green.shade400,
                              //               borderRadius: BorderRadius.only(
                              //                 topLeft: Radius.circular(5),
                              //                 topRight: Radius.circular(5),
                              //                 bottomLeft: Radius.circular(5),
                              //                 bottomRight: Radius.circular(5),
                              //               ),
                              //             ),
                              //             child: Text("สินค้าดี",
                              //                 style: TextStyle(
                              //                     fontFamily: 'Prompt',
                              //                     fontSize: 18,
                              //                     color: Colors.white))),
                              //       )
                              //     : Expanded(
                              //         child: Container(
                              //             alignment: Alignment.center,
                              //             margin: const EdgeInsets.only(
                              //                 left: 5.0, right: 5.0),
                              //             height: 30.0,
                              //             width: 80.0,
                              //             decoration: BoxDecoration(
                              //               color: Colors.red.shade400,
                              //               borderRadius: BorderRadius.only(
                              //                 topLeft: Radius.circular(5),
                              //                 topRight: Radius.circular(5),
                              //                 bottomLeft: Radius.circular(5),
                              //                 bottomRight: Radius.circular(5),
                              //               ),
                              //             ),
                              //             child: Text("สินค้าเสีย",
                              //                 style: TextStyle(
                              //                     fontFamily: 'Prompt',
                              //                     fontSize: 18,
                              //                     color: Colors.white))),
                              //       ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      chestValue.text = 0.toString();
                                      wrapValue.text = 0.toString();
                                      itemValue.text = 0.toString();
                                    });
                                  },
                                  icon: Icon(LineAwesomeIcons.trash,
                                      size: 30, color: Colors.red)),
                            ],
                          ),
                        ),
                        //--------------------2
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              widget.mode == "View"
                                  ? Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          widget.product!.uom1!,
                                          style: TextStyle(
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "      ${widget.product!.uom1}",
                                          style: TextStyle(
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ),
                                    ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "       ${widget.product!.uom2}",
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "       ${widget.product!.uom3}",
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //----------------------------3
                        widget.mode == "View"
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.product!.promo!,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'Prompt',
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        height: 30.0,
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: chestValue,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          // initialValue: '1',
                                          style: TextStyle(
                                            color: HexColor('#00cb39'),
                                            fontFamily: 'Prompt',
                                          ),
                                          cursorColor: Colors.black,
                                          decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 15,
                                                bottom: 11,
                                                top: 15,
                                                right: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        height: 30.0,
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: wrapValue,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          // initialValue: '1',
                                          style: TextStyle(
                                            color: HexColor('#00cb39'),
                                            fontFamily: 'Prompt',
                                          ),
                                          cursorColor: Colors.black,
                                          decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 15,
                                                bottom: 11,
                                                top: 15,
                                                right: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        height: 30.0,
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: itemValue,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          // initialValue: '1',
                                          style: TextStyle(
                                            color: HexColor('#00cb39'),
                                            fontFamily: 'Prompt',
                                          ),
                                          cursorColor: Colors.black,
                                          decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 15,
                                                bottom: 11,
                                                top: 15,
                                                right: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    width: 150.0,
                    child: SubstringPrice(
                      widget.product!.price.toString(),
                      14.0,
                      12.0,
                      Colors.black,
                      Colors.black,
                      'Prompt',
                      'Prompt',
                      FontWeight.bold,
                      FontWeight.bold,
                      '฿',
                      12.0,
                      Colors.black,
                      'Prompt',
                      FontWeight.bold,
                      FontStyle.normal,
                      FontStyle.normal,
                      FontStyle.normal,
                    )),
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
