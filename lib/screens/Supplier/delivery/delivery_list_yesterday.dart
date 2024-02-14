
import 'package:flutter/material.dart';
import 'package:vansale/screens/Supplier/delivery/models/store.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/deliveryCard.dart';

class DeliveryListYesterday extends StatefulWidget {
  //const DeliveryListYesterday({ Key? key }) : super(key: key);
  final String typeMenuCode;
  DeliveryListYesterday(this.typeMenuCode);
  @override
  _DeliveryListYesterdayState createState() => _DeliveryListYesterdayState();
}

class _DeliveryListYesterdayState extends State<DeliveryListYesterday> {
  List<StoreModel> store = [
    StoreModel(
        id: 0,
        image: "assets/images/Product1.png",
        name: "Store Name",
        address: "NY, Abraham Mount Suite",
        addressname: "Distancs",
        time: "15 กม. 8.50 นาที",
        contact: "Agness Moody",
        phone: "09-5449-8700",
        total: "32 รายการ ,32 ตระกร้า",
        no: "No. 6300626-00XX",
        amount: 99999999.99),
    StoreModel(
        id: 0,
        image: "assets/images/Product2.png",
        name: "Store Name",
        address: "NY, Abraham Mount Suite",
        addressname: "Distancs",
        time: "15 กม. 8.50 นาที",
        contact: "Agness Moody",
        phone: "09-5449-8700",
        total: "32 รายการ ,32 ตระกร้า",
        no: "No. 6300626-00XX",
        amount: 15256.75),
    StoreModel(
        id: 0,
        image: "assets/images/Product3.png",
        name: "Store Name",
        address: "NY, Abraham Mount Suite",
        addressname: "Distancs",
        time: "15 กม. 8.50 นาที",
        contact: "Agness Moody",
        phone: "09-5449-8700",
        total: "32 รายการ ,32 ตระกร้า",
        no: "No. 6300626-00XX",
        amount: 148710.50)
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: store.length,
      itemBuilder: (BuildContext context, int index) {
        return DeliveryCard(widget.typeMenuCode, store[index]);
      },
    );
  }
}
