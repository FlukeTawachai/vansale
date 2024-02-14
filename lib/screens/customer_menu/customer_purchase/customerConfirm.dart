import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/Supplier/delivery/deliveryBuyDetail.dart';
import 'package:vansale/screens/home/home.dart';

class CustomerOrderConfirm extends StatefulWidget {
  // const ConfirmOrder({ Key? key }) : super(key: key);
  final String typeMenuCode;
  CustomerOrderConfirm(this.typeMenuCode);
  @override
  _CustomerOrderConfirmState createState() => _CustomerOrderConfirmState();
}

class _CustomerOrderConfirmState extends State<CustomerOrderConfirm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => HomePage(widget.typeMenuCode)),
          (Route<dynamic> route) => false);
    });
  }

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
                  color: HexColor('#00cb39'),
                  size: 150.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'สั่งซื้อ',
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
                  'เรียบร้อยแล้ว',
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
        // bottomNavigationBar: Container(
        //   alignment: Alignment.center,
        //   height: 80.0,
        //   color: Colors.white,
        //   child: Expanded(
        //     child: Card(
        //       elevation: 0.0,
        //       child: Row(
        //         children: [
        //           Expanded(
        //             child: Container(
        //               alignment: Alignment.center,
        //               child: InkWell(
        //                 onTap: () {
        //                   Navigator.of(context).pushAndRemoveUntil(
        //                       MaterialPageRoute(
        //                           builder: (context) => HomePage(widget.typeMenuCode)),
        //                       (Route<dynamic> route) => false);
        //                 },
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   children: [
        //                     Container(
        //                       alignment: Alignment.center,
        //                       child: Icon(
        //                         LineAwesomeIcons.arrow_left,
        //                         size: 25.0,
        //                         color: Colors.black54,
        //                       ),
        //                     ),
        //                     SizedBox(
        //                       width: 10.0,
        //                     ),
        //                     Container(
        //                       //alignment: Alignment.centerLeft,
        //                       child: Text(
        //                         'กลับหน้าหลัก',
        //                         style: TextStyle(
        //                           fontSize: 16.0,
        //                           color: Colors.black54,
        //                           //fontWeight: FontWeight.bold,
        //                           fontFamily: 'Prompt',
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //           //--------------
        //           Expanded(
        //             child: Container(
        //               alignment: Alignment.center,
        //               child: InkWell(
        //                 onTap: () {
        //                   Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                       builder: (BuildContext context) =>
        //                           DeliveryBuyDetail(navigated: () {}),
        //                     ),
        //                   );
        //                 },
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   children: [
        //                     Container(
        //                       alignment: Alignment.center,
        //                       child: Icon(
        //                         LineAwesomeIcons.check_circle,
        //                         size: 25.0,
        //                         color: HexColor('#00cb39'),
        //                       ),
        //                     ),
        //                     SizedBox(
        //                       width: 10.0,
        //                     ),
        //                     Container(
        //                       //alignment: Alignment.centerLeft,
        //                       child: Text(
        //                         'ดูรายละเอียด',
        //                         style: TextStyle(
        //                           fontSize: 16.0,
        //                           color: HexColor('#00cb39'),
        //                           //fontWeight: FontWeight.bold,
        //                           fontFamily: 'Prompt',
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
