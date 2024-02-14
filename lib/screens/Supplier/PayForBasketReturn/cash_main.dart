import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/PayReq.dart';
import 'package:vansale/api/class/request/mobile/addStockCardReq.dart';

import 'package:vansale/screens/Supplier/PayForBasketReturn/cash_components.dart';
import 'package:vansale/screens/Supplier/PayForBasketReturn/storeName_for_basketReturn.dart';

class Cash extends StatefulWidget {
  final VoidCallback navigated;
  Cash(this.navigated);
  @override
  _CashState createState() => _CashState();
}

class _CashState extends State<Cash> {
  String poDate = DateFormat('dd-MM-yy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(57, 203, 91, 1.0),
          centerTitle: true,
          title: Text(
            'รับชำระเงินสด',
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
          actions: [
            Row(
              children: [
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.print,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
                // Container(
                //   child: IconButton(
                //     icon: Icon(
                //       Icons.more_vert,
                //       color: Colors.black,
                //     ),
                //     onPressed: () {
                //       setState(
                //         () {
                //           Navigator.of(context).pop(
                //             MaterialPageRoute(
                //               builder: (context) => SendMoney(),
                //             ),
                //           );
                //         },
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ],
        ),
        body: Container(
          //alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                width: 414.0,
                height: 312.0,
                child: Column(
                  children: [
                    Container(
                      width: 350,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: label1(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DottedLine(
                            dashColor: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            child: Details_Main_BasketReturn(IsSale: false,),
                          ),
                          Container(
                            color: Colors.white,
                            child: Details_Main_BasketReturn_more(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BodyCashPay(),
              ),
              // savebutton()
            ],
          ),
        ),
        bottomNavigationBar: savebutton());
  }

  yearThai() {
    var _podate = poDate.split('-');
    var _day = _podate[0];
    var _month = _podate[1];
    var _year = _podate[2];
    int cal = int.parse(_year) + 43;
    String poDatethai = _day + '/' + _month + '/' + cal.toString();
    return poDatethai;
  }

  Widget _dateHD() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        yearThai(),
        style: TextStyle(
          fontFamily: 'Prompt',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  addStockCard() async {
    // print(
    //     '**********${GlobalParam.deliveryPodtList.length} : ${GlobalParam.deliveryHisProduct.length}************');
    try {
      List<StockCardReq> stockCardReqList = [];
      for (int i = 0; i < GlobalParam.deliveryPodtList.length; i++) {
        // if (stockCardReqList.length > 0) {
        //   print('**********************');
        //   print(stockCardReqList[i].cBRANCD);
        //   print(stockCardReqList[i].cPRODCD);
        //   print(stockCardReqList[i].cUOMCD);
        //   print(stockCardReqList[i].cWH);
        //   print(stockCardReqList[i].cREFDOC);
        //   print(stockCardReqList[i].iRECEIVEQTY);
        //   print(stockCardReqList[i].iISSUEQTY);
        //   print(stockCardReqList[i].cREMARK);
        //   print(stockCardReqList[i].cLOTNO);
        // }

        if (GlobalParam.deliveryPodtList[i].iINCOMPRO != 0) {
          String cUOMCD = '';
          if (double.parse(GlobalParam.deliveryPodtList[i].iSSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryPodtList[i].cSUOMCD!;
          }
          if (double.parse(GlobalParam.deliveryPodtList[i].iMSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryPodtList[i].cMUOMCD!;
          }
          if (double.parse(GlobalParam.deliveryPodtList[i].iLSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryPodtList[i].cLUOMCD!;
          }
          StockCardReq inCom = StockCardReq(
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cPRODCD: GlobalParam.deliveryPodtList[i].cPRODCD,
              cUOMCD: cUOMCD,
              cWH: 'FG',
              cREFDOC: GlobalParam.deliveryProductList[0].cPOCD,
              iRECEIVEQTY: '${GlobalParam.deliveryPodtList[i].iINCOMPRO}',
              iISSUEQTY: '0',
              cREMARK: '',
              cLOTNO: '',
              cCREABY: GlobalParam.userID);

          stockCardReqList.add(inCom);
        }

        if (GlobalParam.deliveryPodtList[i].iCANCLEPRO != 0) {
          // if (stockCardReqList.length > 0) {
          //   print('**********************');
          //   print(stockCardReqList[i].cBRANCD);
          //   print(stockCardReqList[i].cPRODCD);
          //   print(stockCardReqList[i].cUOMCD);
          //   print(stockCardReqList[i].cWH);
          //   print(stockCardReqList[i].cREFDOC);
          //   print(stockCardReqList[i].iRECEIVEQTY);
          //   print(stockCardReqList[i].iISSUEQTY);
          //   print(stockCardReqList[i].cREMARK);
          //   print(stockCardReqList[i].cLOTNO);
          // }
          String cUOMCD = '';
          if (double.parse(GlobalParam.deliveryPodtList[i].iSSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryPodtList[i].cSUOMCD!;
          }
          if (double.parse(GlobalParam.deliveryPodtList[i].iMSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryPodtList[i].cMUOMCD!;
          }
          if (double.parse(GlobalParam.deliveryPodtList[i].iLSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryPodtList[i].cLUOMCD!;
          }
          StockCardReq cancel = StockCardReq(
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cPRODCD: GlobalParam.deliveryPodtList[i].cPRODCD,
              cUOMCD: cUOMCD,
              cWH: 'RG',
              cREFDOC: GlobalParam
                  .deliveryProductList[0].cPOCD, //RG-สาขา-YYMMDD-0000
              iRECEIVEQTY: '${GlobalParam.deliveryPodtList[i].iCANCLEPRO}',
              iISSUEQTY: '0',
              cREMARK: '',
              cLOTNO: '',
              cCREABY: GlobalParam.userID);

          stockCardReqList.add(cancel);
        }
      }

      for (int i = 0; i < GlobalParam.deliveryHisProduct.length; i++) {
        if (GlobalParam.deliveryHisProduct[i].iINCOMPRO != 0) {
          String cUOMCD = '';
          if (double.parse(GlobalParam.deliveryHisProduct[i].iSSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryHisProduct[i].cSUOMCD!;
          }
          if (double.parse(GlobalParam.deliveryHisProduct[i].iMSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryHisProduct[i].cMUOMCD!;
          }
          if (double.parse(GlobalParam.deliveryHisProduct[i].iLSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryHisProduct[i].cLUOMCD!;
          }
          StockCardReq reGood = StockCardReq(
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cPRODCD: GlobalParam.deliveryHisProduct[i].cPRODCD,
              cUOMCD: cUOMCD,
              cWH: 'RG',
              cREFDOC: GlobalParam.deliveryProductList[0].cPOCD,
              iRECEIVEQTY: '${GlobalParam.deliveryHisProduct[i].iINCOMPRO}',
              iISSUEQTY: '0',
              cREMARK: '',
              cLOTNO: '',
              cCREABY: GlobalParam.userID);

          stockCardReqList.add(reGood);
        }

        if (GlobalParam.deliveryHisProduct[i].iLOSSPRO != 0) {
          String cUOMCD = '';
          if (double.parse(GlobalParam.deliveryHisProduct[i].iSSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryHisProduct[i].cSUOMCD!;
          }
          if (double.parse(GlobalParam.deliveryHisProduct[i].iMSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryHisProduct[i].cMUOMCD!;
          }
          if (double.parse(GlobalParam.deliveryHisProduct[i].iLSIZEQTY!) != 0) {
            cUOMCD = GlobalParam.deliveryHisProduct[i].cLUOMCD!;
          }
          StockCardReq reBad = StockCardReq(
              cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
              cPRODCD: GlobalParam.deliveryHisProduct[i].cPRODCD,
              cUOMCD: cUOMCD,
              cWH: 'RB',
              cREFDOC: GlobalParam.deliveryProductList[0].cPOCD,
              iRECEIVEQTY: '${GlobalParam.deliveryHisProduct[i].iLOSSPRO}',
              iISSUEQTY: '0',
              cREMARK: '',
              cLOTNO: '',
              cCREABY: GlobalParam.userID);

          stockCardReqList.add(reBad);
        }
      }

      AllApiProxyMobile proxy = AllApiProxyMobile();

      for (int i = 0; i < stockCardReqList.length; i++) {
        // print('********** $i ************');
        // print(stockCardReqList[i].cBRANCD);
        // print(stockCardReqList[i].cPRODCD);
        // print(stockCardReqList[i].cUOMCD);
        // print(stockCardReqList[i].cWH);
        // print(stockCardReqList[i].cREFDOC);
        // print(stockCardReqList[i].iRECEIVEQTY);
        // print(stockCardReqList[i].iISSUEQTY);
        // print(stockCardReqList[i].cREMARK);
        // print(stockCardReqList[i].cLOTNO);
        var result = await proxy.addStockCard(stockCardReqList[i]);
        if (result.success == false) {
          wrongDialog(result.message);
        }
      }

      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  payMent(PayReq req) async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();

      var result = await proxy.payment(req);
      if (result.success == false) {
        wrongDialog(result.message);
      }
      // addStockCard();
      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  wrongDialog(String msg) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('Information'),
        content: Text(
          msg,
          style: const TextStyle(fontSize: 11.0),
        ),
        actions: <Widget>[
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.8,
          ),
          Container(
            height: 50.0,

            //color: Colors.amber,

            alignment: Alignment.centerRight,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget label1() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dateHD(),
          Container(
            child: Text(
              GlobalParam.deliveryStoreSum.cPOCD!,
              style: TextStyle(
                color: Color.fromRGBO(130, 145, 169, 1),
                fontFamily: 'Prompt',
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget savebutton() {
    return Container(
      height: 85.0,
      // width: 190,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: HexColor('#00cb39'),
          ),
        ),
      ),
      child: TextButton(
        onPressed: () async {
          String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
          print(
              'GlobalParam.deliveryPodtList.length ${GlobalParam.deliveryPodtList.length}');
          if (GlobalParam.typeMenuCode == "T002") {
            payMent(PayReq(
                cDOCREF: GlobalParam.PoHDAndPoDT.length > 0
                    ? GlobalParam.PoHDAndPoDT[0].cPOCD
                    : '',
                dDOCDATE: date,
                cTRANSCD: "AR",
                cCONTACTCD: GlobalParam.deliveryStoreSum.cCUSTCD,
                iDEBIT: (double.tryParse(GlobalParam.deliveryStoreSum.iTOTAL!) ??
                        0.0) -
                    GlobalParam.basketReturn['basketReturnPrice']!,
                iCREDIT:
                    (double.tryParse(GlobalParam.deliveryStoreSum.iTOTAL!) ??
                            0.0) -
                        GlobalParam.basketReturn['basketReturnPrice']!,
                cCREABY: GlobalParam.userID,
                cRECTYPE: "CH",
                cBANK: "",
                cCQTYPE: "",
                cCQCD: "",
                cCQDT: ""));
            widget.navigated();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //alignment: Alignment.centerRight,
              child: Icon(
                FontAwesomeIcons.checkCircle,
                size: 20.0,
                color: HexColor('#00cb39'),
              ),
            ),
            Container(
              //alignment: Alignment.centerLeft,
              child: Text(
                '  บันทึกการชำระ',
                style: TextStyle(
                  fontSize: 18.0,
                  color: HexColor('#00cb39'),
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
