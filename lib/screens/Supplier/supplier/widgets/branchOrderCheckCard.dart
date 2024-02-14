
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/models/product.dart';

class ProductCheckList extends StatefulWidget {
  final String mode;
  final ProductsModel product;
  ProductCheckList({this.mode, this.product});
  @override
  _ProductCheckListState createState() => _ProductCheckListState();
}

class _ProductCheckListState extends State<ProductCheckList> {
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
                    widget.product.img,
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
                                    widget.product.name,
                                    style: TextStyle(
                                        fontFamily: 'Prompt', fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              widget.product.check == true
                                  ? ElevatedButton(
                                      child: Text(
                                        'ตรวจแล้ว',
                                        style: TextStyle(
                                            fontFamily: 'Prompt', fontSize: 14),
                                      ),
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                          textStyle: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  : ElevatedButton(
                                      child: Text(
                                        'ยังไม่ได้ตรวจ',
                                        style: TextStyle(
                                            fontFamily: 'Prompt', fontSize: 14),
                                      ),
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.grey,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                          textStyle: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)),
                                    )
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
                                          widget.product.uom1,
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
                                          widget.product.uom1,
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
                                    widget.product.uom2,
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
                                    widget.product.uom3,
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
                                  widget.product.promo,
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
                      widget.product.price.toString(),
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
