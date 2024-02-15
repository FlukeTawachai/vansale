import 'package:flutter/material.dart';

class ListBasket extends StatefulWidget {
  @override
  _ListBasketState createState() => _ListBasketState();
}

class _ListBasketState extends State<ListBasket> {
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
  ];

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
