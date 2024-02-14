import 'package:flutter/material.dart';
import 'package:vansale/screens/customer/customer_main_body.dart';
import 'package:vansale/screens/customer/customer_store_list.dart';

class CustomerHome extends StatefulWidget {
  CustomerHome({Key key}) : super(key: key);

  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
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
              height: 125.0,
              child: CustomerStoreList(),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: RefreshIndicator(
                  color: Colors.green,
                  onRefresh: () async {
                    return await Future.delayed(Duration(seconds: 1));
                  },
                  child: CustomerMainBody(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
