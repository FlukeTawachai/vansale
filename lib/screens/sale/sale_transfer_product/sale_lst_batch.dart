import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/function/substring_price.dart';

class SaleListBatch extends StatefulWidget {
  const SaleListBatch({Key key}) : super(key: key);

  @override
  State<SaleListBatch> createState() => _SaleListBatchState();
}

class _SaleListBatchState extends State<SaleListBatch> {
  var lstBatch = [
    {
      "code": "001",
      "name": "ชุดที่ 1",
      "qty": "2",
      "uom": "ชุด",
      "total": "1500",
    },
    {
      "code": "002",
      "name": "ชุดที่ 2",
      "qty": "3",
      "uom": "ชุด",
      "total": "2500",
    },
    {
      "code": "003",
      "name": "ชุดที่ 3",
      "qty": "1",
      "uom": "ชุด",
      "total": "750",
    },
    {
      "code": "004",
      "name": "ชุดที่ 4",
      "qty": "4",
      "uom": "ชุด",
      "total": "4500",
    },
    {
      "code": "005",
      "name": "ชุดที่ 5",
      "qty": "2",
      "uom": "ชุด",
      "total": "1500",
    },
  ];

  List<TextEditingController> lsttxtQty = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: lstBatch.length,
      itemBuilder: (BuildContext context, int index) {
        lsttxtQty.add(new TextEditingController(text: lstBatch[index]["qty"]));
        return Container(
          color: HexColor("#F2F3F4"),
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 80.0),
                        alignment: Alignment.centerLeft,
                        child: Text(lstBatch[index]["name"]),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Row(
                          children: [
                            Container(
                              child: Text('จำนวน'),
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
                            Container(
                              padding: const EdgeInsets.only(right: 80.0),
                              alignment: Alignment.centerRight,
                              child: Text(lstBatch[index]["uom"]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 70.0),
                        alignment: Alignment.centerRight,
                        child: SubstringPrice(
                          '${double.parse(lstBatch[index]["total"]).toStringAsFixed(2)}',
                          14.0,
                          14.0,
                          Colors.black,
                          Colors.black,
                          'Prompt',
                          'Prompt',
                          FontWeight.bold,
                          FontWeight.bold,
                          '',
                          14.0,
                          Colors.black,
                          'Prompt',
                          FontWeight.bold,
                          FontStyle.normal,
                          FontStyle.normal,
                          FontStyle.normal,
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
