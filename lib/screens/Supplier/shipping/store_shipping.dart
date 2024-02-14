import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/screens/shipping/shipping_list.dart';
import 'package:vansale/screens/shipping/shipping_list_return.dart';

class StoreShipping extends StatefulWidget {
  //const StoreShipping({ Key? key }) : super(key: key);
  final String typeMenuCode;
  StoreShipping(this.typeMenuCode);
  @override
  _StoreShippingState createState() => _StoreShippingState();
}

class _StoreShippingState extends State<StoreShipping> {
  String total = '5200.00';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.0,
        backgroundColor: HexColor("#6c7e9b"),
        title: Container(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: 60.0,
                    height: 60.0,
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                      image: new DecorationImage(
                        image: new AssetImage('assets/images/brandon.png'),
                        scale: 1.0,
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(150.0)),
                      border: new Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Store Name',
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                fontSize: 14.0,
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'NY , ab.............',
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                fontSize: 12.0,
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        leading: Container(),
        elevation: 0.0,
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
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
                    text: 'ส่งสินค้า',
                  ),
                  Tab(
                    text: 'ไม่รับสินค้า',
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                color: HexColor("#F2F3F4"),
                child: ShippingList(),
              ),
              Container(
                color: HexColor("#F2F3F4"),
                child: ShippingListReturn(widget.typeMenuCode),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
