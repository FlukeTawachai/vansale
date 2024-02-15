
import 'package:flutter/material.dart';

class StoreDetail extends StatefulWidget {
  const StoreDetail({ Key? key }) : super(key: key);

  @override
  State<StoreDetail> createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: HexColor("#F2F3F4"),
        child: Container(
          child: Row(
            children: [
              // sdlfkjsdklf
              SizedBox(
                width: 20.0,
              ),
              Container(
                child: Container(
                  width: 50.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: DecorationImage(
                      image: new AssetImage(
                        'assets/images/Product3.png',
                      ),
                      scale: 1.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    right: 5.0,
                    bottom: 5.0,
                    left: 10.0,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Store Name',
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            // color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'NY,Abraham ...................',
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            color: Colors.grey,
                            //fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              'สถานะ: ',
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                // color: Colors.grey,
                                //fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              'กำลังจัดส่ง',
                              style: TextStyle(
                                fontFamily: 'Prompt',
                                // color: Colors.grey,
                                //fontWeight: FontWeight.bold,
                                fontSize: 14.0,
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
      );
  }
}