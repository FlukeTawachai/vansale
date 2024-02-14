import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/response/routeMobile/getSaleStoreOrderResp.dart';
import 'package:vansale/ic_vp_icons.dart';
import 'package:vansale/screens/Supplier/PayForBasketReturn/pay_main_for_basketReturn.dart';
import 'package:vansale/screens/Supplier/shipping/BasketsReturnForBkReturn.dart';
import 'package:vansale/screens/sale/survey/sale_saleSelect.dart';

class SaleStoreMainMenu extends StatefulWidget {
  final String typeMenuCode;
  final GetSaleStoreOrderResp store;
  SaleStoreMainMenu(this.typeMenuCode, this.store);

  @override
  State<SaleStoreMainMenu> createState() => _SaleStoreMainMenuState();
}

class _SaleStoreMainMenuState extends State<SaleStoreMainMenu> {
  List<SaleStoreMainMenuModel> storemenu = [];
  Icvp? aaa;
  @override
  Widget build(BuildContext context) {
    storemenu = [
      SaleStoreMainMenuModel("ขายสินค้า", "ST001"),
      SaleStoreMainMenuModel("ประวัติ", "ST002"),
      SaleStoreMainMenuModel("จองสินค้า", "ST003"),
      SaleStoreMainMenuModel("สินค้าดี", "ST004"),
      SaleStoreMainMenuModel("สินค้าเสีย", "ST005"),
    ];

    if (widget.store.cPOCD!.isNotEmpty) {
      storemenu.addAll([
        SaleStoreMainMenuModel("ตระกร้า", "ST006"),
        SaleStoreMainMenuModel("ชำระเงิน", "ST007"),
      ]);
    }

    storemenu.addAll([
      SaleStoreMainMenuModel("เอกสาร", "ST008"),
      SaleStoreMainMenuModel("เยียม", "ST009"),
    ]);
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
            onTap: () async {
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
                      storemenu[index].name,
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

  _gotoPage(index) async {
    switch (storemenu[index].menu) {
      case "ST001":
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SaleSelectSale(),
          ),
        );
        break;
      case "ST007": // PayBody
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                SupPayBasketReturn(store: widget.store),
          ),
        );
        break;
      case "ST006": // PayBody
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                BasketsReturnForBkReturn(store: widget.store),
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
      // case "ST002":
      //   return Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (BuildContext context) =>
      //           DeliveryHistory(widget.typeMenuCode),
      //     ),
      //   );
      //   break;
    }
  }

  Widget menuicon(index) {
    Widget menuicon = Icon(
      LineAwesomeIcons.dolly,
      color: Colors.green,
      size: 35.0,
    );
    ;
    switch (storemenu[index].menu) {
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
    Widget menuicon = Icon(
      LineAwesomeIcons.dolly,
      color: Colors.green,
      size: 35.0,
    );
    ;
    switch (storemenu[index].menu) {
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
      case "ST007":
        return menuicon = Icon(
          Icvp.coins_solid,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST008":
        return menuicon = Icon(
          Icvp.file_invoice_solid,
          color: Colors.green,
          size: 35.0,
        );
        break;
      case "ST009":
        return menuicon = Icon(
          Icvp.shipping_fast_solid,
          color: Colors.green,
          size: 35.0,
        );
        break;
    }
    return menuicon;
  }
}

class SaleStoreMainMenuModel {
  String name;
  String menu;
  SaleStoreMainMenuModel(this.name, this.menu);
}
