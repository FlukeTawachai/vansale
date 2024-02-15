import 'package:flutter/material.dart';
import 'package:vansale/api/class/globalparam.dart';

class DeliveryStoreListBasket extends StatefulWidget {
  @override
  State<DeliveryStoreListBasket> createState() =>
      _DeliveryStoreListBasketState();
}

class _DeliveryStoreListBasketState extends State<DeliveryStoreListBasket> {
  var basket = [
    {
      'store': "ทั้งหมด",
      'total': "10",
      'unit': "ใบ",
    },
    {
      'store': "ศรีสุดา",
      'total': "5",
      'unit': "ใบ",
    },
    {
      'store': "แม่เน้ย",
      'total': "5",
      'unit': "ใบ",
    },
    {
      'store': "ทั้งหมด",
      'total': "10",
      'unit': "ใบ",
    },
    {
      'store': "ศรีสุดา",
      'total': "5",
      'unit': "ใบ",
    },
    {
      'store': "แม่เน้ย",
      'total': "5",
      'unit': "ใบ",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int basketTotal = 0;
    for (int i = 0; i < GlobalParam.deliveryHisBasket.length; i++) {
      basketTotal += (GlobalParam.deliveryHisBasket[i].iTOTAL! -
          GlobalParam.deliveryHisBasket[i].iRETURN!);
    }

    basket = [
      {
        'store': "ทั้งหมด",
        'total': basketTotal.toString(),
        'unit': "ใบ",
      }
    ];

    for (int i = 0; i < GlobalParam.deliveryHisBasket.length; i++) {
      Map<String, String> data = {
        'store': GlobalParam.deliveryHisBasket[i].cBASKNM!,
        'total':
            '${GlobalParam.deliveryHisBasket[i].iTOTAL! - GlobalParam.deliveryHisBasket[i].iRETURN!}',
        'unit': "ใบ",
      };
      basket.add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
      itemCount: basket.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    basket[index]['store']!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: basket[index]['store'] == "ทั้งหมด"
                          ? Colors.blue
                          : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Prompt',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    basket[index]['total']!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: basket[index]['store'] == "ทั้งหมด"
                          ? Colors.blue
                          : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Prompt',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    basket[index]['unit']!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: basket[index]['store'] == "ทั้งหมด"
                          ? Colors.blue
                          : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Prompt',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
