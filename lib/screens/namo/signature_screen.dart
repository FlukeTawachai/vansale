import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';

import 'package:vansale/function/substring_price.dart';
import 'package:vansale/screens/namo/show_signature.dart';

class SignatureTest extends StatefulWidget {
  final String typeMenuCode;
  const SignatureTest({
    Key? key,
    required this.typeMenuCode,
  }) : super(key: key);

  @override
  State<SignatureTest> createState() => _SignatureTestState();
}

class _SignatureTestState extends State<SignatureTest> {
  // initialize the signature controller
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
    exportPenColor: Colors.black,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => log('Value changed'));
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'ยืนยันการรับสินค้า',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Prompt',
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TopContainer(
              size: size,
            ),
            //SIGNATURE CANVAS
            Container(
              color: Colors.grey[300],
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: const Text(
                            'เซ็นรับสินค้า',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                        Signature(
                            height: 255,
                            width: 255,
                            key: const Key('signature'),
                            controller: _controller,
                            backgroundColor: Colors.white),
                        // SignatureMenu(
                        //   body: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     mainAxisSize: MainAxisSize.max,
                        //     children: <Widget>[
                        //       IconButton(
                        //         icon: const Icon(Icons.undo),
                        //         color: Colors.blue,
                        //         onPressed: () {
                        //           // setState(() => _controller.undo());
                        //         },
                        //         tooltip: 'Undo',
                        //       ),
                        //       IconButton(
                        //         icon: const Icon(Icons.redo),
                        //         color: Colors.blue,
                        //         onPressed: () {
                        //           // setState(() => _controller.redo());
                        //         },
                        //         tooltip: 'Redo',
                        //       ),
                        // //CLEAR CANVAS
                        // IconButton(
                        //   key: const Key('clear'),
                        //   icon: const Icon(Icons.clear),
                        //   color: Colors.blue,
                        //   onPressed: () {
                        //     // setState(() => _controller.clear());
                        //   },
                        //   tooltip: 'Clear',
                        // ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: //CLEAR CANVAS
                        Padding(
                      padding: const EdgeInsets.only(right: 5, top: 5),
                      child: InkWell(
                        child: const Icon(
                          Icons.clear,
                          color: Colors.green,
                        ),
                        onTap: () {
                          setState(() => _controller.clear());
                        },
                      ),
                    ),
                    //     IconButton(
                    //   key: const Key('clear'),
                    //   icon: const Icon(Icons.clear),
                    //   color: Colors.blue,
                    //   onPressed: () {
                    //     setState(() => _controller.clear());
                    //   },
                    //   tooltip: 'Clear',
                    // ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buttonBar(),
    );
  }

  Widget buttonBar() {
    return Container(
      height: 60.0,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 0.0,
            child: InkWell(
              onTap: () async {
                if (_controller.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      key: Key('snackbarPNG'),
                      content: Text('No content'),
                    ),
                  );
                  return;
                }
                Uint8List? data = await _controller.toPngBytes();
                if (data == null) {
                  return;
                }
                if (!mounted) return;

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (comtext) => SignatureComfirm(
                              widget.typeMenuCode,
                              imagedata: data,
                            )));
              },
              child: SizedBox(
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Icon(
                        LineAwesomeIcons.check_circle,
                        size: 25.0,
                        color: HexColor('#00cb39'),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'ยืนยันการรับสินค้า',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: HexColor('#00cb39'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignatureMenu extends StatelessWidget {
  SignatureMenu({
    Key? key,
    required this.body,
  }) : super(key: key);
  Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: body);
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '29/09/2563',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            'No. 630626-00XX',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black38,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const DottedLine(
                  lineThickness: 2.0,
                  dashColor: Colors.black38,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                  //color: HexColor("#F2F3F4"),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          child: Container(
                            //color: Colors.amber,
                            width: 70.0,
                            height: 70.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/brandon.png',
                                ),
                                scale: 1.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 5.0,
                              right: 5.0,
                              bottom: 5.0,
                              left: 10.0,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3.0),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Store name',
                                    style: TextStyle(
                                      fontFamily: 'Prompt',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(3.0),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: const Text(
                                          '32 รายการ',
                                          style: TextStyle(
                                            fontFamily: 'Prompt',
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Container(
                                        child: const Text(
                                          '32 ตระกร้า',
                                          style: TextStyle(
                                            fontFamily: 'Prompt',
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width / 2,
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'ส่วนลดสินค้า',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black38,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Prompt',
                        ),
                      ),
                      Container(
                        child: SubstringPrice(
                          '100.00',
                          14.0,
                          14.0,
                          Colors.black38,
                          Colors.black38,
                          'Prompt',
                          'Prompt',
                          FontWeight.normal,
                          FontWeight.normal,
                          'บาท',
                          14.0,
                          Colors.black38,
                          'Prompt',
                          FontWeight.normal,
                          FontStyle.normal,
                          FontStyle.normal,
                          FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: size.width / 2,
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: const Text(
                              'ส่วนลดท้ายบิล',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black38,
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                          Container(
                            child: SubstringPrice(
                              '50.00',
                              14.0,
                              14.0,
                              Colors.black38,
                              Colors.black38,
                              'Prompt',
                              'Prompt',
                              FontWeight.normal,
                              FontWeight.normal,
                              'บาท',
                              14.0,
                              Colors.black38,
                              'Prompt',
                              FontWeight.normal,
                              FontStyle.normal,
                              FontStyle.normal,
                              FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: SubstringPrice(
                          '3200.00',
                          14.0,
                          12.0,
                          Colors.orange,
                          Colors.orange,
                          'Prompt',
                          'Prompt',
                          FontWeight.bold,
                          FontWeight.bold,
                          'THB',
                          12.0,
                          Colors.black38,
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
                const DottedLine(
                  lineThickness: 2.0,
                  dashColor: Colors.black38,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'ชำระด้วยเงินสด',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                            fontFamily: 'Prompt',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: SubstringPrice(
                          '1000.00',
                          14.0,
                          12.0,
                          Colors.green,
                          Colors.green,
                          'Prompt',
                          'Prompt',
                          FontWeight.bold,
                          FontWeight.bold,
                          '฿',
                          12.0,
                          Colors.green,
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
              Container(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'เครดิต',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                            fontFamily: 'Prompt',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: SubstringPrice(
                          '2200.00',
                          14.0,
                          12.0,
                          Colors.red,
                          Colors.red,
                          'Prompt',
                          'Prompt',
                          FontWeight.bold,
                          FontWeight.bold,
                          '฿',
                          12.0,
                          Colors.red,
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
            ],
          ),
        ],
      ),
    );
  }
}
