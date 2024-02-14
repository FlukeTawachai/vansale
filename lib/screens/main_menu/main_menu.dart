import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/allApiProxyMobile.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/request/mobile/canclePoByBeforePOReq.dart';
import 'package:vansale/api/class/request/mobile/createPoByBeforePOReq.dart';
import 'package:vansale/api/class/request/mobile/getStartWorkReq.dart';
import 'package:vansale/api/class/request/mobile/startStopWorkReq.dart';
import 'package:vansale/screens/Supplier/delivery/delivery_list.dart';
import 'package:vansale/screens/Supplier/delivery/money/delivery_money_main.dart';
import 'package:vansale/screens/Supplier/delivery/refuel/delivery_refuel_main.dart';
import 'package:vansale/screens/Supplier/supplier/basket.dart';
import 'package:vansale/screens/Supplier/supplier/getBadProducts.dart';
import 'package:vansale/screens/Supplier/supplier/getGoodProducts.dart';
import 'package:vansale/screens/Supplier/supplier/getProducts.dart';
import 'package:vansale/screens/Supplier/supplier/orderOFbranch.dart';
import 'package:vansale/screens/Supplier/supplier/productOrder.dart';
import 'package:vansale/screens/Supplier/transfer/tranferProducts.dart';
import 'package:vansale/screens/Supplier/transfer/transferInOut.dart';
import 'package:vansale/screens/Supplier/transfer/transferSort.dart';
import 'package:vansale/screens/branch_warehouse/branch_warehouse_transfer/branch_warehouse_transfer_main.dart';
import 'package:vansale/screens/customer_menu/customer_home/customer_main_page.dart';
import 'package:vansale/screens/customer_menu/customer_purchase/customer_purchase_order.dart';
import 'package:vansale/screens/customer_menu/customer_purchase/customer_purchase_history.dart';
import 'package:vansale/screens/customer_menu/customer_purchase/customer_transfer_payment.dart';
import 'package:vansale/screens/customer_menu/custommer_Order/customer_add_order.dart';
import 'package:vansale/screens/delivery/delivery_list.dart';
import 'package:vansale/screens/delivery/delivery_map/map_selectBranch.dart';
import 'package:vansale/screens/delivery/delivery_money/delivery_money_main.dart';
import 'package:vansale/screens/delivery/delivery_money/delivery_money_new.dart';
import 'package:vansale/screens/delivery/delivery_new_supplier/delivery_new_supplier_main.dart';
import 'package:vansale/screens/delivery/delivery_refuel/delivery_refuel_main.dart';
import 'package:vansale/screens/delivery/delivery_startwork/delivery_startwork_main.dart';
import 'package:vansale/screens/namo/signature_screen.dart';
import 'package:vansale/screens/sale/sale_transfer_product/sale_transfer_product_main.dart';
import 'package:vansale/screens/sale/survey/sale_delivery.dart';
import 'package:vansale/screens/startwork.dart';
import 'package:vansale/screens/stocks/stockOrderList.dart';
import 'package:vansale/screens/stocks/stock_recheck/recheck_stock.dart';
import 'package:vansale/screens/stocks/stock_transfer/stock_transfer_select.dart';
import 'package:vansale/screens/stocks/stoeck_return/stock_return_supplier.dart';
import 'package:vansale/screens/warehouse3/warehouse3_prepare_order/warehouse3_search_route..dart';

class MainMenu extends StatefulWidget {
  final String typeMenuCode;
  MainMenu(this.typeMenuCode);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  var startWork = [
    {"name": "Start Work", "menu": "001"},
  ];
  var menus = [
    {
      "name": "ทำรายการ",
      "menu": "001",
    },
    {
      "name": "สรุปงาน",
      "menu": "002",
    },
    {
      "name": "ร้านค้า",
      "menu": "003",
    },
    {
      "name": "น้ำมัน",
      "menu": "004",
    },
    {
      "name": "ส่งเงิน",
      "menu": "005",
    },
    {
      "name": "โอนย้าย",
      "menu": "006",
    },
  ];

