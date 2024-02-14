import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/common_screen.dart/appbar.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryCheckIn.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryDesMap.dart';
import 'package:vansale/screens/Supplier/delivery/models/store.dart';
import 'package:vansale/screens/googleMap/currentLocation.dart';

class DeliveryCard extends StatefulWidget {
  //const DeliveryListToday({ Key? key }) : super(key: key);
  final String typeMenuCode;
  final StoreModel store;
  DeliveryCard(this.typeMenuCode, this.store);
  @override
  _DeliveryCardState createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      color: HexColor("#F2F3F4"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            height: 250.0,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 70.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                            image: DecorationImage(
                              image: new AssetImage(
                                widget.store.image,
                              ),
                              scale: 1.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.store.name,
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      widget.store.address,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 40.0,
                          child: IconButton(
                            icon: Icon(
                              LineAwesomeIcons.dolly,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => AppbarPage(
                                      11.toString(), widget.typeMenuCode),
                                ),
                              );
                            },
                            iconSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //---------Column2
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 70.0,
                          child: Icon(
                            LineAwesomeIcons.map_marked,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.store.addressname,
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      widget.store.time,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 40.0,
                          child: IconButton(
                            icon: Icon(
                              LineAwesomeIcons.location_arrow,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        // CurrentLocation(openMap: true),
                                        DeliveryCheckIn(
                                            GlobalParam.typeMenuCode, true)),
                              );
                            },
                            iconSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //---------Column3
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 70.0,
                          child: Icon(
                            LineAwesomeIcons.user,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.store.contact,
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      widget.store.phone,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 40.0,
                          alignment: Alignment.centerRight,
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: IconButton(
                              icon: Icon(
                                LineAwesomeIcons.phone,
                                color: Colors.green,
                              ),
                              onPressed: () {},
                              iconSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //-----------col4
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 70.0,
                          child: Icon(
                            FontAwesomeIcons.boxes,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.store.total,
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      widget.store.no,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(5.0),
                          // width: 100.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.bottomRight,
                                child: SubstringPrice(
                                  widget.store.amount.toString(),
                                  14.0,
                                  12.0,
                                  Colors.orange,
                                  Colors.orange,
                                  'Prompt',
                                  'Prompt',
                                  FontWeight.bold,
                                  FontWeight.bold,
                                  '',
                                  12.0,
                                  Colors.orange,
                                  'Prompt',
                                  FontWeight.bold,
                                  FontStyle.normal,
                                  FontStyle.normal,
                                  FontStyle.normal,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'THB',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          DottedLine(
            dashColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
