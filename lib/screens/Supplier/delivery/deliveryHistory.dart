import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/deliveryHistoryCard.dart';

class DeliveryHistory extends StatefulWidget {
  //const CustomerHistory({ Key? key }) : super(key: key);
  final String typeMenuCode;
  DeliveryHistory(this.typeMenuCode);
  @override
  _DeliveryHistoryState createState() => _DeliveryHistoryState();
}

class _DeliveryHistoryState extends State<DeliveryHistory> {
  var history = [
    {
      'billno': "0001",
      'status': "ส่งแล้ว",
      'date': "22 ก.ย. 63",
      'group': "(วันจันทร์)",
      'price': "3200.00",
      'unit': "บาท",
    },
    {
      'billno': "0002",
      'status': "ส่งแล้ว",
      'date': "22 ก.ย. 63",
      'group': "(วันจันทร์)",
      'price': "3200.00",
      'unit': "บาท",
    },
    {
      'billno': "0003",
      'status': "ส่งแล้ว",
      'date': "22 ก.ย. 63",
      'group': "(วันจันทร์)",
      'price': "3200.00",
      'unit': "บาท",
    },
    {
      'billno': "0004",
      'status': "ส่งแล้ว",
      'date': "22 ก.ย. 63",
      'group': "(วันจันทร์)",
      'price': "3200.00",
      'unit': "บาท",
    },
    {
      'billno': "0005",
      'status': "ส่งแล้ว",
      'date': "22 ก.ย. 63",
      'group': "(วันจันทร์)",
      'price': "3200.00",
      'unit': "บาท",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'ประวัติการสั่งซื้อ',
          style: TextStyle(
            color: Colors.black,
            //color: Color.fromRGBO(0, 157, 181, 5),
            fontFamily: 'Prompt',
            fontSize: 18.0,
          ),
        ),
        leading:
            Container(), /*IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),*/
      ),
      body: RefreshIndicator(
        color: Colors.green,
        onRefresh: () async {
          return await Future.delayed(Duration(seconds: 1));
        },
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                color: HexColor('#6c7e9b'),
                height: 60.0,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontFamily: 'Prompt',
                            ),
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              hintText: "ค้นหาเลขที่บิล",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 5.0, top: 5.0),
                              prefixIcon: RotatedBox(
                                quarterTurns: 1,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: HexColor('#6c7e9b'),
                                  ),
                                  onPressed: () {},
                                  iconSize: 25.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          child: IconButton(
                            icon: const Icon(Icons.qr_code),
                            iconSize: 25.0,
                            color: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DeliveryHistoryCard(
                        typeMenuCode: widget.typeMenuCode,
                        billno: history[index]["billno"],
                        status: history[index]["status"],
                        date: history[index]["date"],
                        group: history[index]["group"],
                        price: history[index]["price"],
                        unit: history[index]["unit"],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
