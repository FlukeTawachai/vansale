import 'package:flutter/material.dart';

Widget depositamount() {
  return Center(
    child: Container(
      //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      //height: 40,
      child: Row(
        children: [
          Container(
            width: 200,
            child: Text(
              'จำนวนเงินที่ฝาก',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              width: 113.0,
              height: 32,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Prompt',
                    color: Color.fromRGBO(169, 169, 169, 1),
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            alignment: Alignment.centerRight,
            child: Text(
              'บาท',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget banknote1000() {
  return Center(
    child: Container(
      //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      //height: 40,
      child: Row(
        children: [
          Container(
            width: 200,
            child: Text(
              'ธนบัตร 1000 บาท',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              width: 113.0,
              height: 32,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Prompt',
                    color: Color.fromRGBO(169, 169, 169, 1),
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            alignment: Alignment.centerRight,
            child: Text(
              'ใบ',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget banknote500() {
  return Center(
    child: Container(
      //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      //height: 40,
      child: Row(
        children: [
          Container(
            width: 200,
            child: Text(
              'ธนบัตร 500 บาท',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              width: 113.0,
              height: 32,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Prompt',
                    color: Color.fromRGBO(169, 169, 169, 1),
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            alignment: Alignment.centerRight,
            child: Text(
              'ใบ',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget banknote100() {
  return Center(
    child: Container(
      //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      //height: 40,
      child: Row(
        children: [
          Container(
            width: 200,
            child: Text(
              'ธนบัตร 100 บาท',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              width: 113.0,
              height: 32,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Prompt',
                    color: Color.fromRGBO(169, 169, 169, 1),
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            alignment: Alignment.centerRight,
            child: Text(
              'ใบ',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget banknote50() {
  return Center(
    child: Container(
      //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      //height: 40,
      child: Row(
        children: [
          Container(
            width: 200,
            child: Text(
              'ธนบัตร 50 บาท',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              width: 113.0,
              height: 32,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Prompt',
                    color: Color.fromRGBO(169, 169, 169, 1),
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            alignment: Alignment.centerRight,
            child: Text(
              'ใบ',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget banknote20() {
  return Center(
    child: Container(
      //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      //height: 40,
      child: Row(
        children: [
          Container(
            width: 200,
            child: Text(
              'ธนบัตร 20 บาท',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              width: 113.0,
              height: 32,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Prompt',
                    color: Color.fromRGBO(169, 169, 169, 1),
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            alignment: Alignment.centerRight,
            child: Text(
              'ใบ',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget totalcoins() {
  return Center(
    child: Container(
      //padding: const EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
      //height: 40,
      child: Row(
        children: [
          Container(
            width: 200,
            child: Text(
              'เหรียญนับรวม',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              width: 113.0,
              height: 32,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Prompt',
                    color: Color.fromRGBO(169, 169, 169, 1),
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            alignment: Alignment.centerRight,
            child: Text(
              'บาท',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Prompt',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
