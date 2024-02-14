import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/customer/customer_home.dart';

class CustomerMenu extends StatefulWidget {
  CustomerMenu({Key? key}) : super(key: key);

  @override
  _CustomerMenuState createState() => _CustomerMenuState();
}

class _CustomerMenuState extends State<CustomerMenu> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _screen = [
    const CustomerHome(
      key: null,
    ),
    const CustomerHome(
      key: null,
    ),
    const CustomerHome(
      key: null,
    ),
    const CustomerHome(
      key: null,
    ),
    // Order(widget),
    // CustomerHistory(),

    //OtherMenu(),
  ];
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTap(int selectItem) {
    _pageController.jumpToPage(selectItem);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screen,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
        ),
        //bodyMenu(),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: _onTap,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.home,
                  color: _selectedIndex == 0 ? Colors.green : Colors.grey,
                ),
                // title: Text(
                //   'หน้าแรก',
                //   style: TextStyle(
                //     color: _selectedIndex == 0 ? Colors.green : Colors.grey,
                //     fontFamily: 'Prompt',
                //   ),
                // ),
                label: 'หน้าแรก'),
            BottomNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.shipping_fast,
                  color: _selectedIndex == 1 ? Colors.green : Colors.grey,
                ),
                // title: Text(
                //   'สั่งสินค้า',
                //   style: TextStyle(
                //     color: _selectedIndex == 1 ? Colors.green : Colors.grey,
                //     fontFamily: 'Prompt',
                //   ),
                // ),
                label: 'หน้าแรก'),
            BottomNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.th_list,
                  color: _selectedIndex == 2 ? Colors.green : Colors.grey,
                ),
                // title: Text(
                //   'ประวัติ',
                //   style: TextStyle(
                //     color: _selectedIndex == 2 ? Colors.green : Colors.grey,
                //     fontFamily: 'Prompt',
                //   ),
                // ),
                label: 'ประวัติ'),
            BottomNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.money_bill,
                  color: _selectedIndex == 3 ? Colors.green : Colors.grey,
                ),
                // title: Text(
                //   'โอนเงิน',
                //   style: TextStyle(
                //     color: _selectedIndex == 3 ? Colors.green : Colors.grey,
                //     fontFamily: 'Prompt',
                //   ),
                // ),
                label: 'โอนเงิน'),
            BottomNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.list,
                  color: _selectedIndex == 4 ? Colors.green : Colors.grey,
                  size: 30.0,
                ),
                // title: const Text(
                //   '',
                // ),
                label: ''),
          ],
        ),
      ),
    );
  }

  /* bottomMenu() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: new Icon(
            LineAwesomeIcons.file_invoice_with_us_dollar,
            color: Colors.black54,
            size: 30.0,
          ),
          title: new Text(
            'แจ้งโอนเงิน',
            style: TextStyle(
              color: Colors.black54,
              fontFamily: 'Prompt',
              fontSize: 16.0,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => TransferPayment(),
              ),
            );
          },
        ),
        Divider(),
        ListTile(
          leading: new Icon(
            LineAwesomeIcons.power_off,
            color: Colors.black54,
            size: 30.0,
          ),
          title: new Text(
            'ออกจากระบบ',
            style: TextStyle(
              color: Colors.black54,
              fontFamily: 'Prompt',
              fontSize: 16.0,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Login(),
              ),
            );
          },
        ),
      ],
    );*/
}
