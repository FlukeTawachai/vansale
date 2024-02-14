import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/common_screen.dart/appbar.dart';
import 'package:vansale/ic_vp_icons.dart';
import 'package:vansale/screens/Supplier/Pay/pay_main.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryHistory.dart';
import 'package:vansale/screens/Supplier/models/delayTime.dart';
import 'package:vansale/screens/Supplier/shipping/%E0%B8%BABasketsReturn.dart';
import 'package:vansale/screens/Supplier/shipping/buyConfirm.dart';
import 'package:vansale/screens/Supplier/supplier/confirmPages.dart';
import 'package:vansale/screens/Supplier/supplier/getGoodProductsCheck.dart';
import 'package:vansale/screens/Supplier/supplier/getProductsCheck.dart';

DelayTime delay = new DelayTime();

class GridMenuStore extends StatefulWidget {
  final String typeMenuCode;
  GridMenuStore(this.typeMenuCode);
  @override
  _GridMenuStoreState createState() => _GridMenuStoreState();
}

class _GridMenuStoreState extends State<GridMenuStore> {
  var storemenu = [
    {
      "name": "ขายสินค้า",
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
      "name": "คืนตะกร้า",
      "menu": "ST006",
    },
    {
      "name": "ประวัติ",
      "menu": "ST007",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      //physics: new NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15.0),
      itemCount: storemenu.length,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => _gotoPage(index),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: menuicon(index),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      storemenu[index]['name'],
                      style: TextStyle(fontSize: 12.0),
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
        return BuyConfirm(typeMenuCode: widget.typeMenuCode);
        // AppbarPage(12.toString(), widget.typeMenuCode);
        break;
      case "ST002":
        return GetGoodProductsCheck('new', 0, () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (comtext) => ConfirmPages(GlobalParam.typeMenuCode, "รับสินค้าดี")));
          Future.delayed(Duration(seconds: delay.getTimeDelay()), () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => AppbarPage(11.toString(), GlobalParam.typeMenuCode)),
                (Route<dynamic> route) => false);
          });
        });
        // AppbarPage(14.toString(), widget.typeMenuCode);
        break;
      case "ST003":
        return GetProductsCheck('new', 0, () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (comtext) => ConfirmPages(GlobalParam.typeMenuCode, "รับสินค้าชำรุด")));
          Future.delayed(Duration(seconds: delay.getTimeDelay()), () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => AppbarPage(11.toString(), GlobalParam.typeMenuCode)),
                (Route<dynamic> route) => false);
          });
        });
        break;
      case "ST004":
        return SupPay();
        break;
      case "ST005":
        return AppbarPage(13.toString(), widget.typeMenuCode);
        break;
      case "ST006":
        return BasketReturn(typeMenuCode: widget.typeMenuCode);
        break;
      case "ST007":
        return DeliveryHistory(widget.typeMenuCode);
        break;
      default:
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
          color: Colors.red,
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
}
