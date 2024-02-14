import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/sale/sale_transfer_product/sale_lst_batch.dart';

class SaleBatchTransfer extends StatefulWidget {
  const SaleBatchTransfer({Key key}) : super(key: key);

  @override
  State<SaleBatchTransfer> createState() => _SaleBatchTransferState();
}

class _SaleBatchTransferState extends State<SaleBatchTransfer> {
  double total = 3950;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('โอนเป็นชุด'),
      ),
      body: SaleListBatch(),
      bottomNavigationBar: buttonBar(),
    );
  }

  Widget buttonBar() {
    double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      height: 136.0,
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
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
                child: Row(
                  children: [
                    Container(
                      width: widthScreen * 0.46,
                      height: 24,
                      child: Text(
                        '32 รายการ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'รายละเอียด',
                                  style: TextStyle(
                                      fontFamily: 'Prompt', fontSize: 16),
                                ),
                              );
                            });
                      },
                      child: Container(
                        width: widthScreen * 0.4,
                        height: 24,
                        alignment: Alignment.centerRight,
                        child: Text(
                          'แสดงรายละเอียด',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Prompt',
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 24,
              // ),
              //--------------
              Container(
                padding:
                    const EdgeInsets.only(top: 5.0, left: 12.0, right: 12.0),
                child: Row(
                  children: [
                    Container(
                      width: widthScreen * 0.4,
                      height: 24,
                      child: Text(
                        'รวมเป็นเงิน',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: widthScreen * 0.4,
                      // height: 24,
                      alignment: Alignment.centerRight,
                      child: SubstringPrice(
                        '${total.toStringAsFixed(2)}',
                        16.0,
                        16.0,
                        Colors.red,
                        Colors.red,
                        'Prompt',
                        'Prompt',
                        FontWeight.bold,
                        FontWeight.bold,
                        '',
                        16.0,
                        Colors.red,
                        'Prompt',
                        FontWeight.bold,
                        FontStyle.normal,
                        FontStyle.normal,
                        FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),

              //--------------
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: Icon(
                                LineAwesomeIcons.save,
                                color: Colors.green,
                                size: 25.0,
                              )),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'บันทึกโอนย้ายสินค้า',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.green,
                              fontFamily: 'Prompt',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
