import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryDesNavigated.dart';
import 'package:vansale/screens/Supplier/delivery/models/store.dart';
import 'package:vansale/screens/googleMap/currentLocation.dart';
import 'package:vansale/screens/googleMap/mapHome.dart';

class DesMapFooter extends StatefulWidget {
  final StoreModel? store;
  const DesMapFooter({Key? key, this.store})
      : super(key: key);

  @override
  State<DesMapFooter> createState() => _DesMapFooterState();
}

class _DesMapFooterState extends State<DesMapFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 360.0,
      height: 96.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          // SizedBox(height: 16),
          // Container(
          //   padding: const EdgeInsets.all(3.0),
          //   // color: HexColor("#F2F3F4"),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Container(
          //         padding: const EdgeInsets.all(5.0),
          //         height: 250.0,
          //         child: Column(
          //           children: [
          //             Expanded(
          //               child: Container(
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     Container(
          //                       width: 70.0,
          //                       decoration: new BoxDecoration(
          //                         shape: BoxShape.circle,
          //                         color: Colors.grey,
          //                         image: DecorationImage(
          //                           image: new AssetImage(
          //                             widget.store.image,
          //                           ),
          //                           scale: 1.0,
          //                           fit: BoxFit.cover,
          //                         ),
          //                       ),
          //                     ),
          //                     Expanded(
          //                       child: Container(
          //                         padding: const EdgeInsets.all(5.0),
          //                         alignment: Alignment.topLeft,
          //                         child: Column(
          //                           mainAxisAlignment: MainAxisAlignment.start,
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.center,
          //                           children: [
          //                             Container(
          //                               alignment: Alignment.topLeft,
          //                               child: Text(
          //                                 widget.store.name,
          //                                 style: TextStyle(
          //                                   fontFamily: 'Prompt',
          //                                   fontWeight: FontWeight.bold,
          //                                   fontSize: 14.0,
          //                                 ),
          //                               ),
          //                             ),
          //                             SizedBox(
          //                               height: 5.0,
          //                             ),
          //                             Flexible(
          //                               child: Container(
          //                                 alignment: Alignment.topLeft,
          //                                 child: Text(
          //                                   widget.store.address,
          //                                   overflow: TextOverflow.ellipsis,
          //                                   style: TextStyle(
          //                                     fontFamily: 'Prompt',
          //                                     fontSize: 14.0,
          //                                     color: Colors.grey,
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                     Container(
          //                       width: 40.0,
          //                       child: IconButton(
          //                         icon: Icon(
          //                           LineAwesomeIcons.dolly,
          //                           color: Colors.black87,
          //                         ),
          //                         onPressed: () {
          //                           // Navigator.push(
          //                           //   context,
          //                           //   MaterialPageRoute(
          //                           //     builder: (BuildContext context) =>
          //                           //         AppbarPage(11.toString(),
          //                           //             widget.typeMenuCode),
          //                           //   ),
          //                           // );
          //                         },
          //                         iconSize: 20.0,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             //---------Column2
          //             SizedBox(
          //               height: 10.0,
          //             ),
          //             Expanded(
          //               child: Container(
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     Container(
          //                       width: 70.0,
          //                       child: Icon(
          //                         LineAwesomeIcons.map_marked,
          //                         color: Colors.grey,
          //                         size: 20.0,
          //                       ),
          //                     ),
          //                     Expanded(
          //                       child: Container(
          //                         padding: const EdgeInsets.all(5.0),
          //                         alignment: Alignment.topLeft,
          //                         child: Column(
          //                           mainAxisAlignment: MainAxisAlignment.start,
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.center,
          //                           children: [
          //                             Container(
          //                               alignment: Alignment.topLeft,
          //                               child: Text(
          //                                 widget.store.addressname,
          //                                 style: TextStyle(
          //                                   fontFamily: 'Prompt',
          //                                   fontWeight: FontWeight.bold,
          //                                   fontSize: 14.0,
          //                                 ),
          //                               ),
          //                             ),
          //                             SizedBox(
          //                               height: 5.0,
          //                             ),
          //                             Flexible(
          //                               child: Container(
          //                                 alignment: Alignment.topLeft,
          //                                 child: Text(
          //                                   widget.store.time,
          //                                   overflow: TextOverflow.ellipsis,
          //                                   style: TextStyle(
          //                                     fontFamily: 'Prompt',
          //                                     fontSize: 14.0,
          //                                     color: Colors.grey,
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                     Container(
          //                       width: 40.0,
          //                       child: IconButton(
          //                         icon: Icon(
          //                           LineAwesomeIcons.location_arrow,
          //                           color: Colors.black87,
          //                         ),
          //                         onPressed: () {
          //                           // Navigator.push(
          //                           //   context,
          //                           //   MaterialPageRoute(
          //                           //     builder: (BuildContext context) =>
          //                           //         DestionationMap(store: widget.store),
          //                           //   ),
          //                           // );
          //                         },
          //                         iconSize: 20.0,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             //---------Column3
          //             SizedBox(
          //               height: 10.0,
          //             ),
          //             Expanded(
          //               child: Container(
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     Container(
          //                       width: 70.0,
          //                       child: Icon(
          //                         LineAwesomeIcons.user,
          //                         color: Colors.grey,
          //                         size: 20.0,
          //                       ),
          //                     ),
          //                     Expanded(
          //                       child: Container(
          //                         padding: const EdgeInsets.all(5.0),
          //                         alignment: Alignment.topLeft,
          //                         child: Column(
          //                           mainAxisAlignment: MainAxisAlignment.start,
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.center,
          //                           children: [
          //                             Container(
          //                               alignment: Alignment.topLeft,
          //                               child: Text(
          //                                 widget.store.contact,
          //                                 style: TextStyle(
          //                                   fontFamily: 'Prompt',
          //                                   fontWeight: FontWeight.bold,
          //                                   fontSize: 14.0,
          //                                 ),
          //                               ),
          //                             ),
          //                             SizedBox(
          //                               height: 5.0,
          //                             ),
          //                             Flexible(
          //                               child: Container(
          //                                 alignment: Alignment.topLeft,
          //                                 child: Text(
          //                                   widget.store.phone,
          //                                   overflow: TextOverflow.ellipsis,
          //                                   style: TextStyle(
          //                                     fontFamily: 'Prompt',
          //                                     fontSize: 14.0,
          //                                     color: Colors.grey,
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                     Container(
          //                       width: 40.0,
          //                       alignment: Alignment.centerRight,
          //                       child: RotatedBox(
          //                         quarterTurns: 1,
          //                         child: IconButton(
          //                           icon: Icon(
          //                             LineAwesomeIcons.phone,
          //                             color: Colors.black87,
          //                           ),
          //                           onPressed: () {},
          //                           iconSize: 20.0,
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             //-----------col4
          //             SizedBox(
          //               height: 10.0,
          //             ),
          //             Expanded(
          //               child: Container(
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     Container(
          //                       width: 70.0,
          //                       child: Icon(
          //                         FontAwesomeIcons.boxes,
          //                         color: Colors.grey,
          //                         size: 20.0,
          //                       ),
          //                     ),
          //                     Expanded(
          //                       child: Container(
          //                         padding: const EdgeInsets.all(5.0),
          //                         alignment: Alignment.topLeft,
          //                         child: Column(
          //                           mainAxisAlignment: MainAxisAlignment.start,
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.center,
          //                           children: [
          //                             Container(
          //                               alignment: Alignment.topLeft,
          //                               child: Text(
          //                                 widget.store.total,
          //                                 style: TextStyle(
          //                                   fontFamily: 'Prompt',
          //                                   fontWeight: FontWeight.bold,
          //                                   fontSize: 14.0,
          //                                 ),
          //                               ),
          //                             ),
          //                             SizedBox(
          //                               height: 5.0,
          //                             ),
          //                             Flexible(
          //                               child: Container(
          //                                 alignment: Alignment.topLeft,
          //                                 child: Text(
          //                                   widget.store.no,
          //                                   overflow: TextOverflow.ellipsis,
          //                                   style: TextStyle(
          //                                     fontFamily: 'Prompt',
          //                                     fontSize: 14.0,
          //                                     color: Colors.grey,
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                     Container(
          //                       alignment: Alignment.centerRight,
          //                       padding: const EdgeInsets.all(5.0),
          //                       // width: 100.0,
          //                       child: Column(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           Container(
          //                             alignment: Alignment.bottomRight,
          //                             child: SubstringPrice(
          //                               widget.store.amount.toString(),
          //                               14.0,
          //                               12.0,
          //                               Colors.orange,
          //                               Colors.orange,
          //                               'Prompt',
          //                               'Prompt',
          //                               FontWeight.bold,
          //                               FontWeight.bold,
          //                               '',
          //                               12.0,
          //                               Colors.orange,
          //                               'Prompt',
          //                               FontWeight.bold,
          //                               FontStyle.normal,
          //                               FontStyle.normal,
          //                               FontStyle.normal,
          //                             ),
          //                           ),
          //                           SizedBox(
          //                             height: 5.0,
          //                           ),
          //                           Flexible(
          //                             child: Container(
          //                               alignment: Alignment.centerRight,
          //                               child: Text(
          //                                 'THB',
          //                                 overflow: TextOverflow.ellipsis,
          //                                 style: TextStyle(
          //                                   fontFamily: 'Prompt',
          //                                   fontSize: 14.0,
          //                                   color: Colors.grey,
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       DottedLine(
          //         dashColor: Colors.grey,
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Container(
              height: 48.0,
              child: InkWell(
                  onTap: () {
                    // Navigator.of(context).pop();

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CurrentLocation()
                        //  DestinationNavigated(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(LineAwesomeIcons.location_arrow,
                          size: 24, color: Colors.green),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "เริ่มการนำทาง",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.green,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
