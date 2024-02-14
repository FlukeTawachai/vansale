import 'package:flutter/material.dart';
import 'package:vansale/list_all.dart/lst_new_product.dart';
import 'package:vansale/list_all.dart/lst_promotion_product.dart';
import 'package:vansale/list_all.dart/lst_recommend_product.dart';

class CustomerMainBody extends StatefulWidget {
  //const CustomerMainBody({ Key? key }) : super(key: key);

  @override
  _CustomerMainBodyState createState() => _CustomerMainBodyState();
}

class _CustomerMainBodyState extends State<CustomerMainBody> {
  @override
  Widget build(BuildContext context) {
    return
        //child: Container(
        ListView(
      shrinkWrap: true,
      primary: false,
      children: [
        Container(
          height: 40.0,
          child: ListTile(
            title: Text(
              'สินค้าแนะนำ',
              style: TextStyle(
                fontFamily: 'Prompt',
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            trailing: Text(
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
        Container(
          height: 150.0,
          child: ListRecommendProduct(),
        ),
        Container(
          height: 40.0,
          child: ListTile(
            title: Text(
              'สินค้าใหม่',
              style: TextStyle(
                fontFamily: 'Prompt',
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            trailing: Text(
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
        Container(
          height: 150.0,
          child: ListNewProduct(),
        ),
        Container(
          height: 40.0,
          child: ListTile(
            title: Text(
              'สินค้าโปรโมชั่น',
              style: TextStyle(
                fontFamily: 'Prompt',
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            trailing: Text(
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
        Container(
          height: 150.0,
          child: ListPromotion(),
        ),
      ],

      //),
    );
  }
}
