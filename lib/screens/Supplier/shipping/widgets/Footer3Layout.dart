import 'package:flutter/material.dart';
import 'package:vansale/function/substring_price.dart';

class Footer3Layout extends StatelessWidget {
  final String typeMenuCode;
  final String layout1Title;
  final String layout1Paramitor;
  final String layout2Title;
  final String layout2Paramitor;
  final IconData iconButton;
  final String titleButton;
  final VoidCallback navigated;

  const Footer3Layout({
    Key key,
    this.typeMenuCode,
    this.layout1Title,
    this.layout1Paramitor,
    this.layout2Title,
    this.layout2Paramitor,
    this.iconButton,
    this.titleButton,
    this.navigated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DelayTime delay = new DelayTime();
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
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      layout1Title,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      )
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      layout1Paramitor,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //--------------
          Container(
            padding: const EdgeInsets.only(top: 5.0, left: 12.0, right: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      layout2Title,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      )
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: SubstringPrice(
                      layout2Paramitor,
                      18.0,
                      14.0,
                      Colors.orange,
                      Colors.orange,
                      'Prompt',
                      'Prompt',
                      FontWeight.bold,
                      FontWeight.bold,
                      '฿',
                      18.0,
                      Colors.orange,
                      'Prompt',
                      FontWeight.bold,
                      FontStyle.normal,
                      FontStyle.normal,
                      FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //--------------
          // SizedBox(
          //   height: 8,
          // ),
          TextButton(
              onPressed: () {
                navigated();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  iconButton == null
                      ? SizedBox()
                      : Icon(iconButton, size: 24, color: Colors.green),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      titleButton,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
