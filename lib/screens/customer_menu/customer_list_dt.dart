import 'package:flutter/material.dart';
import 'package:vansale/list_all.dart/lst_new_product.dart';
import 'package:vansale/list_all.dart/lst_promotion_product.dart';
import 'package:vansale/list_all.dart/lst_recommend_product.dart';

class CustomerListDT extends StatefulWidget {
  @override
  State<CustomerListDT> createState() => _CustomerListDTState();
}

class _CustomerListDTState extends State<CustomerListDT> {
  @override
  Widget build(BuildContext context) {
    return
        //child: Container(
        ListView(
      shrinkWrap: true,
      primary: false,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15.0, right: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'สินค้าแนะนำ',
                    style: TextStyle(
                      fontFamily: 'Prompt',
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ดูทั้งหมด',
                    style: TextStyle(
                      fontFamily: 'Prompt',
                      color: Colors.red,
                      //fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 150.0,
          padding: const EdgeInsets.only(left: 5.0, right: 10.0),
          child: ListRecommendProduct(),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15.0, right: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'สินค้าใหม่',
                    style: TextStyle(
                      fontFamily: 'Prompt',
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ดูทั้งหมด',
                    style: TextStyle(
                      fontFamily: 'Prompt',
                      color: Colors.red,
                      //fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 150.0,
          padding: const EdgeInsets.only(left: 5.0, right: 10.0),
          child: ListNewProduct(),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15.0, right: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'สินค้าโปรโมชั่น',
                    style: TextStyle(
                      fontFamily: 'Prompt',
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ดูทั้งหมด',
                    style: TextStyle(
                      fontFamily: 'Prompt',
                      color: Colors.red,
                      //fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 150.0,
          padding: const EdgeInsets.only(left: 5.0, right: 10.0),
          child: ListPromotion(),
        ),
      ],

      //),
    );
  }
}
