import 'package:flutter/material.dart';
import 'package:vansale/api/class/globalparam.dart';
import 'package:vansale/api/class/response/routeMobile/getSaleStoreOrderResp.dart';
import 'package:vansale/screens/sale/survey/sale_productSet.dart';

class SaleSelectSale extends StatelessWidget {
  const SaleSelectSale({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เลือกการขาย"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 48,
                  child: Center(
                    child: Text(
                      "ขายแบบคละ",
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SaleProductSet(
                    cBRANCD: GlobalParam.VEHICLE['cBRANCD'],
                    cCUSTTYPE: "Retail",
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 48,
                  child: Center(
                    child: Text(
                      "ขายแบบชุด",
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
