import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/customer_menu/customer_purchase/customer_view_purchase_order.dart';
import 'package:vansale/screens/delivery/delivery_list.dart';
import 'package:vansale/screens/home/home.dart';

class Confirm2btn extends StatefulWidget {
  final String typeMenuCode;
  final String gotoPage;
  final String title;
  final String detail;
  Confirm2btn(
    this.typeMenuCode,
    this.gotoPage,
    this.title,
    this.detail,
  );

  @override
  State<Confirm2btn> createState() => _Confirm2btnState();
}

class _Confirm2btnState extends State<Confirm2btn> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Icon(
                  LineAwesomeIcons.check_circle,
                  color: Colors.green,
                  size: 150.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  widget.detail,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          height: 80.0,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 0.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomePage(widget.typeMenuCode),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 35.0,
                            alignment: Alignment.center,
                            child: Icon(
                              LineAwesomeIcons.arrow_left,
                              color: Colors.black,
                              size: 25.0,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'กลับหน้าหลัก',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 0.0,
                  child: InkWell(
                    onTap: () {
                      gotoPage();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 35.0,
                          alignment: Alignment.center,
                          child: Icon(
                            LineAwesomeIcons.check_circle,
                            color: Colors.green,
                            size: 25.0,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            btn2Name(),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.green,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  gotoPage() {
    switch (widget.typeMenuCode) {
      case "T001":
        switch (widget.gotoPage) {
          case "DeliveryStartWork":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DeliveryList(widget.typeMenuCode),
              ),
            );
            break;
        }
        break;
      case "T003":
        switch (widget.gotoPage) {
          case "CustomerPurchaseOrder":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    CustomerViewPurchaseOrder(widget.typeMenuCode),
              ),
            );
            break;
          case "CustomerPurchaseOrderEdit":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    CustomerViewPurchaseOrder(widget.typeMenuCode),
              ),
            );
            break;
          case "CustomerPurchaseOrderMoreItem":
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    CustomerViewPurchaseOrder(widget.typeMenuCode),
              ),
            );
            break;
        }
        break;
    }
  }

  btn2Name() {
    switch (widget.typeMenuCode) {
      case "T001":
        switch (widget.gotoPage) {
          case "DeliveryStartWork":
            return "ทำรายการ";
            break;
        }
        break;
      case "T003":
        switch (widget.gotoPage) {
          case "CustomerPurchaseOrder":
            return "ดูรายละเอียด";
            break;
          case "CustomerPurchaseOrderEdit":
            return "ดูรายละเอียด";
            break;
          case "CustomerPurchaseOrderMoreItem":
            return "ดูรายละเอียด";
            break;
        }
        break;
    }
  }
}
