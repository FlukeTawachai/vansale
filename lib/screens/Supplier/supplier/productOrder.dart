import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/screens/Supplier/models/supOrder.dart';
import 'package:vansale/screens/Supplier/supplier/widgets/supplierCard.dart';

class ProductOrder extends StatefulWidget {
  const ProductOrder({Key? key}) : super(key: key);

  @override
  State<ProductOrder> createState() => _ProductOrderState();
}

class _ProductOrderState extends State<ProductOrder> {
  DateTime _dateTime = DateTime.now();

  List<SupplierOrder> virtualOrder = [
    SupplierOrder(id: 1, date: DateTime.now().toIso8601String()),
    SupplierOrder(id: 2, date: DateTime.now().toIso8601String()),
    SupplierOrder(id: 3, date: DateTime.now().toIso8601String()),
    SupplierOrder(id: 4, date: DateTime.now().toIso8601String()),
    SupplierOrder(id: 5, date: DateTime.now().toIso8601String()),
    SupplierOrder(id: 6, date: DateTime.now().toIso8601String()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "วันที่",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        leading: Container(),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 5.0, right: 10.0),
            child: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onPressed: () {}),
          ),
        ],
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: InkWell(
                      onTap: () {
                        showDatePicker(
                          locale: const Locale("th", "TH"),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary:
                                      Colors.green, // header background color
                                  onPrimary: Colors.white, // header text color
                                  onSurface: Colors.black, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: Colors.green, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                          context: context,
                          initialDate:
                              _dateTime == null ? DateTime.now() : _dateTime,
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2100),
                        ).then((date) {
                          setState(() {
                            _dateTime = date!;
                          });
                        });
                      },
                      child: Row(
                        children: [
                          RotatedBox(
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
                          SizedBox(width: 4),
                          Text("ค้นหาเลขที่สั่งซื้อ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Prompt',
                                  color: Colors.grey.shade700)),
                        ],
                      ),
                    ),
                  )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: ListView.builder(
                    itemCount: virtualOrder.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OrderOrderCard(supOrder: virtualOrder[index]);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
