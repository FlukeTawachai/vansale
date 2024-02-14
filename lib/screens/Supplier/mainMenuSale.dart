import 'package:flutter/material.dart';
import 'package:vansale/common_screen.dart/appbar.dart';
import 'package:vansale/screens/Supplier/Pay/pay_main.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryHistory.dart';
import 'package:vansale/screens/Supplier/models/delayTime.dart';
import 'package:vansale/screens/Supplier/shipping/%E0%B8%BABasketsReturn.dart';
import 'package:vansale/screens/Supplier/shipping/buyConfirm.dart';
import 'package:vansale/screens/Supplier/supplier/confirmPages.dart';
import 'package:vansale/screens/Supplier/supplier/getGoodProductsCheck.dart';
import 'package:vansale/screens/Supplier/supplier/getProductsCheck.dart';
import 'package:vansale/screens/main_menu/main_menu.dart';


DelayTime delay = new DelayTime();

class GridMenuDelivery extends StatefulWidget {
  final String typeMenuCode;
  GridMenuDelivery(this.typeMenuCode);
  @override
  _GridMenuDeliveryState createState() => _GridMenuDeliveryState();
}

class _GridMenuDeliveryState extends State<GridMenuDelivery> {
  var storemanu = [
    {
      "icon": "0xea9b",
      "name": "ขายสินค้า",
      "icon_size": "35.0",
      "menu": "ST001",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xed4d",
      "name": "รับคืนสินค้าดี",
      "icon_size": "35.0",
      "menu": "ST002",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xed4d",
      "name": "รับคืนสินค้าเสีย",
      "icon_size": "35.0",
      "menu": "ST003",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xed46",
      "name": "คืนตะกร้า",
      "icon_size": "35.0",
      "menu": "ST004",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xed46",
      "name": "เอกสาร",
      "icon_size": "35.0",
      "menu": "ST005",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xea63",
      "name": "ชำระเงิน",
      "icon_size": "35.0",
      "menu": "ST006",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xed46",
      "name": "ประวัติ",
      "icon_size": "35.0",
      "menu": "ST007",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      //physics: new NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15.0),
      itemCount: storemanu.length,
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
                  builder: (BuildContext context) =>
                      showmenu(storemanu[index]['menu']),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Expanded(
                  child: Container(
                    child: Icon(
                      menus[index]['icon'],
                      color: Colors.green,
                      size: menus[index]['size'],
                    ),
                  ),
                ),*/
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      IconData(
                          int.parse(
                            storemanu[index]['icon'],
                          ),
                          fontFamily: 'vp_custom'),
                      color: Colors.green,
                      size: double.parse(storemanu[index]['icon_size']),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      storemanu[index]['name'],
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        fontSize: double.parse(storemanu[index]['font_size']),
                      ),
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

  showmenu(String menuid) {
    switch (menuid) {
      case "ST001":
        return BuyConfirm(typeMenuCode: widget.typeMenuCode);
        // AppbarPage(12.toString(), widget.typeMenuCode);
        break;
      case "ST002":
        return GetGoodProductsCheck('new', 0, () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (comtext) => ConfirmPages("T002", "รับสินค้าดี")));
          Future.delayed(Duration(seconds: delay.getTimeDelay()), () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MainMenu("T002")),
                (Route<dynamic> route) => false);
          });
        });
        // AppbarPage(14.toString(), widget.typeMenuCode);
        break;
      case "ST003":
        return GetProductsCheck('new', 0, () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (comtext) => ConfirmPages("T002", "รับสินค้าชำรุด")));
          Future.delayed(Duration(seconds: delay.getTimeDelay()), () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MainMenu("T002")),
                (Route<dynamic> route) => false);
          });
        });
        break;
      case "ST004":
        return BasketReturn(typeMenuCode: widget.typeMenuCode);
        break;
      case "ST005":
        return AppbarPage(13.toString(), widget.typeMenuCode);
        break;
      case "ST006":
        return SupPay();
        break;
      case "ST007":
        return DeliveryHistory(widget.typeMenuCode);
        break;
      default:
    }
  }
}
