
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/list_all.dart/lst_basket.dart';

class StoreBasket extends StatefulWidget {
  const StoreBasket({ Key key }) : super(key: key);

  @override
  State<StoreBasket> createState() => _StoreBasketState();
}

class _StoreBasketState extends State<StoreBasket> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          left: 10.0,
        ),
        alignment: Alignment.centerLeft,
        color: HexColor("#F2F3F4"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 48,),
            Container(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 30.0,
                    child: Icon(
                      LineAwesomeIcons.shopping_basket,
                      size: 35.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ตระกร้า',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ListBasket(),
              ),
            ),
          ],
        ),
      );
  }
}