import 'package:flutter/material.dart';
import 'package:vansale/api/class/globalparam.dart';
//import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/common_screen.dart/county.dart';
import 'package:vansale/common_screen.dart/district.dart';
import 'package:vansale/screens/Supplier/shipping/shipping.dart';
import 'package:vansale/screens/delivery/delivery_list.dart';
import 'package:vansale/screens/home/home.dart';
import 'package:vansale/screens/customer/order.dart';
import 'package:vansale/common_screen.dart/province.dart';
import 'package:vansale/screens/refuel/refuel.dart';
import 'package:vansale/screens/refuel/refuel_add.dart';
import 'package:vansale/screens/refuel/refuel_detail.dart';
import 'package:vansale/screens/sale/survey/sale_storeDetail.dart';
import 'package:vansale/screens/shipping/return_basket.dart';
import 'package:vansale/screens/shipping/return_product.dart';
import 'package:vansale/screens/show_map.dart';
import 'package:vansale/screens/store/store.dart';
import 'package:vansale/screens/shipping/store_shipping.dart';

class ShowBody extends StatefulWidget {
  final String menuid;
  final String typeMenuCode;
  ShowBody(
    this.menuid,
    this.typeMenuCode,
  );

  @override
  _ShowBodyState createState() => _ShowBodyState();
}

class _ShowBodyState extends State<ShowBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _showmenu(),
    );
  }

  _showmenu() {
    switch (widget.menuid) {
      case '0':
        return Container(
          child: HomePage(widget.typeMenuCode),
        );
        break;
      case '1':
        return Container(
          child: Order(widget.typeMenuCode),
        );
        break;
      case '2':
        return Container(
          child: DeliveryList(widget.typeMenuCode),
        );
        break;
      case '3':
        return Container(
          child: Store(widget.typeMenuCode),
        );
        break;
      case '4':
        return Container(
          child: ShowMap(),
        );
        break;
      case '5':
        return Container(
          child: Refuel(widget.typeMenuCode),
        );
        break;
      case '6':
        return Container(
          child: RefuelAdd(widget.typeMenuCode),
        );
        break;
      case '7':
        return Container(
          child: RefuelDetail(widget.typeMenuCode),
        );
        break;
      case '8':
        return Container(
          child: Province(),
        );
        break;
      case '9':
        return Container(
          child: District(),
        );
        break;
      case '10':
        return Container(
          child: County(),
        );
        break;
      case '11':
        return Container(
          child: SupShipping(widget.typeMenuCode),
        );
        break;
      case '12':
        return Container(
          child: StoreShipping(widget.typeMenuCode),
        );
        break;
      case '13':
        return Container(
          child: ReturnBasket(),
        );
        break;
      case '14':
        return Container(
          child: ReturnProduct(),
        );
        break;
    }
  }
}
