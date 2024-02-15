import 'package:flutter/material.dart';
import 'package:vansale/common_screen.dart/appbar.dart';
import 'package:vansale/screens/Pay/pay_main.dart';
import 'package:vansale/screens/Supplier/delivery/delivery_list.dart';
import 'package:vansale/screens/Supplier/supplier/basket.dart';
import 'package:vansale/screens/Supplier/supplier/getBadProducts.dart';
import 'package:vansale/screens/Supplier/supplier/getGoodProducts.dart';
import 'package:vansale/screens/Supplier/supplier/getProducts.dart';
import 'package:vansale/screens/Supplier/supplier/orderOFbranch.dart';
import 'package:vansale/screens/Supplier/supplier/productOrder.dart';
import 'package:vansale/screens/Supplier/transfer/transferInOut.dart';
import 'package:vansale/screens/customer/customer_home.dart';
import 'package:vansale/screens/customer/history.dart';
import 'package:vansale/screens/customer/transfer_payment.dart';
import 'package:vansale/screens/delivery/delivery_list.dart';
import 'package:vansale/screens/customer/order.dart';

class GridMainSupplier extends StatefulWidget {
  final String typeMenuCode;
  GridMainSupplier(this.typeMenuCode);
  @override
  _GridMainSupplierState createState() => _GridMainSupplierState();
}

