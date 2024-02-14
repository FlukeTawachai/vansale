// xxxxxxxxx
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/class/globalparam.dart';

class ListBatch extends StatefulWidget {
  const ListBatch({Key key}) : super(key: key);

  @override
  State<ListBatch> createState() => _ListBatchState();
}

class _ListBatchState extends State<ListBatch> {
  List<TextEditingController> lsttxtQty = [];
  var f = NumberFormat("###.##", "en_US");
  double widthScreen = 0;
  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: GlobalParam.saleProductSetList.length,
      itemBuilder: (BuildContext context, int index) {
        lsttxtQty.add(new TextEditingController(text: ""));
        var total = 0.0;
        double totalProduct = 0;
        for (int i = 0;
            i < GlobalParam.saleProductSetList[index].aPRODUCT.length;
            i++) {
          var data = GlobalParam.saleProductSetList[index].aPRODUCT[i];
          double sCost = 0;
          double mCost = 0;
          double lCost = 0;
          sCost = double.parse(data.iSUOMQTY) *
              double.parse(data.iCOSTVAT) *
              double.parse(data.iSSIZEQTY);
          mCost = double.parse(data.iMUOMQTY) *
              double.parse(data.iCOSTVAT) *
              double.parse(data.iMSIZEQTY);
          lCost = double.parse(data.iLUOMQTY) *
              double.parse(data.iCOSTVAT) *
              double.parse(data.iLSIZEQTY);
          total += sCost + mCost + lCost;
        }
        return Container(
          color: HexColor("#F2F3F4"),
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: widthScreen*0.4,
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              GlobalParam.saleProductSetList[index].cSETNM,
                              style: TextStyle(
                                fontFamily: "Prompt",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            width: widthScreen*0.4,
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "จำนวน",
                              style: TextStyle(
                                fontFamily: "Prompt",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                'จำนวนชุด',
                                style: TextStyle(
                                  fontFamily: "Prompt",
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
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
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: TextFormField(
                                    controller: lsttxtQty[index],
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: HexColor('#00cb39'),
                                      fontFamily: 'Prompt',
                                    ),
                                    cursorColor: Colors.black,
                                    decoration: new InputDecoration(
                                      hintStyle:
                                          TextStyle(color: HexColor('#00cb39')),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 12.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${f.format(total)} ฿",
                          style: TextStyle(
                            fontFamily: "Prompt",
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
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
      },
    );
  }
}
