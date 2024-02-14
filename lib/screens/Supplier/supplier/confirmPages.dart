import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ConfirmPages extends StatefulWidget {
  // const ConfirmOrder({ Key? key }) : super(key: key);
  final String typeMenuCode;
  final String title;
  ConfirmPages(this.typeMenuCode, this.title);
  @override
  _ConfirmPagesState createState() => _ConfirmPagesState();
}

class _ConfirmPagesState extends State<ConfirmPages> {
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
        // bottomSheet: Container(
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
        //                   Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                       builder: (BuildContext context) =>
        //                           MainMenu(widget.typeMenuCode),
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
        //                           ViewOrder(widget.typeMenuCode),
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
