import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/screens/Supplier/models/product.dart';
import 'package:vansale/screens/Supplier/supplier/widgets/pickImageBox.dart';

class BadProductCheckCard extends StatefulWidget {
  final String? mode;
  final ProductsModel? product;
  BadProductCheckCard({this.mode, this.product});
  @override
  _BadProductCheckCardState createState() => _BadProductCheckCardState();
}

class _BadProductCheckCardState extends State<BadProductCheckCard> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

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
                PickImageBox(product: widget.product!),
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
                                  width: widthScreen * 0.42,
                                  child: Text(
                                    widget.product!.name!,
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
                                    "   ${widget.product!.uom1}",
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
                                    "      ${widget.product!.uom2}",
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
                                    "    ${widget.product!.uom3}",
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
          DottedLine(
            dashColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
