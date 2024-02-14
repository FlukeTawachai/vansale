import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/models/product.dart';

class NewHistoryDetailCard extends StatefulWidget {
  final String mode;
  final ProductsModel product;
  NewHistoryDetailCard(this.mode, this.product);
  @override
  _NewHistoryDetailCardState createState() => _NewHistoryDetailCardState();
}

class _NewHistoryDetailCardState extends State<NewHistoryDetailCard> {
  // TextEditingController textEditingController = TextEditingController();
  var finalValue = TextEditingController();
  var incleaseValue = TextEditingController();
  var decleaseValue = TextEditingController();

  int OriginValue = 20;
  int inclease = 0;
  int declease = 0;
  int valueFinal;
  String sam, sam2;
  String airFlowText, velocityText, finalText;

  @override
  void initState() {
    super.initState();
    incleaseValue.text = inclease.toString();
    decleaseValue.text = declease.toString();
    finalValue.text = OriginValue.toString();
    finalValue.addListener(() => setState(() {}));
  }

  String totalCalculated() {
    airFlowText = incleaseValue.text;
    velocityText = decleaseValue.text;
    finalText = finalValue.text;

    if (airFlowText != '' && velocityText != '') {
      sam = (OriginValue - declease + inclease).toString();
      finalValue.value = finalValue.value.copyWith(
        text: sam.toString(),
      );
    }
    return sam;
  }

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
            height: 110.0,
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
                                  width: 128,
                                  child: Text(
                                    widget.product.name,
                                    style: TextStyle(
                                        fontFamily: 'Prompt', fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    LineAwesomeIcons.trash,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      incleaseValue.text = 0.toString();
                                      decleaseValue.text = 0.toString();
                                    });
                                  },
                                  iconSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //--------------------2
                        // Expanded(
                        //   child: Container(
                        //     // width: 128,
                        //     alignment: Alignment.centerLeft,
                        //     child: Text(
                        //       "${widget.product.uom1}\t${widget.product.price}",
                        //       style:
                        //           TextStyle(fontFamily: 'Prompt', fontSize: 14),
                        //       overflow: TextOverflow.ellipsis,
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          child: Container(
                            // width: 128,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "สต็อก 200",
                              style:
                                  TextStyle(fontFamily: 'Prompt', fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        //--------------------3
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  width: 80.0,
                                  // padding: const EdgeInsets.all(5.0),
                                  alignment: Alignment.centerLeft,
                                  child: Center(
                                    child: Text(
                                      "ยอดสั่ง",
                                      style: TextStyle(
                                          fontFamily: 'Prompt',
                                          color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 80.0,
                                  alignment: Alignment.centerLeft,
                                  child: Center(
                                    child: Text(
                                      "ลด",
                                      style: TextStyle(
                                          fontFamily: 'Prompt',
                                          color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 80.0,
                                  alignment: Alignment.centerLeft,
                                  child: Center(
                                    child: Text(
                                      "เพิ่ม",
                                      style: TextStyle(
                                          fontFamily: 'Prompt',
                                          color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: Container(
                              //     alignment: Alignment.centerLeft,
                              //     child: Text(
                              //       "   คงค้าง",
                              //       style: TextStyle(
                              //           fontFamily: 'Prompt',
                              //           color: Colors.blue),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        //----------------------------4
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ----------------------5
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  height: 30.0,
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      enabled: false,
                                      textAlign: TextAlign.center,
                                      initialValue: OriginValue.toString(),
                                      style: TextStyle(
                                        // color: HexColor('#00cb39'),
                                        fontFamily: 'Prompt',
                                      ),
                                      cursorColor: Colors.black,
                                      decoration: new InputDecoration(
                                        // fillColor: Colors.grey.shade400,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        // contentPadding: EdgeInsets.only(
                                        //     left: 15,
                                        //     bottom: 11,
                                        //     top: 15,
                                        //     right: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // -------------2
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                                  child: Center(
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: incleaseValue,
                                      onChanged: (textEditingController) {
                                        setState(() {
                                          declease = int.parse(
                                              textEditingController.toString());
                                        });
                                      },
                                      onTap: () {
                                        setState(() {
                                          incleaseValue.clear();
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        // contentPadding: EdgeInsets.only(
                                        //     left: 15,
                                        //     bottom: 11,
                                        //     top: 15,
                                        //     right: 15),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ),
                              // -------------3
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                                  child: Center(
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: decleaseValue,
                                      onChanged: (decleaseValue) {
                                        setState(() {
                                          inclease = int.parse(
                                              decleaseValue.toString());
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        // contentPadding: EdgeInsets.only(
                                        //     left: 15,
                                        //     bottom: 11,
                                        //     top: 15,
                                        //     right: 15),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ),
                              // ----------------------------------------------------------------4
                              // Expanded(
                              //   child: Container(
                              //     margin: const EdgeInsets.only(
                              //         left: 5.0, right: 5.0),
                              //     height: 30.0,
                              //     width: 80.0,
                              //     decoration: BoxDecoration(
                              //       color: Colors.grey.shade400,
                              //       borderRadius: BorderRadius.only(
                              //         topLeft: Radius.circular(5),
                              //         topRight: Radius.circular(5),
                              //         bottomLeft: Radius.circular(5),
                              //         bottomRight: Radius.circular(5),
                              //       ),
                              //     ),
                              //     child: TextFormField(
                              //       key: Key(totalCalculated()),
                              //       controller: finalValue,
                              //       onChanged: (value) {
                              //         setState(() {
                              //           finalValue.value =
                              //               finalValue.value.copyWith(
                              //             text: value.toString(),
                              //           );
                              //         });
                              //       },
                              //       onTap: () {
                              //         setState(() {
                              //           finalValue.clear();
                              //           finalValue.value =
                              //               finalValue.value.copyWith(
                              //             text: '',
                              //           );
                              //         });
                              //       },
                              //       keyboardType: TextInputType.number,
                              //       enabled: false,
                              //       textAlign: TextAlign.center,
                              //       // initialValue: OriginValue.toString(),
                              //       style: TextStyle(
                              //         // color: HexColor('#00cb39'),
                              //         fontFamily: 'Prompt',
                              //       ),
                              //       cursorColor: Colors.black,
                              //       decoration: new InputDecoration(
                              //         // fillColor: Colors.grey.shade400,
                              //         // labelText: "$OriginValue",
                              //         // labelStyle: TextStyle(
                              //         //     color: Colors.black,
                              //         //     fontWeight: FontWeight.bold),
                              //         border: InputBorder.none,
                              //         focusedBorder: InputBorder.none,
                              //         enabledBorder: InputBorder.none,
                              //         errorBorder: InputBorder.none,
                              //         disabledBorder: InputBorder.none,
                              //         contentPadding: EdgeInsets.only(
                              //             left: 15,
                              //             bottom: 11,
                              //             top: 15,
                              //             right: 15),
                              //       ),
                              //     ),
                              //   ),
                              // ),
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
                widget.mode == "View"
                    ? Expanded(
                        child: Container(),
                      )
                    : Expanded(
                        child: Text(
                          widget.product.promo,
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Prompt',
                          ),
                        ),
                      ),
                Container(
                    alignment: Alignment.centerRight,
                    width: 150.0,
                    child: SubstringPrice(
                      widget.product.amount.toString(),
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
