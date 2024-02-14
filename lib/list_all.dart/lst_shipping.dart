import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vansale/function/substring_price.dart';

class ListShipping extends StatefulWidget {
  //const ListShipping({ Key? key }) : super(key: key);

  @override
  _ListShippingState createState() => _ListShippingState();
}

class _ListShippingState extends State<ListShipping> {
  var item = [
    {
      "image": "assets/images/Product1.png",
      "name": "สินค้า1",
      "basket": "1 ตระกร้า",
      "po": "No.123",
      "price": "100.00",
    },
    {
      "image": "assets/images/Product2.png",
      "name": "สินค้า2",
      "basket": "1 ตระกร้า",
      "po": "No.123",
      "price": "100.00",
    },
    {
      "image": "assets/images/Product3.png",
      "name": "สินค้า3",
      "basket": "1 ตระกร้า",
      "po": "No.123",
      "price": "100.00",
    },
    {
      "image": "assets/images/Product4.png",
      "name": "สินค้า4",
      "basket": "1 ตระกร้า",
      "po": "No.123",
      "price": "100.00",
    },
    {
      "image": "assets/images/Product1.png",
      "name": "สินค้า5",
      "basket": "1 ตระกร้า",
      "po": "No.123",
      "price": "100.00",
    },
    {
      "image": "assets/images/Product2.png",
      "name": "สินค้า6",
      "basket": "1 ตระกร้า",
      "po": "No.123",
      "price": "100.00",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: item.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: HexColor("#F2F3F4"),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                height: 110.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        item[index]['image'],
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 150.0,
                      ),
                    ),
                    //----------------------1
                    Expanded(
                        child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item[index]['name'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Prompt',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item[index]['basket'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Prompt',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item[index]['po'],
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'Prompt',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: SubstringPrice(
                              item[index]['price'],
                              16.0,
                              14.0,
                              Colors.black,
                              Colors.black,
                              'Prompt',
                              'Prompt',
                              FontWeight.bold,
                              FontWeight.bold,
                              '฿',
                              14.0,
                              Colors.black,
                              'Prompt',
                              FontWeight.bold,
                              FontStyle.normal,
                              FontStyle.normal,
                              FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              DottedLine(
                dashColor: Colors.grey,
              ),
            ],
          ),
        );
      },
    );
  }
}
