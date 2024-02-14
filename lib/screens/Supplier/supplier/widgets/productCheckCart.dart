import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/screens/Supplier/models/product.dart';
import 'package:vansale/screens/Supplier/supplier/widgets/pickImageBox.dart';

class ProductCheckCard extends StatefulWidget {
  final String mode;
  final ProductsModel product;
  ProductCheckCard({this.mode, this.product});
  @override
  _ProductCheckCardState createState() => _ProductCheckCardState();
}

class _ProductCheckCardState extends State<ProductCheckCard> {
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
                PickImageBox(product: widget.product),
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
                                  width: 154,
                                  child: Text(
                                    widget.product.name,
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
                                  padding: const EdgeInsets.all(5.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "   ${widget.product.uom1}",
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
                                    "      ${widget.product.uom2}",
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "    ${widget.product.uom3}",
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //----------------------------3
                        Expanded(
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
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: '1',
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
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: '1',
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
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    initialValue: '1',
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
          // Container(
          //   alignment: Alignment.centerLeft,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Container(),
          //       ),
          //       Container(
          //           alignment: Alignment.centerRight,
          //           width: 150.0,
          //           child: SubstringPrice(
          //             widget.product.price.toString(),
          //             14.0,
          //             12.0,
          //             Colors.black,
          //             Colors.black,
          //             'Prompt',
          //             'Prompt',
          //             FontWeight.bold,
          //             FontWeight.bold,
          //             '฿',
          //             12.0,
          //             Colors.black,
          //             'Prompt',
          //             FontWeight.bold,
          //             FontStyle.normal,
          //             FontStyle.normal,
          //             FontStyle.normal,
          //           )),
          //     ],
          //   ),
          // ),
          DottedLine(
            dashColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
