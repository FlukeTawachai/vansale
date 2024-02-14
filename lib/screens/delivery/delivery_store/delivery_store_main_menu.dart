import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/ic_vp_icons.dart';
import 'package:vansale/screens/Supplier/Pay/pay_main.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryHistory.dart';
import 'package:vansale/screens/Supplier/supplier/confirmPages.dart';
import 'package:vansale/screens/Supplier/supplier/getGoodProductsCheck.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_store_shipping_home.dart';
import 'package:vansale/screens/home/home.dart';

class DeliveryStoreMainMenu extends StatefulWidget {
  final String typeMenuCode;
  DeliveryStoreMainMenu(this.typeMenuCode);

  @override
  State<DeliveryStoreMainMenu> createState() => _DeliveryStoreMainMenuState();
}

class _DeliveryStoreMainMenuState extends State<DeliveryStoreMainMenu> {
  var storemenu = [
    {
      "name": "ส่งสินค้า",
      "menu": "ST001",
    },
    {
      "name": "คืนสินค้าดี",
      "menu": "ST002",
    },
    {
      "name": "คืนสินค้าเสีย",
      "menu": "ST003",
    },
    {
      "name": "ชำระเงิน",
      "menu": "ST004",
    },
    {
      "name": "เอกสาร",
      "menu": "ST005",
    },
    {
      "name": "คืนตระกร้า",
      "menu": "ST006",
    },
    {
      "name": "เยี่ยม",
      "menu": "ST007",
    },
  ];

  var newStoreMenu = [
    {
      "name": "ส่งสินค้า",
      "menu": "ST001",
    },
    {
      "name": "จองสินค้า",
      "menu": "ST002",
    },
    {
      "name": "ปิดบัญชี",
      "menu": "ST003",
    },
    {
      "name": "เอกสาร",
      "menu": "ST004",
    },
    {
      "name": "ร้านค้าปิด",
      "menu": "ST005",
    },
  ];
  Icvp aaa;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      //physics: new NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15.0),
      itemCount: newStoreMenu.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        /*childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height)/2.2,*/
      ),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          //margin: const EdgeInsets.all(5.0),
          child: new InkWell(
            onTap: () {
              _gotoPage(index);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: newMenuIcon(index),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      newStoreMenu[index]['name'],
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _gotoPage(index) {
    switch (storemenu[index]["menu"]) {
      case "ST001":
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                DeliveryStoreShippingHome(widget.typeMenuCode),
          ),
        );
        break;
      // case "ST002":
      //   return Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (BuildContext context) =>
      //           GetGoodProductsCheck(widget.typeMenuCode, 0, () {
      //         Navigator.of(context).push(MaterialPageRoute(
      //             builder: (comtext) =>
      //                 ConfirmPages(widget.typeMenuCode, "รับสินค้าดี")));
      //         Future.delayed(Duration(seconds: delay.getTimeDelay()), () {
      //           Navigator.of(context).pushAndRemoveUntil(
      //               MaterialPageRoute(
      //                   builder: (context) => HomePage(widget.typeMenuCode)),
      //               (route) => false);
      //         });
      //       }),
      //     ),
      //   );
      //   break;
      case "ST002":
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                DeliveryHistory(widget.typeMenuCode),
          ),
        );
        break;
    }
  }

  Widget menuicon(index) {
    Widget menuicon;
    switch (storemenu[index]['menu']) {
      case "ST001":
        return menuicon = Icon(
          LineAwesomeIcons.dolly,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST002":
        return menuicon = Icon(
          Icvp.undo_alt_solid,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST003":
        return menuicon = Icon(
          Icvp.redo_alt_solid,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST004":
        return menuicon = Icon(
          Icvp.credit_card,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST005":
        return menuicon = Icon(
          Icvp.file_invoice_solid,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST006":
        return menuicon = Icon(
          Icvp.shopping_basket_solid,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST007":
        return menuicon = Icon(
          Icvp.truck_solid,
          color: Colors.green,
          size: 35.0,
        );
        break;
    }
    return menuicon;
  }

  Widget newMenuIcon(index) {
    Widget menuicon;
    switch (storemenu[index]['menu']) {
      case "ST001":
        return menuicon = Icon(
          LineAwesomeIcons.dolly,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST002":
        return menuicon = Icon(
          Icvp.undo_alt_solid,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST003":
        return menuicon = Icon(
          LineAwesomeIcons.product_hunt,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST004":
        return menuicon = Icon(
          Icvp.credit_card,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST005":
        return menuicon = Icon(
          Icvp.file_invoice_solid,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST006":
        return menuicon = Icon(
          Icvp.shopping_basket_solid,
          color: Colors.green,
          size: 35.0,
        );
        break;
    }
    return menuicon;
  }
}
