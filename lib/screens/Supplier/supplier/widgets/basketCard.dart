import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/Supplier/supplier/basketCheck.dart';
import 'package:vansale/screens/Supplier/supplier/confirmPages.dart';
import 'package:vansale/screens/Supplier/models/orderBranch.dart';
import 'package:vansale/screens/home/home.dart';

class BasketCard extends StatelessWidget {
  final OrderBranchModel? orderBranch;
  const BasketCard({Key? key, this.orderBranch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('dd/MM/yyyy');
    double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      color: HexColor("#F2F3F4"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(2.0),
            height: 110.0,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Icon(LineAwesomeIcons.box, size: 48)),
                ),
                //----------------------1
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "วันที่: ${dateFormat.format(DateTime.parse(orderBranch!.date!))}",
                                    style: TextStyle(
                                        fontFamily: 'Prompt', fontSize: 16),
                                  ),
                                ),
                                /*Container(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {},
                                        iconSize: 30.0,
                                      ),
                                    ),*/
                              ],
                            ),
                          ),
                          //--------------------2
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: widthScreen * 0.12,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "สาขา: ",
                                    style: TextStyle(
                                        fontFamily: 'Prompt', fontSize: 16),
                                  ),
                                ),
                                Container(
                                  width: 154,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    orderBranch!.branchName!,
                                    style: TextStyle(
                                        fontFamily: 'Prompt', fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //----------------------------3
                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     "ยอดเงิน: ${formatNum.format(widget.orderBranch.amount)} ฿",
                          //     style: TextStyle(
                          //         // color: Colors.black54,
                          //         fontFamily: 'Prompt',
                          //         fontSize: 16),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BasketCheck('new', 0, () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (comtext) =>
                                          ConfirmPages("T008", "คืนตะกร้า")));
                                  Future.delayed(
                                      Duration(seconds: delay.getTimeDelay()),
                                      () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomePage("T008")),
                                        (route) => false);
                                  });
                                })));
                      },
                      icon: Icon(Icons.navigate_next, size: 48)),
                ),
                SizedBox(
                  width: 6,
                )
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