  var newMenus = [
    {
      "name": "ทำรายการ",
      "menu": "001",
    },
    {
      "name": "ขึ้นสินค้า",
      "menu": "002",
    },
    {
      "name": "ร้านค้า",
      "menu": "003",
    },
    {
      "name": "น้ำมัน",
      "menu": "004",
    },
    {
      "name": "ส่งเงิน",
      "menu": "005",
    },
    {
      "name": "สรุปงาน",
      "menu": "006",
    },
    {
      "name": "เรียงร้าน",
      "menu": "007",
    },
    {
      "name": "แผนที่",
      "menu": "008",
    },
    {
      "name": "Start Work",
      "menu": "009",
    },
  ];

  var stockMenu = [
    {
      "name": "รับสินค้า",
      "menu": "001",
    },
    {
      "name": "คืนตะกร้า",
      "menu": "002",
    },
    {
      "name": "รับจากขนส่ง",
      "menu": "003",
    },
    {
      "name": "โอนย้าย",
      "menu": "004",
    },
    {
      "name": "นับสต็อก",
      "menu": "005",
    },
    {
      "name": "สรุปงาน",
      "menu": "006",
    },
  ];
  var saleordermenu = [
    {
      "name": "ทำรายการ",
      "menu": "001",
    },
    {
      "name": "โอนย้าย",
      "menu": "002",
    },
    {
      "name": "ร้านค้า",
      "menu": "003",
    },
    {
      "name": "น้ำมัน",
      "menu": "004",
    },
    {
      "name": "ส่งเงิน",
      "menu": "005",
    },
    {
      "name": "สรุปงาน",
      "menu": "006",
    },
    {
      "name": "เรียงร้าน",
      "menu": "007",
    },
    {
      "name": "แผนที่",
      "menu": "008",
    },
    {
      "name": "Start Work",
      "menu": "009",
    },
  ];
  var suppliermenu = [
    {
      "name": "รวมทุกสาขา",
      "menu": "001",
    },
    {
      "name": "แยกตาม",
      "menu": "002",
    },
    {
      "name": "รับตะกร้า",
      "menu": "003",
    },
    {
      "name": "สินค้าดี",
      "menu": "004",
    },
    {
      "name": "สินค้าเสีย",
      "menu": "005",
    },
    {
      "name": "รับสินค้าชำรุด",
      "menu": "006",
    },
  ];
  var customermenu = [
    {
      "name": "หน้าแรก",
      "menu": "001",
    },
    {
      "name": "สั่งซื้อ",
      "menu": "002",
    },
    {
      "name": "ประวัติ",
      "menu": "003",
    },
    {
      "name": "สั่งซื้อล่าสุด",
      "menu": "004",
    },
    {
      "name": "ไม่สั่งซื้อ",
      "menu": "005",
    },
    {
      "name": "โอนเงิน",
      "menu": "006",
    },
  ];
  var warehouse3 = [
    {
      "name": "จัดสินค้า",
      "menu": "001",
    },
    {
      "name": "สรุปงาน",
      "menu": "002",
    },
    {
      "name": "สินค้ารอจัด",
      "menu": "003",
    },
  ];

  var signatureMenu = [
    {
      "name": "ลายเซ็น",
      "menu": "001",
    },
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStartWork();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.typeMenuCode);
    return GlobalParam.typeMenuCode == "T001" ||
            GlobalParam.typeMenuCode == "T002"
        ? GridView.builder(
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
                color: GlobalParam.startWorkList.isNotEmpty
                    ? Colors.white
                    : GlobalParam.typeMenuCode == "T001"
                        ? index == 8
                            ? Colors.white
                            : Colors.grey.shade300
                        : GlobalParam.typeMenuCode == "T002"
                            ? index == 8
                                ? Colors.white
                                : Colors.grey.shade300
                            : Colors.grey.shade300,
                child: InkWell(
                  onTap: () {
                    if (GlobalParam.typeMenuCode == "T001" && index == 8) {
                      if (GlobalParam.startWorkList.isNotEmpty == false) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                StartWork(GlobalParam.typeMenuCode)));
                        // startStopWork();
                      }
                    }

