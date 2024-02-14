import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/screens/Supplier/models/orderBranch.dart';
import 'package:vansale/screens/Supplier/supplier/widgets/orderOFbranchCard.dart';

class OrderOfBranch extends StatefulWidget {
  const OrderOfBranch({Key? key}) : super(key: key);

  @override
  State<OrderOfBranch> createState() => _OrderOfBranchState();
}

class _OrderOfBranchState extends State<OrderOfBranch> {
  List<OrderBranchModel> virtualOrder = [
    OrderBranchModel(
        id: 1, date: DateTime.now().toIso8601String(), branchName: "ร้าน 1", amount: 25680.00),
    OrderBranchModel(
        id: 2, date: DateTime.now().toIso8601String(), branchName: "ร้าน 2", amount: 568200.00),
    OrderBranchModel(
        id: 3, date: DateTime.now().toIso8601String(), branchName: "ร้าน 3", amount: 35620.00),
    OrderBranchModel(
        id: 4, date: DateTime.now().toIso8601String(), branchName: "ร้าน 4", amount: 15980.00),
    OrderBranchModel(
        id: 5, date: DateTime.now().toIso8601String(), branchName: "BBBBBBBBBBBBBBBBBBBBBBBBBB", amount: 99999999.99),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "แยกตามสาขา",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        leading: Container(),

      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: HexColor('#6c7e9b'),
              height: 60.0,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: TextField(
                          style: TextStyle(
                            fontFamily: 'Prompt',
                          ),
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: "ค้นหาร้าน",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 5.0, top: 5.0),
                            prefixIcon: RotatedBox(
                              quarterTurns: 1,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: HexColor('#6c7e9b'),
                                ),
                                onPressed: () {},
                                iconSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: ListView.builder(
                    itemCount: virtualOrder.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child:
                            OrderOfBranchCard(orderBranch: virtualOrder[index]),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
