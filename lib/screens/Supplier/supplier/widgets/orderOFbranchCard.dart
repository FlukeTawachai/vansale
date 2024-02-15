import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/Supplier/supplier/branchOrder.dart';
import 'package:vansale/screens/Supplier/models/orderBranch.dart';
import 'package:vansale/screens/Supplier/supplier/orderBranchCheck.dart';

class OrderOfBranchCard extends StatefulWidget {
  final OrderBranchModel? orderBranch;
  const OrderOfBranchCard({Key? key, this.orderBranch}) : super(key: key);

  @override
  State<OrderOfBranchCard> createState() => _OrderOfBranchCardState();
}

class _OrderOfBranchCardState extends State<OrderOfBranchCard> {
  final formatNum = new NumberFormat("#,###.0#", "en_US");
  var dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
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
                                    "วันที่: ${dateFormat.format(DateTime.parse(widget.orderBranch!.date!))}",
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
                                Expanded(
                                  child: Row(children: [
                                    Container(
                                      child: Text(
                                        "ชื่อร้าน: ",
                                        style: TextStyle(
                                            fontFamily: 'Prompt', fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      width: widthScreen * 0.32,
                                      child: Text(
                                        widget.orderBranch!.branchName!,
                                        style: TextStyle(
                                            fontFamily: 'Prompt', fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ]),
                                ),
                                // Container(
                                //     width: 169,
                                //     alignment: Alignment.centerLeft,
                                //     child: Text(
                                //       "ชื่อร้าน: ${widget.orderBranch.branchName}",
                                //       style: TextStyle(
                                //           fontFamily: 'Prompt', fontSize: 16),
                                //       overflow: TextOverflow.ellipsis,
                                //     ),
                                //   ),
                              ],
                            ),
                          ),
                          //----------------------------3
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ยอดเงิน: ${formatNum.format(widget.orderBranch!.amount!)} ฿",
                              style: TextStyle(
                                  // color: Colors.black54,
                                  fontFamily: 'Prompt',
                                  fontSize: 16),
                            ),
                          ),
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
                            builder: (context) => BranchOrder(navigated: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          OrderBranchCheck("T008", 0)));
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