class _GridMainSupplierState extends State<GridMainSupplier> {
  var menus = [
    {
      "icon": "0xe99b",
      "name": "ทำรายการ",
      "icon_size": "35.0",
      "menu": "001",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xeecf",
      "name": "โอนย้ายสินคัา",
      "icon_size": "35.0",
      "menu": "002",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xe9b0",
      "name": "สรุปงาน",
      "icon_size": "35.0",
      "menu": "003",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xeecf",
      "name": "ชำระเงิน",
      "icon_size": "35.0",
      "menu": "004",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xee03",
      "name": "ลูกค้า",
      "icon_size": "35.0",
      "menu": "005",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xeb48",
      "name": "เติมน้ำมัน",
      "icon_size": "35.0",
      "menu": "006",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
  ];
  var suppliermenu = [
    {
      "icon": "0xed91",
      "name": "รวมทุกสาขา",
      "icon_size": "35.0",
      "menu": "007",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xe9b0",
      "name": "แยกตาม",
      "icon_size": "35.0",
      "menu": "008",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xee03",
      "name": "รับตะกร้า",
      "icon_size": "35.0",
      "menu": "009",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xeb48",
      "name": "รับสินค้าดี",
      "icon_size": "35.0",
      "menu": "010",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xea9c",
      "name": "รับสินค้าเสีย",
      "icon_size": "35.0",
      "menu": "011",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xee73",
      "name": "รับสินค้าชำรุด",
      "icon_size": "35.0",
      "menu": "012",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
  ];
  var customermenu = [
    {
      "icon": "0xebdb",
      "name": "หน้าแรก",
      "icon_size": "35.0",
      "menu": "013",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xed91",
      "name": "สั่งซื้อ",
      "icon_size": "35.0",
      "menu": "014",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xee46",
      "name": "ประวัติ",
      "icon_size": "35.0",
      "menu": "015",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xeca5",
      "name": "โอนเงิน",
      "icon_size": "35.0",
      "menu": "016",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
    {
      "icon": "0xeaff",
      "name": "แจ้งโอนเงิน",
      "icon_size": "35.0",
      "menu": "017",
      "icon_fontFamily": 'vp_custom',
      "font_size": "10.0",
    },
  ];
  dynamic menuname = "Order()";
  String pref = "0002";
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      //physics: new NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15.0),
      itemCount: countMenu(widget.typeMenuCode),
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
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      mapMenu(index, widget.typeMenuCode),
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
                    child: iconmenu(index, widget.typeMenuCode),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: _listmenu(index, widget.typeMenuCode),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

//go to page
  showmenu(String menuid) {
    print(menuid);
    switch (menuid) {
      case "001":
        return Order(widget.typeMenuCode);
        break;
      case "002":
        return DeliveryList(widget.typeMenuCode);
        break;
      case "003":
        return AppbarPage(3.toString(), widget.typeMenuCode);
        break;
      case "004":
        return AppbarPage(5.toString(), widget.typeMenuCode);
        break;
    }
  }

  Widget _listmenu(index, String menutype) {
    Widget menuname = Text(
      menus[index]['name']!,
      style: TextStyle(
        fontFamily: 'Prompt',
        fontSize: double.parse(menus[index]['font_size']!),
      ),
    );
    switch (menutype) {
      case "T001":
        return menuname = Text(
          menus[index]['name']!,
          style: TextStyle(
            fontFamily: 'Prompt',
            fontSize: double.parse(menus[index]['font_size']!),
          ),
        );
        break;
      case "T002":
        return menuname = Text(
          menus[index]['name']!,
          style: TextStyle(
            fontFamily: 'Prompt',
            fontSize: double.parse(menus[index]['font_size']!),
          ),
        );
        break;
      case "T003":
        return menuname = Text(
          customermenu[index]['name']!,
          style: TextStyle(
            fontFamily: 'Prompt',
            fontSize: double.parse(customermenu[index]['font_size']!),
          ),
        );
        break;
      case "T004":
        return menuname = Text(
          menus[index]['name']!,
          style: TextStyle(
            fontFamily: 'Prompt',
            fontSize: double.parse(menus[index]['font_size']!),
          ),
        );
        break;
      case "T005":
        return menuname = Text(
          menus[index]['name']!,
          style: TextStyle(
            fontFamily: 'Prompt',
            fontSize: double.parse(menus[index]['font_size']!),
          ),
        );
        break;
      case "T006":
        return menuname = Text(
          menus[index]['name']!,
          style: TextStyle(
            fontFamily: 'Prompt',
            fontSize: double.parse(menus[index]['font_size']!),
          ),
        );
        break;
      case "T007":
        return menuname = Text(
          menus[index]['name']!,
          style: TextStyle(
            fontFamily: 'Prompt',
            fontSize: double.parse(menus[index]['font_size']!),
          ),
        );
        break;
      case "T008":
        return menuname = Text(
          suppliermenu[index]['name']!,
          style: TextStyle(
            fontFamily: 'Prompt',
            fontSize: double.parse(suppliermenu[index]['font_size']!),
          ),
        );
        break;
    }
    print(menuname);
    return menuname;
  }

  Widget iconmenu(index, String menutype) {
    Widget menuicon = Icon(
      IconData(int.parse(menus[index]['icon']!), fontFamily: 'vp_custom'),
      color: Colors.green,
      size: double.parse(menus[index]['icon_size']!),
    );
    ;
    switch (menutype) {
      case "T001":
        return menuicon = Icon(
          IconData(int.parse(menus[index]['icon']!), fontFamily: 'vp_custom'),
          color: Colors.green,
          size: double.parse(menus[index]['icon_size']!),
        );
        break;
      case "T002":
        return menuicon = Icon(
          IconData(int.parse(menus[index]['icon']!), fontFamily: 'vp_custom'),
          color: Colors.green,
          size: double.parse(menus[index]['icon_size']!),
        );
        break;
      case "T003":
        return menuicon = Icon(
          IconData(int.parse(customermenu[index]['icon']!),
              fontFamily: 'vp_custom'),
          color: Colors.green,
          size: double.parse(customermenu[index]['icon_size']!),
        );
        break;
      case "T004":
        return menuicon = Icon(
          IconData(int.parse(menus[index]['icon']!), fontFamily: 'vp_custom'),
          color: Colors.green,
          size: double.parse(menus[index]['icon_size']!),
        );
        break;
      case "T005":
        return menuicon = Icon(
          IconData(int.parse(menus[index]['icon']!), fontFamily: 'vp_custom'),
          color: Colors.green,
          size: double.parse(menus[index]['icon_size']!),
        );
        break;
      case "T006":
        return menuicon = Icon(
          IconData(int.parse(menus[index]['icon']!), fontFamily: 'vp_custom'),
          color: Colors.green,
          size: double.parse(menus[index]['icon_size']!),
        );
        break;
      case "T007":
        return menuicon = Icon(
          IconData(int.parse(menus[index]['icon']!), fontFamily: 'vp_custom'),
          color: Colors.green,
          size: double.parse(menus[index]['icon_size']!),
        );
        break;
      case "T008":
        return menuicon = Icon(
          IconData(int.parse(suppliermenu[index]['icon']!),
              fontFamily: 'vp_custom'),
          color: Colors.green,
          size: double.parse(suppliermenu[index]['icon_size']!),
        );
        break;
    }
    return menuicon;
  }

  countMenu(String tmenu) {
    int count = 0;
    switch (tmenu) {
      case "T001":
        return count = menus.length;
        break;
      case "T002":
        return count = menus.length;
        break;
      case "T003":
        return count = customermenu.length;
        break;
      case "T004":
        return count = menus.length;
        break;
      case "T005":
        return count = menus.length;
        break;
      case "T006":
        return count = menus.length;
        break;
      case "T007":
        return count = menus.length;
        break;
      case "T008":
        return count = suppliermenu.length;
        break;
    }
    return count;
  }

  mapMenu(index, String mapmenu) {
    print(mapmenu);
    switch (mapmenu) {
      case "T001":
        return lstMenu(menus[index]['menu']!);
        break;
      case "T002":
        return lstMenu(menus[index]['menu']!);
        break;
      case "T003":
        return lstMenu(customermenu[index]['menu']!);
        break;
      case "T004":
        return lstMenu(menus[index]['menu']!);
        break;
      case "T005":
        return lstMenu(menus[index]['menu']!);
        break;
      case "T006":
        return lstMenu(menus[index]['menu']!);
        break;
      case "T007":
        return lstMenu(menus[index]['menu']!);
        break;
      case "T008":
        return lstMenu(suppliermenu[index]['menu']!);
        break;
    }
  }

  lstMenu(String linkmenu) {
    print(linkmenu);
    switch (linkmenu) {
      case "001":
        return SupDeliveryList(widget.typeMenuCode);
        break;
      case "002":
        return TransferInOut("T008");
        break;
      case "003":
        return Order(widget.typeMenuCode);
        break;
      case "004":
        return Pay();
        break;
      case "005":
        return () {};
        break;
      case "006":
        return () {};
        break;
      case "007":
        return ProductOrder();
        break;
      case "008":
        return OrderOfBranch();
        break;
      case "009":
        return Baskets("T008");
        break;
      case "010":
        return GetGoodProducts("T008");
        break;
      case "011":
        return GetProducts("T008");
        break;
      case "012":
        return GetBadProducts("T008");
        break;
      case "013":
        return const CustomerHome(
          key: null,
        );
        break;
      case "014":
        return Order(widget.typeMenuCode);
        break;
      case "015":
        return CustomerHistory(widget.typeMenuCode);
        break;
      case "016":
        return TransferPayment(widget.typeMenuCode);
        break;
      case "017":
        return () {};
        break;
    }
  }
}
