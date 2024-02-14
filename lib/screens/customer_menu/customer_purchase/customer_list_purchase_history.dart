import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/queryPodtResp.dart';
import 'package:vansale/api/class/utility.dart';
import 'package:vansale/screens/customer_menu/customer_purchase/customer_purchase_order_edit.dart';

class CustomerListPurchaseHistory extends StatefulWidget {
  final String typeMenuCode;
  CustomerListPurchaseHistory(this.typeMenuCode);

  @override
  State<CustomerListPurchaseHistory> createState() =>
      _CustomerListPurchaseHistoryState();
}

class _CustomerListPurchaseHistoryState
    extends State<CustomerListPurchaseHistory> {
  Utility utility = Utility();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: GlobalParam.customerPOHDList.length,
      itemBuilder: (BuildContext context, int index) {
        DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .parse(GlobalParam.customerPOHDList[index].dPODATE);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('dd-MM-yyyy');
        var outputDate = outputFormat.format(inputDate);
        var status = '';
        var total = 0.0;
        if (GlobalParam.customerPOHDList[index].cPOSTATUS == '0') {
          status = 'ร่างใบสั่งซื้อ';
        }
        if (GlobalParam.customerPOHDList[index].cPOSTATUS == '1') {
          status = 'สร้างใบสั่งซื้อ';
        }
        if (GlobalParam.customerPOHDList[index].cPOSTATUS == '2') {
          status = 'พิมพ์ใบสั่งซื้อ';
        }
        if (GlobalParam.customerPOHDList[index].cPOSTATUS == '3') {
          status = 'กำลังขนส่ง';
        }
        if (GlobalParam.customerPOHDList[index].cPOSTATUS == '4') {
          status = 'ขนส่งสำเร็จ';
        }
        if (GlobalParam.customerPOHDList[index].cPOSTATUS == '5') {
          status = 'ยกเลิกขนส่ง';
        }
        if (GlobalParam.customerPOHDList[index].cPOSTATUS == '6') {
          status = 'ยกเลิกสั่งซื้อ';
        }

        total = double.parse(GlobalParam.customerPOHDList[index].iTOTAL);
        return Container(
          padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: InkWell(
                  onTap: () {
                    List<QueryPodtResp> result = [];
                    GlobalParam.customerPOHDSelect =
                        GlobalParam.customerPOHDList[index];
                    for (int i = 0;
                        i < GlobalParam.customerPODTList.length;
                        i++) {
                      if (GlobalParam.customerPOHDList[index].cPOCD ==
                          GlobalParam.customerPODTList[i].cPOCD) {
                        result.add(GlobalParam.customerPODTList[i]);
                      }
                    }
                    GlobalParam.customerProductList = result;
                    GlobalParam.deliveryPodtList = result;
                    GlobalParam.deliveryPodtShow = result;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CustomerPurchaseOrderEdit(widget.typeMenuCode,true),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'วันที่บิล',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'สถานะ',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'ยอดเงิน',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //------------------------
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          outputDate,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: 'Prompt',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width: 100.0,
                                        alignment: Alignment.center,
                                        child: AutoSizeText(
                                          '${status}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: 'Prompt',
                                          ),
                                          maxLines: 1,
                                        )),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child:
                                            Utility.formateNumberOrangeTxtBaht(
                                                total),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 10.0,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //----เส้นประ---------
              DottedLine(
                lineThickness: 2.0,
                dashColor: Colors.grey,
              ),
            ],
          ),
        );
      },
    );
  }
}
