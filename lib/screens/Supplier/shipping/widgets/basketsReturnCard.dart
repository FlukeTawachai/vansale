import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/getBasketResp.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/models/product.dart';

class BasketReturnCard extends StatefulWidget {
  final GetBasketResp product;
  BasketReturnCard(this.product);
  @override
  _BasketReturnCardState createState() => _BasketReturnCardState();
}

class _BasketReturnCardState extends State<BasketReturnCard> {
  // TextEditingController textEditingController = TextEditingController();
  var finalValue = TextEditingController();
  var incleaseValue = TextEditingController();
  var decleaseValue = TextEditingController();

  int originValue = 20;
  int inclease = 0;
  int declease = 0;
  int valueFinal;
  String sam, sam2;
  String airFlowText, velocityText, finalText;
  double widthScreen;

  @override
  void initState() {
    super.initState();
    incleaseValue.text = '';
    decleaseValue.text = '';
    finalValue.text = '';
    finalValue.addListener(() => setState(() {}));
  }

  String totalCalculated() {
    airFlowText = incleaseValue.text;
    velocityText = decleaseValue.text;
    finalText = finalValue.text;

    if (airFlowText != '' && velocityText != '') {
      sam = (originValue - declease + inclease).toString();
      finalValue.value = finalValue.value.copyWith(
        text: sam.toString(),
      );
    }
    return sam;
  }

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Container(
      color: HexColor("#F2F3F4"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // GlobalParam.typeMenuCode == "T001"?
          Container(
              padding: const EdgeInsets.all(5.0),
              height: 110.0,
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      width: 100.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                          image: widget.product.cPHOTOPATH != ''
                              ? DecorationImage(
                                  image: new NetworkImage(
                                    'http://${widget.product.cPHOTOSERV}/${widget.product.cPHOTOPATH}',
                                  ),
                                  scale: 1.0,
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: new AssetImage(
                                    "assets/images/no_image.png",
                                  ),
                                  scale: 1.0,
                                  fit: BoxFit.cover,
                                ),
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          border: Border.all(color: Colors.grey)),
                    ),
                    //----------------------1
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: widthScreen * 0.65,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // width: 136,
                            child: Text(
                              widget.product.cBASKNM,
                              style:
                                  TextStyle(fontFamily: 'Prompt', fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Center(
                                child: Text(
                                  "ใบ",
                                  style: TextStyle(
                                      fontFamily: 'Prompt',
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              height: 30.0,
                              width: widthScreen * 0.65,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: TextFormField(
                                  style: TextStyle(color: Colors.green),
                                  onChanged: (value) {
                                    int item = 0;
                                    double total = 0.0;
                                    for (int i = 0;
                                        i <
                                            GlobalParam
                                                .deliveryBasketReq.length;
                                        i++) {
                                      if (GlobalParam
                                              .deliveryBasketReq[i].cBASKCD ==
                                          widget.product.cBASKCD) {
                                        if (value == '') {
                                          GlobalParam
                                              .deliveryBasketReq[i].iQTY = 0;
                                          GlobalParam
                                                  .deliveryBasketReq[i].iTOTAL =
                                              0 *
                                                  double.parse(GlobalParam
                                                      .deliveryBasketList[i]
                                                      .iPRICE);
                                        } else {
                                          GlobalParam.deliveryBasketReq[i]
                                              .iQTY = double.parse(value);
                                          GlobalParam
                                                  .deliveryBasketReq[i].iTOTAL =
                                              int.parse(value) *
                                                  double.parse(GlobalParam
                                                      .deliveryBasketList[i]
                                                      .iPRICE);
                                        }
                                      }
                                      item += int.parse(
                                          '${GlobalParam.deliveryBasketReq[i].iQTY.toStringAsFixed(0)}');
                                      total += GlobalParam
                                          .deliveryBasketReq[i].iTOTAL;
                                    }
                                    setBasketSum(item, total);
                                  },
                                  textAlign: TextAlign.center,
                                  // controller: incleaseValue,
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
                        ],
                      ),
                    ),
                  ])),
          // : Container(
          // padding: const EdgeInsets.all(5.0),
          // height: 110.0,
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Container(
          //       margin: const EdgeInsets.all(5.0),
          //       child: Image.asset(
          //         widget.product.img,
          //         fit: BoxFit.cover,
          //         width: 100.0,
          //         height: 150.0,
          //       ),
          //     ),
          //     //----------------------1
          //     Expanded(
          //       child: Container(
          //         child: Column(
          //           children: [
          //             Expanded(
          //               child: Row(
          //                 children: [
          //                   Expanded(
          //                     child: Container(
          //                       width: 136,
          //                       child: Text(
          //                         widget.product.name,
          //                         style: TextStyle(
          //                             fontFamily: 'Prompt',
          //                             fontSize: 18),
          //                         overflow: TextOverflow.ellipsis,
          //                       ),
          //                     ),
          //                   ),
          //                   // Container(
          //                   //   child: IconButton(
          //                   //     icon: Icon(
          //                   //       LineAwesomeIcons.trash,
          //                   //       color: Colors.red,
          //                   //     ),
          //                   //     onPressed: () {},
          //                   //     iconSize: 30,
          //                   //   ),
          //                   // ),
          //                 ],
          //               ),
          //             ),
          //             //--------------------2
          //             Expanded(
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 children: [
          //                   Expanded(
          //                     child: Container(
          //                       // padding: const EdgeInsets.all(5.0),
          //                       alignment: Alignment.centerLeft,
          //                       child: Text(
          //                         "  ยอดค้าง",
          //                         style: TextStyle(
          //                             fontFamily: 'Prompt',
          //                             color: Colors.green),
          //                       ),
          //                     ),
          //                   ),
          //                   Expanded(
          //                     child: Container(
          //                       alignment: Alignment.centerLeft,
          //                       child: Text(
          //                         "     เพิ่ม",
          //                         style: TextStyle(
          //                             fontFamily: 'Prompt',
          //                             color: Colors.red),
          //                       ),
          //                     ),
          //                   ),
          //                   Expanded(
          //                     child: Container(
          //                       alignment: Alignment.centerLeft,
          //                       child: Text(
          //                         "    เก็บ",
          //                         style: TextStyle(
          //                             fontFamily: 'Prompt',
          //                             color: Colors.green),
          //                       ),
          //                     ),
          //                   ),
          //                   Expanded(
          //                     child: Container(
          //                       alignment: Alignment.centerLeft,
          //                       child: Text(
          //                         "   คงค้าง",
          //                         style: TextStyle(
          //                             fontFamily: 'Prompt',
          //                             color: Colors.blue),
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             //----------------------------3
          //             Expanded(
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 children: [
          //                   // ----------------------1
          //                   Expanded(
          //                     child: Container(
          //                       margin: const EdgeInsets.only(
          //                           left: 5.0, right: 5.0),
          //                       height: 30.0,
          //                       width: 80.0,
          //                       decoration: BoxDecoration(
          //                         color: Colors.grey.shade400,
          //                         borderRadius: BorderRadius.only(
          //                           topLeft: Radius.circular(5),
          //                           topRight: Radius.circular(5),
          //                           bottomLeft: Radius.circular(5),
          //                           bottomRight: Radius.circular(5),
          //                         ),
          //                       ),
          //                       child: TextFormField(
          //                         keyboardType: TextInputType.number,
          //                         enabled: false,
          //                         textAlign: TextAlign.center,
          //                         initialValue: originValue.toString(),
          //                         style: TextStyle(
          //                           // color: HexColor('#00cb39'),
          //                           fontFamily: 'Prompt',
          //                         ),
          //                         cursorColor: Colors.black,
          //                         decoration: new InputDecoration(
          //                           // fillColor: Colors.grey.shade400,
          //                           border: InputBorder.none,
          //                           focusedBorder: InputBorder.none,
          //                           enabledBorder: InputBorder.none,
          //                           errorBorder: InputBorder.none,
          //                           disabledBorder: InputBorder.none,
          //                           contentPadding: EdgeInsets.only(
          //                               left: 15,
          //                               bottom: 11,
          //                               top: 15,
          //                               right: 15),
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                   // -------------2
          //                   Expanded(
          //                     child: Container(
          //                       margin: const EdgeInsets.only(
          //                           left: 5.0, right: 5.0),
          //                       height: 30.0,
          //                       width: 80.0,
          //                       decoration: BoxDecoration(
          //                         color: Colors.white,
          //                         borderRadius: BorderRadius.only(
          //                           topLeft: Radius.circular(5),
          //                           topRight: Radius.circular(5),
          //                           bottomLeft: Radius.circular(5),
          //                           bottomRight: Radius.circular(5),
          //                         ),
          //                       ),
          //                       child: TextFormField(
          //                         textAlign: TextAlign.center,
          //                         controller: incleaseValue,
          //                         onChanged: (textEditingController) {
          //                           setState(() {
          //                             declease = int.parse(
          //                                 textEditingController
          //                                     .toString());
          //                           });
          //                         },
          //                         onTap: () {
          //                           setState(() {
          //                             incleaseValue.clear();
          //                           });
          //                         },
          //                         decoration: InputDecoration(
          //                           border: InputBorder.none,
          //                           focusedBorder: InputBorder.none,
          //                           enabledBorder: InputBorder.none,
          //                           errorBorder: InputBorder.none,
          //                           disabledBorder: InputBorder.none,
          //                           contentPadding: EdgeInsets.only(
          //                               left: 15,
          //                               bottom: 11,
          //                               top: 15,
          //                               right: 15),
          //                         ),
          //                         keyboardType: TextInputType.number,
          //                       ),
          //                     ),
          //                   ),
          //                   // -------------3
          //                   Expanded(
          //                     child: Container(
          //                       margin: const EdgeInsets.only(
          //                           left: 5.0, right: 5.0),
          //                       height: 30.0,
          //                       width: 80.0,
          //                       decoration: BoxDecoration(
          //                         color: Colors.white,
          //                         borderRadius: BorderRadius.only(
          //                           topLeft: Radius.circular(5),
          //                           topRight: Radius.circular(5),
          //                           bottomLeft: Radius.circular(5),
          //                           bottomRight: Radius.circular(5),
          //                         ),
          //                       ),
          //                       child: TextField(
          //                         textAlign: TextAlign.center,
          //                         controller: decleaseValue,
          //                         onChanged: (decleaseValue) {
          //                           setState(() {
          //                             inclease = int.parse(
          //                                 decleaseValue.toString());
          //                           });
          //                         },
          //                         decoration: InputDecoration(
          //                           border: InputBorder.none,
          //                           focusedBorder: InputBorder.none,
          //                           enabledBorder: InputBorder.none,
          //                           errorBorder: InputBorder.none,
          //                           disabledBorder: InputBorder.none,
          //                           contentPadding: EdgeInsets.only(
          //                               left: 15,
          //                               bottom: 11,
          //                               top: 15,
          //                               right: 15),
          //                         ),
          //                         keyboardType: TextInputType.number,
          //                       ),
          //                     ),
          //                   ),
          //                   // ----------------------------------------------------------------4
          //                   Expanded(
          //                     child: Container(
          //                       margin: const EdgeInsets.only(
          //                           left: 5.0, right: 5.0),
          //                       height: 30.0,
          //                       width: 80.0,
          //                       decoration: BoxDecoration(
          //                         color: Colors.grey.shade400,
          //                         borderRadius: BorderRadius.only(
          //                           topLeft: Radius.circular(5),
          //                           topRight: Radius.circular(5),
          //                           bottomLeft: Radius.circular(5),
          //                           bottomRight: Radius.circular(5),
          //                         ),
          //                       ),
          //                       child: TextFormField(
          //                         key: Key(totalCalculated()),
          //                         controller: finalValue,
          //                         onChanged: (value) {
          //                           setState(() {
          //                             finalValue.value =
          //                                 finalValue.value.copyWith(
          //                               text: value.toString(),
          //                             );
          //                           });
          //                         },
          //                         onTap: () {
          //                           setState(() {
          //                             finalValue.clear();
          //                             finalValue.value =
          //                                 finalValue.value.copyWith(
          //                               text: '',
          //                             );
          //                           });
          //                         },
          //                         keyboardType: TextInputType.number,
          //                         enabled: false,
          //                         textAlign: TextAlign.center,
          //                         // initialValue: OriginValue.toString(),
          //                         style: TextStyle(
          //                           // color: HexColor('#00cb39'),
          //                           fontFamily: 'Prompt',
          //                         ),
          //                         cursorColor: Colors.black,
          //                         decoration: new InputDecoration(
          //                           // fillColor: Colors.grey.shade400,
          //                           // labelText: "$OriginValue",
          //                           // labelStyle: TextStyle(
          //                           //     color: Colors.black,
          //                           //     fontWeight: FontWeight.bold),
          //                           border: InputBorder.none,
          //                           focusedBorder: InputBorder.none,
          //                           enabledBorder: InputBorder.none,
          //                           errorBorder: InputBorder.none,
          //                           disabledBorder: InputBorder.none,
          //                           contentPadding: EdgeInsets.only(
          //                               left: 15,
          //                               bottom: 11,
          //                               top: 15,
          //                               right: 15),
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  // widget.mode == "View"
                  //     ? Expanded(
                  //         child: Container(),
                  //       )
                  //     : Expanded(
                  //         child: Text(
                  //           widget.product.promo,
                  //           style: TextStyle(
                  //             color: Colors.red,
                  //             fontFamily: 'Prompt',
                  //           ),
                  //         ),
                  //       ),
                  Spacer(),
                  Container(
                      alignment: Alignment.centerRight,
                      width: 150.0,
                      child: SubstringPrice(
                        widget.product.iPRICE,
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
          ),
          DottedLine(
            dashColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  setBasketSum(int item, double total) async {
    await setState(() {
      print(item);
      print(total);
      GlobalParam.deliveryBasketSum['item'] = '$item';
      GlobalParam.deliveryBasketSum['total'] = '$total';
    });
  }
}
