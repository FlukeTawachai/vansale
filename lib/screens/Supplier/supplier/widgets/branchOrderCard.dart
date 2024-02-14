import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/models/product.dart';

class ProductList extends StatelessWidget {
  final String mode;
  final ProductsModel product;
  final bool checkBox;
  const ProductList({Key key, this.mode, this.product, this.checkBox})
      : super(key: key);

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
            height: 110.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    product.img,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: widthScreen * 0.58,
                                child: Text(
                                  product.name,
                                  style: TextStyle(
                                      fontFamily: 'Prompt', fontSize: 18),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              checkBox == true
                                  ? Container(
                                      alignment: Alignment.centerRight,
                                      // width: 150.0,
                                      child: (product.check == true)
                                          ? Icon(Icons.check_box_outlined,
                                              color: Colors.green)
                                          : Icon(Icons.check_box_outline_blank,
                                              color: Colors.grey))
                                  : Container(),
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
                                    product.uom1,
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                    ),
                                  ),
                                ),
                              ),
                              mode == "View"
                                  ? Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          product.uom2,
                                          style: TextStyle(
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          product.uom2,
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
                                    product.uom3,
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
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(product.orderno))
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
                      product.price.toString(),
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
