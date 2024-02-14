import 'package:flutter/material.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_store_shipping_tabMain.dart';

class DeliveryStoreShippingHome extends StatefulWidget {
  final String typeMenuCode;
  DeliveryStoreShippingHome(this.typeMenuCode);

  @override
  State<DeliveryStoreShippingHome> createState() =>
      _DeliveryStoreShippingHomeState();
}

class _DeliveryStoreShippingHomeState extends State<DeliveryStoreShippingHome> {
  String total = '5200.00';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ส่งสินค้า'),
        centerTitle: true,
        /*actions: [
          Container(
            alignment: Alignment.centerRight,
            color: Colors.pink,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icvp.qrcode_solid,
                color: Colors.black,
                size: 25.0,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            color: Colors.amber,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icvp.ellipsis_v_solid,
                color: Colors.black,
                size: 25.0,
              ),
            ),
          ),
        ],*/
      ),
      body: DeliveryStoreShippingTabMain(widget.typeMenuCode),
    );
  }
}
