import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/Supplier/delivery/delivery_list_today.dart';
import 'package:vansale/screens/Supplier/delivery/delivery_list_tomorrow.dart';
import 'package:vansale/screens/Supplier/delivery/delivery_list_yesterday.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/dateExtension.dart';

class SupDeliveryList extends StatefulWidget {
  //const DeliveryList({ Key? key }) : super(key: key);
  final String typeMenuCode;
  SupDeliveryList(this.typeMenuCode);
  @override
  _SupDeliveryListState createState() => _SupDeliveryListState();
}

class _SupDeliveryListState extends State<SupDeliveryList> {
  DateTime dateNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            'ส่งสินค้า (10/15)',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Prompt',
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(LineAwesomeIcons.home))
          ]),
      body: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0), // here the desired height
              child: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                centerTitle: true,
                bottom: TabBar(
                  indicatorColor: Colors.green,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black38,
                  labelStyle: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Prompt',
                      fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      text: '${dateNow.prtYesterday()}',
                    ),
                    Tab(
                      text:
                          dateNow.isToday() ? 'Today' : '${dateNow.prtToday()}',
                    ),
                    Tab(
                      text: '${dateNow.prtTomorrow()}',
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(children: [
              DeliveryListYesterday("T002"),
              DeliveryListToday("T002"),
              DeliveryListTomorow("T002"),
            ])),
      ),
    );
  }
}