                    if (GlobalParam.typeMenuCode == "T002" && index == 8) {
                      if (GlobalParam.startWorkList.isNotEmpty == false) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                StartWork(GlobalParam.typeMenuCode)));
                        // startStopWork();
                      }
                    }
                    if (GlobalParam.startWorkList.isNotEmpty == true) {
                      gotoPage(index);
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: menuicon(index, widget.typeMenuCode),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: menuName(index, widget.typeMenuCode),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : GridView.builder(
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
                child: InkWell(
                  onTap: () {
                    gotoPage(index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: menuicon(index, widget.typeMenuCode),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: menuName(index, widget.typeMenuCode),
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
  gotoPage(index) {
    switch (widget.typeMenuCode) {
      case "T001":
        switch (newMenus[index]['menu']) {
          case "001":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DeliveryList(widget.typeMenuCode),
              ),
            );
            break;
          case "002":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    TranferProducts(typeMenuCode: widget.typeMenuCode),
              ),
            );
            break;
          case "003":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DeliveryNewSupplierMain(widget.typeMenuCode),
              ),
            );
            break;
          case "004":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DeliveryRefuelMain(widget.typeMenuCode),
              ),
            );
            break;
          case "005":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DeliveryMoneyNew(widget.typeMenuCode),
              ),
            );
            break;
          case "006":
            return () {};
            break;
          case "007":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => TranferSort(),
              ),
            );

            break;
          case "008":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SelectBranchMap(),
              ),
            );
            break;
          case "009":
            return Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StartWork(GlobalParam.typeMenuCode)));
            break;
        }
        break;
      case "T002":
        switch (saleordermenu[index]['menu']) {
          case "001":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    SaleDelivery(widget.typeMenuCode),
              ),
            );
            break;
          case "002":
            return Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BranchWarehouseMain()));
            break;
          case "003":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DeliveryNewSupplierMain(widget.typeMenuCode),
              ),
            );
            break;

          case "004":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    RefuelMain(widget.typeMenuCode),
              ),
            );
            break;
          case "005":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    MoneyMain(widget.typeMenuCode),
              ),
            );
            break;

          case "006":
            return () {};
            break;
          case "007":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => TranferSort(),
              ),
            );
            break;
          case "008":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SelectBranchMap(),
              ),
            );
            break;
          case "009":
            return Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StartWork(GlobalParam.typeMenuCode)));
            break;
        }
        break;

      case "T003":
        switch (menus[index]['menu']) {
          case "001":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    CustomerMainPage(widget.typeMenuCode),
              ),
            );
            break;
          case "002":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    CustomerAddOrder(widget.typeMenuCode, true),
              ),
            );
            break;
          case "003":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    CustomerPurchaseHistory(widget.typeMenuCode),
              ),
            );
            break;
          case "004":
            return confirmDialog('ยืนยันสั่งซื้อสินค้า', '01');
            break;
          case "005":
            return confirmDialog('ยืนยันไม่สั่งซื้อ', '02');
            break;
          case "006":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    CustomerTranserPayment(widget.typeMenuCode),
              ),
            );
            break;
        }
        break;
      case "T004":
        switch (stockMenu[index]['menu']) {
          case "001":
            return Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => StockOrderList()));
            break;
          case "002":
            return Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SupplierList()));
            break;
          case "003":
            return Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => StockSelectGroup()));
            break;
          case "004":
            return Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BranchWarehouseMain(
                      typeMenuCode: widget.typeMenuCode,
                    )));
            break;
          case "005":
            return Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    RecheckProductStock(GlobalParam.typeMenuCode, true)));
            break;
          case "006":
            return () {};
            break;
        }
        break;
      case "T005":
        switch (menus[index]['menu']) {
          case "001":
            return () {};
            break;
          case "002":
            return () {};
            break;
          case "003":
            return () {};
            break;
          case "004":
            return () {};
            break;
          case "005":
            return () {};
            break;
          case "006":
            return () {};
            break;
        }
        break;
      case "T006":
        switch (warehouse3[index]['menu']) {
          case "001":
            GlobalParam.subMenuCode = '001';
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    Warehouse3SearchRoute(widget.typeMenuCode),
              ),
            );
            break;
          case "002":
            return () {};
            break;
          case "003":
            GlobalParam.subMenuCode = '003';
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    Warehouse3SearchRoute(widget.typeMenuCode),
              ),
            );
            break;
          case "004":
            return () {};
            break;
          case "005":
            return () {};
            break;
          case "006":
            return () {};
            break;
        }
        break;
      case "T007":
        switch (menus[index]['menu']) {
          case "001":
            return () {};
            break;
          case "002":
            return () {};
            break;
          case "003":
            return () {};
            break;
          case "004":
            return () {};
            break;
          case "005":
            return () {};
            break;
          case "006":
            return () {};
            break;
        }
        break;
      case "T008":
        switch (menus[index]['menu']) {
          case "001":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProductOrder(),
              ),
            );
            break;
          case "002":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => OrderOfBranch(),
              ),
            );
            break;
          case "003":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Baskets(widget.typeMenuCode),
              ),
            );
            break;
          case "004":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    GetGoodProducts(widget.typeMenuCode),
              ),
            );
            break;
          case "005":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    GetProducts(widget.typeMenuCode),
              ),
            );
            break;
          case "006":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    GetBadProducts(widget.typeMenuCode),
              ),
            );
            break;
        }
        break;
      case "T010":
        switch (menus[index]['menu']) {
          case "001":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SignatureTest(
                  typeMenuCode: widget.typeMenuCode,
                ),
              ),
            );
            break;
        }
        break;
    }
  }

  Widget menuName(index, String menutype) {
    Widget menuname;
    switch (menutype) {
      case "T001":
        return Text(
          newMenus[index]['name'],
          style: TextStyle(fontSize: 14.0),
        );
        break;

      case "T002":
        return Text(
          saleordermenu[index]['name'],
          style: TextStyle(fontSize: 14.0),
        );
        break;
      case "T003":
        return menuname = Text(
          customermenu[index]['name'],
          style: TextStyle(fontSize: 14.0),
        );
        break;
      case "T004":
        return menuname = Text(
          stockMenu[index]['name'],
          style: TextStyle(fontSize: 14.0),
        );
        break;
      case "T005":
        return menuname =
            Text(menus[index]['name'], style: TextStyle(fontSize: 14.0));

        break;
      case "T006":
        return menuname = Text(
          warehouse3[index]['name'],
          style: TextStyle(fontSize: 14.0),
        );
        break;
      case "T007":
        return menuname = Text(
          menus[index]['name'],
          style: TextStyle(fontSize: 14.0),
        );
        break;
      case "T008":
        if (suppliermenu[index]['name'] == "สินค้าเสีย") {
          return menuname = Text(
            suppliermenu[index]['name'],
            style: TextStyle(fontSize: 14.0, color: Colors.red),
          );
        } else {
          return menuname = Text(
            suppliermenu[index]['name'],
            style: TextStyle(
              fontSize: 14.0,
            ),
          );
        }
        break;
      case "T010":
        return menuname = Text(
          signatureMenu[index]['name'],
          style: TextStyle(fontSize: 14.0),
        );
        break;
    }
    return menuname;
  }

  Widget menuicon(index, String menutype) {
    Widget menuicon;
    switch (menutype) {
      case "T001":
        switch (newMenus[index]['menu']) {
          case "001":
            return menuicon = Icon(
              LineAwesomeIcons.shipping_fast,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "002":
            return menuicon = Icon(
              LineAwesomeIcons.boxes,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "003":
            return menuicon = Icon(
              LineAwesomeIcons.store,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "004":
            return menuicon = Icon(
              LineAwesomeIcons.gas_pump,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "005":
            return menuicon = Icon(
              LineAwesomeIcons.donate,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "006":
            return menuicon = Icon(
              LineAwesomeIcons.business_time,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "007":
            return menuicon = Icon(
              LineAwesomeIcons.sort_amount_down,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "008":
            return menuicon = Icon(
              LineAwesomeIcons.map,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "009":
            return menuicon = Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Container(
                height: 48,
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Icon(
                    LineAwesomeIcons.shipping_fast,
                    color: Colors.white,
                    size: 35.0,
                  ),
                ),
                decoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              ),
            );
            break;
        }
        break;
      case "T002":
        switch (saleordermenu[index]['menu']) {
          case "001":
            return menuicon = Icon(
              LineAwesomeIcons.shipping_fast,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "002":
            return menuicon = Icon(
              LineAwesomeIcons.business_time,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "003":
            return menuicon = Icon(
              LineAwesomeIcons.store,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "004":
            return menuicon = Icon(
              LineAwesomeIcons.gas_pump,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "005":
            return menuicon = Icon(
              LineAwesomeIcons.donate,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "006":
            return menuicon = Icon(
              LineAwesomeIcons.business_time,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "007":
            return menuicon = Icon(
              LineAwesomeIcons.sort_amount_down,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "008":
            return menuicon = Icon(
              LineAwesomeIcons.map,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "009":
            return menuicon = Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Container(
                height: 48,
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Icon(
                    LineAwesomeIcons.shipping_fast,
                    color: Colors.white,
                    size: 35.0,
                  ),
                ),
                decoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              ),
            );
            break;
        }
        break;
      case "T003":
        switch (menus[index]['menu']) {
          case "001":
            return menuicon = Icon(
              LineAwesomeIcons.shipping_fast,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "002":
            return menuicon = Icon(
              LineAwesomeIcons.business_time,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "003":
            return menuicon = Icon(
              LineAwesomeIcons.store,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "004":
            return menuicon = Icon(
              LineAwesomeIcons.shopping_basket,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "005":
            return menuicon = Icon(
              LineAwesomeIcons.window_close,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "006":
            return menuicon = Icon(
              LineAwesomeIcons.donate,
              color: Colors.green,
              size: 35.0,
            );
            break;
        }
        break;
      case "T004":
        switch (menus[index]['menu']) {
          case "001":
            return menuicon = Icon(
              LineAwesomeIcons.store,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "002":
            return menuicon = Icon(
              LineAwesomeIcons.shopping_basket,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "003":
            return menuicon = Icon(
              LineAwesomeIcons.shipping_fast,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "004":
            return menuicon = Icon(
              LineAwesomeIcons.alternate_exchange,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "005":
            return menuicon = Icon(
              LineAwesomeIcons.boxes,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "006":
            return menuicon = Icon(
              LineAwesomeIcons.truck,
              color: Colors.green,
              size: 35.0,
            );
            break;
        }
        break;
      case "T005":
        switch (menus[index]['menu']) {
          case "001":
            return menuicon = Icon(
              LineAwesomeIcons.shipping_fast,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "002":
            return menuicon = Icon(
              LineAwesomeIcons.business_time,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "003":
            return menuicon = Icon(
              LineAwesomeIcons.store,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "004":
            return menuicon = Icon(
              LineAwesomeIcons.gas_pump,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "005":
            return menuicon = Icon(
              LineAwesomeIcons.donate,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "006":
            return menuicon = Icon(
              LineAwesomeIcons.truck,
              color: Colors.green,
              size: 35.0,
            );
            break;
        }
        break;
      case "T006":
        switch (menus[index]['menu']) {
          case "001":
            return menuicon = Icon(
              LineAwesomeIcons.shipping_fast,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "002":
            return menuicon = Icon(
              LineAwesomeIcons.business_time,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "003":
            return menuicon = Icon(
              LineAwesomeIcons.box,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "004":
            return menuicon = Icon(
              LineAwesomeIcons.gas_pump,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "005":
            return menuicon = Icon(
              LineAwesomeIcons.donate,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "006":
            return menuicon = Icon(
              LineAwesomeIcons.truck,
              color: Colors.green,
              size: 35.0,
            );
            break;
        }
        break;
      case "T007":
        switch (menus[index]['menu']) {
          case "001":
            return menuicon = Icon(
              LineAwesomeIcons.shipping_fast,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "002":
            return menuicon = Icon(
              LineAwesomeIcons.business_time,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "003":
            return menuicon = Icon(
              LineAwesomeIcons.store,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "004":
            return menuicon = Icon(
              LineAwesomeIcons.gas_pump,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "005":
            return menuicon = Icon(
              LineAwesomeIcons.donate,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "006":
            return menuicon = Icon(
              LineAwesomeIcons.truck,
              color: Colors.green,
              size: 35.0,
            );
            break;
        }
        break;
      case "T008":
        switch (suppliermenu[index]['menu']) {
          case "001":
            return menuicon = Icon(
              LineAwesomeIcons.shipping_fast,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "002":
            return menuicon = Icon(
              LineAwesomeIcons.business_time,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "003":
            return menuicon = Icon(
              LineAwesomeIcons.store,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "004":
            return menuicon = Icon(
              LineAwesomeIcons.gas_pump,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "005":
            return menuicon = Icon(
              LineAwesomeIcons.donate,
              color: Colors.green,
              size: 35.0,
            );
            break;
          case "006":
            return menuicon = Icon(
              LineAwesomeIcons.truck,
              color: Colors.green,
              size: 35.0,
            );
            break;
        }
        break;
      case "T010":
        switch (menus[index]['menu']) {
          case "001":
            return menuicon = Icon(
              LineAwesomeIcons.signature,
              color: Colors.green,
              size: 35.0,
            );
            break;
        }
        break;
    }
    return menuicon;
  }

  countMenu(String tmenu) {
    int count = 0;
    switch (tmenu) {
      case "T001":
        return count = newMenus.length;
        break;
      case "T002":
        return count = saleordermenu.length;
        break;
      case "T003":
        return count = customermenu.length;
        break;
      case "T004":
        return count = stockMenu.length;
        break;
      case "T005":
        return count = menus.length;
        break;
      case "T006":
        return count = warehouse3.length;
        break;
      case "T007":
        return count = menus.length;
        break;
      case "T008":
        return count = suppliermenu.length;
        break;
      case "T010":
        return count = signatureMenu.length;
    }
    return count;
  }

  /*lstMenu(String linkmenu) {
    print(linkmenu);
    switch (linkmenu) {
      case "001":
        return SupDeliveryList(widget.typeMenuCode);
        break;
      case "002":
        return TransferInOut();
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
        return Baskets();
        break;
      case "010":
        return GetGoodProducts();
        break;
      case "011":
        return GetProducts();
        break;
      case "012":
        return GetBadProducts();
        break;
      case "013":
        return CustomerHome();
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
  }*/

  startStopWork() async {
    // if (cVEHINM == '') {
    try {
      // print("************** $nameOfRoute **************");

      AllApiProxyMobile proxy = AllApiProxyMobile();
      String section = '';
      if (GlobalParam.typeMenuCode == 'T001') {
        section = 'TF';
      }
      if (GlobalParam.typeMenuCode == 'T002') {
        section = 'SL';
      }
      if (GlobalParam.typeMenuCode == 'T004') {
        section = 'ST';
      }

      var result = await proxy.startStopWork(StartStopWorkReq(
        cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
        cREFCD: GlobalParam.VEHICLE['cVEHICD'],
        cUSRNM: GlobalParam.userData.cUSRNM,
        cSTATUS: "Y",
        cSECTION: section,
        cCREABY: GlobalParam.userData.cUSRNM,
      ));
      if (result.success == true) {
        // wrongDialog('บันทึกเวลาเริ่มงานสำเร็จ');
        getStartWork();
      }

      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
    // } else {
    //   wrongDialog('ข้อมูลผิดพลาด');
    // }
  }

  createPoByBeforePO() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      String cGRPCD = "";
      final moonLanding = new DateTime.now();
      // print(moonLanding.weekday); // 7
      if (moonLanding.weekday == 1) {
        cGRPCD = "GRSUN";
      } else if (moonLanding.weekday == 2) {
        cGRPCD = "GRMON";
      } else if (moonLanding.weekday == 3) {
        cGRPCD = "GRTUE";
      } else if (moonLanding.weekday == 4) {
        cGRPCD = "GRWED";
      } else if (moonLanding.weekday == 5) {
        cGRPCD = "GRTHU";
      } else if (moonLanding.weekday == 6) {
        cGRPCD = "GRFRI";
      } else if (moonLanding.weekday == 7) {
        cGRPCD = "GRSAT";
      }

      var result = await proxy.createPoByBeforePO(CreatePoByBeforePOReq(
          cCUSTCD: GlobalParam.customer['cCUSTCD'],
          cGRPCD: cGRPCD,
          cCREABY: GlobalParam.userData.cUSRNM));
      if (result.success == true) {
        wrongDialog('สั่งซื้อสำเร็จ');
      } else {
        wrongDialog('${result.message}');
      }

      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  canclePoByBeforePO() async {
    try {
      AllApiProxyMobile proxy = AllApiProxyMobile();
      String cGRPCD = "";
      final moonLanding = new DateTime.now();
      // print(moonLanding.weekday); // 7
      if (moonLanding.weekday == 1) {
        cGRPCD = "GRSUN";
      } else if (moonLanding.weekday == 2) {
        cGRPCD = "GRMON";
      } else if (moonLanding.weekday == 3) {
        cGRPCD = "GRTUE";
      } else if (moonLanding.weekday == 4) {
        cGRPCD = "GRWED";
      } else if (moonLanding.weekday == 5) {
        cGRPCD = "GRTHU";
      } else if (moonLanding.weekday == 6) {
        cGRPCD = "GRFRI";
      } else if (moonLanding.weekday == 7) {
        cGRPCD = "GRSAT";
      }

      var result = await proxy.canclePoByBeforePO(CanclePoByBeforePOReq(
          cCUSTCD: GlobalParam.customer['cCUSTCD'],
          cGRPCD: cGRPCD,
          cUPDABY: GlobalParam.userData.cUSRNM));
      if (result.success == true) {
        wrongDialog('สั่งซื้อสำเร็จ');
      } else {
        wrongDialog('${result.message}');
      }

      // setState(() {});
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }

  wrongDialog(String msg) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: const Text('Information'),
        content: Text(
          msg,
          style: const TextStyle(fontSize: 11.0),
        ),
        actions: <Widget>[
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.8,
          ),
          Container(
            height: 50.0,

            //color: Colors.amber,

            alignment: Alignment.centerRight,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  confirmDialog(String msg, String menu) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        title: menu == '01' ? Text('สั่งซื้อ') : Text('ไม่สั่งซื้อ'),
        content: Text(
          msg,
          style: const TextStyle(fontSize: 11.0),
        ),
        actions: <Widget>[
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 0.8,
          ),
          Container(
            height: 50.0,

            //color: Colors.amber,

            alignment: Alignment.centerRight,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'cancle');
                  },
                  child: const Text('ยกเลิก'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    if (menu == '01') {
                      createPoByBeforePO();
                    }
                    if (menu == '02') {
                      canclePoByBeforePO();
                    }
                  },
                  child: const Text('ยืนยัน'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getStartWork() async {
    try {
      var outputFormat = DateFormat('yyyy-MM-dd');
      var outputDate = outputFormat.format(new DateTime.now());
      AllApiProxyMobile proxy = AllApiProxyMobile();
      String section = '';
      if (GlobalParam.typeMenuCode == 'T001') {
        section = 'TF';
      }
      if (GlobalParam.typeMenuCode == 'T002') {
        section = 'SL';
      }
      if (GlobalParam.typeMenuCode == 'T004') {
        section = 'ST';
      }
      var result = await proxy.getStartWork(GetStartWorkReq(
          cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
          cUSRNM: GlobalParam.userData.cUSRNM,
          cSECTION: section,
          dINVENTDT: outputDate));
      if ((result.isNotEmpty)) {
        // print("+++++++++++++++++ ${result.cPOCD} +++++++++++++++++");
        setState(() {
          GlobalParam.startWorkList = [];
          GlobalParam.startWorkList.addAll(result);
        });
      }
      // print('++++++++++++ ${sumOfStore.length} ++++++++++++');
    } on SocketException catch (e) {
      wrongDialog(e.message);
    } on Exception catch (e) {
      wrongDialog(e.toString());
    }
  }
}
