import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/Supplier/models/supOrder.dart';
import 'package:intl/intl.dart';
import 'package:vansale/screens/Supplier/supplier/productOrderDetail.dart';

class OrderOrderCard extends StatelessWidget {
  final SupplierOrder supOrder;
  const OrderOrderCard({ Key key , this.supOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('dd/MM/yyyy');

    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: Column(
          children: [
            ListTile(
                leading: Icon(LineAwesomeIcons.box,size:48),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SupOrderDetail(
                            supOrder.date, supOrder.id)));
                  },
                  icon: Icon(Icons.navigate_next),
                  iconSize: 48,
                ),
                title: Text("วันที่: ${dateFormat.format(DateTime.parse(supOrder.date))}")),
            SizedBox(
              height: 12,
            ),
            DottedLine(
              dashColor: Colors.grey,
            ),
          ],
        )

        );
  }
}

