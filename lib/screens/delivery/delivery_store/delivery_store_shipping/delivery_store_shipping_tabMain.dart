import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/screens/delivery/delivery_store/delivery_store_shipping/delivery_store_tab_shipping.dart';

class DeliveryStoreShippingTabMain extends StatefulWidget {
  final String typeMenuCode;
  DeliveryStoreShippingTabMain(this.typeMenuCode);

  @override
  State<DeliveryStoreShippingTabMain> createState() =>
      _DeliveryStoreShippingTabMainState();
}

class _DeliveryStoreShippingTabMainState
    extends State<DeliveryStoreShippingTabMain> {
      double widthScreen;
  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        // appBar: AppBar(
        //   toolbarHeight: 90.0,
        //   backgroundColor: HexColor("#6c7e9b"),
        //   title:
        //   leading: Container(),
        //   elevation: 0.0,
        // ),
        body: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 72, 0, 0),
          child: DeliveryStoreTabShipping(widget.typeMenuCode),
        ),
        Container(
          width: widthScreen,
          height: 72.0,
          color: HexColor("#6c7e9b"),
          padding: const EdgeInsets.all(5.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Container(
                  alignment: Alignment.topLeft,
                  width: 60.0,
                  height: 60.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey,
                    image: GlobalParam.deliverySelectStore.cPHOTOPATH != ''
                        ? DecorationImage(
                            image: new NetworkImage(
                              'http://${GlobalParam.deliverySelectStore.cPHOTOSERV}/${GlobalParam.deliverySelectStore.cPHOTOPATH}',
                            ),
                            scale: 1.0,
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: new AssetImage(
                              "assets/images/no_image.png",
                            ),
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
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            GlobalParam.deliverySelectStore.cCUSTNM,
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
                            "${GlobalParam.deliverySelectStore.cADDRESS} ${GlobalParam.deliverySelectStore.cSUBDIST} ${GlobalParam.deliverySelectStore.cDISTRICT} ${GlobalParam.deliverySelectStore.cPROVINCE} ${GlobalParam.deliverySelectStore.cPOSTCD}",
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
              ),
            ],
          ),
        ),
      ],
    )
        // DefaultTabController(
        //   length: 2,
        //   initialIndex: 0,
        //   child: Scaffold(
        //     appBar: PreferredSize(
        //       preferredSize: Size.fromHeight(50.0), // here the desired height
        //       child: AppBar(
        //         elevation: 0.0,
        //         backgroundColor: Colors.white,
        //         centerTitle: true,
        //         bottom: TabBar(
        //           indicatorColor: Colors.green,
        //           labelColor: Colors.green,
        //           unselectedLabelColor: Colors.black38,
        //           labelStyle: TextStyle(
        //               fontSize: 16.0,
        //               fontFamily: 'Prompt',
        //               fontWeight: FontWeight.bold),
        //           tabs: [
        //             Tab(
        //               text: 'ส่งสินค้า',
        //             ),
        //             Tab(
        //               text: 'ไม่รับสินค้า',
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     body: TabBarView(
        //       children: [
        //         Container(
        //           color: HexColor("#F2F3F4"),
        //           child: DeliveryStoreTabShipping(widget.typeMenuCode),
        //         ),
        //         Container(
        //           color: HexColor("#F2F3F4"),
        //           child: ShippingListReturn(widget.typeMenuCode),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
