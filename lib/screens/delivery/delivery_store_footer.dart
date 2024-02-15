import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/sliderCard.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/unitSlider.dart';

class DeliveryFooter extends StatelessWidget {
  final Function navigated1;
  final Function navigated2;
  final Icon icon1;
  final Icon icon2;
  final String title1;
  final String title2;
  final double item;
  const DeliveryFooter(
      {Key? key,
      required this.item,
      required this.navigated1,
      required this.navigated2,
      required this.title1,
      required this.title2,
      required this.icon1,
      required this.icon2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double amount = 0;

    for (int i = 0; i < GlobalParam.deliveryUnitList.length; i++) {
      amount += double.parse('${GlobalParam.deliveryUnitList[i]['iTOTAL']}') *
          double.parse('${GlobalParam.deliveryUnitList[i]['iPRICE']}');
    }

    return Container(
      height: 136.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(children: [
        Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
              child: Row(
                children: [
                  SizedBox(
                    width: widthScreen * 0.46,
                    height: 24,
                    child: GlobalParam.typeMenuCode == 'T001'
                        ? Text(
                            item == 0 || item == null
                                ? '0 รายการ'
                                : '${item.toStringAsFixed(0)} รายการ',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          )
                        : const Text(
                            '0 รายการ',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            double total = 0.0;
                            List unitName = [];
                            var listItem = [];
                            for (int i = 0;
                                i < GlobalParam.deliveryUnitList.length;
                                i++) {
                              unitName.add(
                                  GlobalParam.deliveryUnitList[i]['cUOMNM']);
                            }

                            var unitList = unitName.toSet().toList();

                            for (int i = 0; i < unitList.length; i++) {
                              int num = 0;
                              double numItem = 0;
                              for (int j = 0;
                                  j < GlobalParam.deliveryUnitList.length;
                                  j++) {
                                if (unitList[i] ==
                                    GlobalParam.deliveryUnitList[j]['cUOMNM']) {
                                  double total =
                                      GlobalParam.deliveryUnitList[j]['iTOTAL'];
                                  double prince =
                                      GlobalParam.deliveryUnitList[j]['iPRICE'];
                                  num++;
                                  numItem += total;
                                }
                              }
                              var text = {
                                "unitName": unitList[i],
                                "qty": num,
                                "sumItem": numItem.toStringAsFixed(0)
                              };
                              listItem.add(text);
                            }
                            for (var data in listItem) {
                              total += double.parse(data["sumItem"]);
                            }
                            return AlertDialog(
                              title: const Text(
                                'รายละเอียด',
                                style: TextStyle(
                                    fontFamily: 'Prompt', fontSize: 16),
                              ),
                              content: setupAlertDialoadContainer(
                                  GlobalParam.deliveryUnitList, widthScreen),
                              actions: <Widget>[
                                Container(
                                  height: 50.0,

                                  //color: Colors.amber,

                                  alignment: Alignment.centerRight,

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 12, 0),
                                        child: Text(
                                            "${total.toStringAsFixed(0)} รวม",
                                            style: const TextStyle(
                                                fontFamily: 'Prompt',
                                                fontSize: 16)),
                                      )
                                    ],
                                  ),
                                ),
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
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      width: widthScreen * 0.4,
                      height: 24,
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'แสดงรายละเอียด',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 24,
            // ),
            //--------------
            Container(
              padding: const EdgeInsets.only(top: 5.0, left: 12.0, right: 12.0),
              child: Row(
                children: [
                  SizedBox(
                    width: widthScreen * 0.4,
                    height: 24,
                    child: const Text(
                      'รวมเป็นเงิน',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: widthScreen * 0.4,
                    // height: 24,
                    alignment: Alignment.centerRight,
                    child: GlobalParam.typeMenuCode == 'T001'
                        ? SubstringPrice(
                            '$amount',
                            18.0,
                            14.0,
                            Colors.orange,
                            Colors.orange,
                            'Prompt',
                            'Prompt',
                            FontWeight.bold,
                            FontWeight.bold,
                            '฿',
                            18.0,
                            Colors.orange,
                            'Prompt',
                            FontWeight.bold,
                            FontStyle.normal,
                            FontStyle.normal,
                            FontStyle.normal,
                          )
                        : SubstringPrice(
                            '0',
                            18.0,
                            14.0,
                            Colors.orange,
                            Colors.orange,
                            'Prompt',
                            'Prompt',
                            FontWeight.bold,
                            FontWeight.bold,
                            '฿',
                            18.0,
                            Colors.orange,
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

            //--------------
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    navigated1();
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(alignment: Alignment.center, child: icon1),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          title1,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: title1 == 'บันทึกสินค้าเสีย'
                                ? Colors.red
                                : Colors.green,
                            fontFamily: 'Prompt',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                title2 == ''
                    ? const SizedBox(
                        width: 0.0,
                      )
                    : const SizedBox(
                        width: 64.0,
                      ),
                title2 == ''
                    ? Container()
                    : InkWell(
                        onTap: () {
                          navigated2();
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.center, child: icon2),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                title2,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.green,
                                  fontFamily: 'Prompt',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
        //--------------
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 64),
        //   child: SliderCard(),
        // ),
      ]),
    );
  }

  Widget setupAlertDialoadContainer(var data, double widthScreen) {
    List unitName = [];
    var listItem = [];
    for (int i = 0; i < data.length; i++) {
      unitName.add(data[i]['cUOMNM']);
    }

    var unitList = unitName.toSet().toList();

    for (int i = 0; i < unitList.length; i++) {
      int num = 0;
      double numItem = 0;
      for (int j = 0; j < data.length; j++) {
        if (unitList[i] == data[j]['cUOMNM']) {
          double total = data[j]['iTOTAL'];
          double prince = data[j]['iPRICE'];
          num++;
          numItem += total;
        }
      }
      var text = {
        "unitName": unitList[i],
        "qty": num,
        "sumItem": numItem.toStringAsFixed(0)
      };
      listItem.add(text);
    }

    return SizedBox(
      height: data.length * 48.0, // Change as per your requirement
      width: widthScreen * 0.8, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listItem.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 48,
            child: Row(
              children: [
                Text('${listItem[index]['qty']} รายการ'),
                const Spacer(),
                Text(
                    '${listItem[index]['sumItem']} ${listItem[index]['unitName']}')
              ],
            ),
          );
        },
      ),
    );
  }
}
