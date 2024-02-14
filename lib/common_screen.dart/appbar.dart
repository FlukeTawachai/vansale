import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/common_screen.dart/body_page.dart';
import 'package:vansale/function/title_appbar.dart';
import 'package:vansale/screens/home/home.dart';

class AppbarPage extends StatefulWidget {
  final String titleName;
  final String typeMenuCode;
  AppbarPage(this.titleName, this.typeMenuCode);

  @override
  _AppbarPageState createState() => _AppbarPageState();
}

class _AppbarPageState extends State<AppbarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          centerTitle: true,
          leading: widget.titleName == 2.toString() ||
                  widget.titleName == 5.toString()
              ? IconButton(
                  icon: Icon(LineAwesomeIcons.home, color: Colors.black),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          HomePage(widget.typeMenuCode.toString()),
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
          title: TitleName(
            widget.titleName,
          ),
          actions: [
            Row(
              children: [
                Container(
                  child: _checkpage(context),
                ),
              ],
            ),
          ],
        ),
      ),
      body: ShowBody(widget.titleName, widget.typeMenuCode),
    );
  }

  _checkpage(context) {
    String titlename = widget.titleName;
    switch (titlename) {
      case '11':
        return Container(
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              LineAwesomeIcons.vertical_ellipsis,
              color: Colors.black,
            ),
          ),
        );
        break;
      case '12':
        return Container(
          child: Row(
            children: [
              Container(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    LineAwesomeIcons.qrcode,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    LineAwesomeIcons.vertical_ellipsis,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      default:
        return Container();
    }
  }
}
