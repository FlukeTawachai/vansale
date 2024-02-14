import 'package:flutter/material.dart';
import 'package:vansale/screens/customer_menu/customer_list_dt.dart';
import 'package:vansale/screens/customer_menu/customer_list_hd.dart';

class CustomerMainPage extends StatefulWidget {
  final String typeMenuCode;
  CustomerMainPage(this.typeMenuCode);

  @override
  State<CustomerMainPage> createState() => _CustomerMainPageState();
}

class _CustomerMainPageState extends State<CustomerMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'หน้าแรก',
          style: TextStyle(
            color: Colors.black,
            //color: Color.fromRGBO(0, 157, 181, 5),
            fontFamily: 'Prompt',
            fontSize: 18.0,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
        ),
        //Container(),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              //color: Colors.amber,
              height: 135.0,
              child: CustomerListHD(),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: RefreshIndicator(
                  color: Colors.green,
                  onRefresh: () async {
                    return await Future.delayed(Duration(seconds: 1));
                  },
                  child: CustomerListDT(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
