import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vansale/screens/Supplier/delivery/widgets/customNumpad.dart';
import 'package:vansale/screens/Supplier/models/delayTime.dart';

DelayTime delay = new DelayTime();

class CheckInMiles extends StatefulWidget {
  final String headerTitle;
  final String title;
  final Function submit;
  final Function cancel;
  const CheckInMiles({
    Key key,
    this.headerTitle,
    this.title,
    this.submit,
    this.cancel,
  }) : super(key: key);

  @override
  State<CheckInMiles> createState() => _CheckInMilesState();
}

class _CheckInMilesState extends State<CheckInMiles> {
  var _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          widget.headerTitle,
          style: TextStyle(
            color: Colors.black,
            //color: Color.fromRGBO(0, 157, 181, 5),
            fontFamily: 'Prompt',
            fontSize: 18.0,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.grey,
              //color: Color.fromRGBO(0, 157, 181, 5),
              fontFamily: 'Prompt',
              fontSize: 18.0,
            ),
          ),
          // display the entered numbers
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 70,
              child: Center(
                  child: TextField(
                controller: _myController,
                textAlign: TextAlign.center,
                showCursor: false,
                style: const TextStyle(fontSize: 40),
                // Disable the default soft keybaord
                keyboardType: TextInputType.none,
              )),
            ),
          ),
          // implement the custom NumPad
          NumPad(
            buttonSize: 75,
            buttonColor: Colors.white,
            iconColor: Colors.black,
            controller: _myController,
            delete: () {
              _myController.text = _myController.text
                  .substring(0, _myController.text.length - 1);
            },
            // do something with the input numbers
            onSubmit: () {
              _myController.clear();
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
        child: Container(
          height: 128.0,
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(48.0),
          child: Card(
            elevation: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        widget.cancel();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Icon(
                              LineAwesomeIcons.times_circle,
                              size: 25.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Container(
                            //alignment: Alignment.centerLeft,
                            child: Text(
                              'ยกเลิก',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey,
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 96),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        widget.submit();

                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (comtext) =>
                        //         ConfirmPages("T008", "เช็คอิน")));
                        // Future.delayed(
                        //     Duration(seconds: delay.getTimeDelay()), () {
                        //   Navigator.of(context).pushAndRemoveUntil(
                        //       MaterialPageRoute(
                        //           builder: (context) => MainMenu("T002")),
                        //       (Route<dynamic> route) => false);
                        // });
                      },
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Icon(
                              LineAwesomeIcons.check_circle,
                              size: 25.0,
                              color: HexColor('#00cb39'),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'ตกลง',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: HexColor('#00cb39'),
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
