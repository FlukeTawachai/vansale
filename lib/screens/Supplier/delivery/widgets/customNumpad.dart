import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

// KeyPad widget
// This widget is reusable and its buttons are customizable (color, size)
class NumPad extends StatefulWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;

  const NumPad({
    Key key,
    this.buttonSize = 70,
    this.buttonColor = Colors.indigo,
    this.iconColor = Colors.amber,
    this.delete,
    this.onSubmit,
    this.controller,
  }) : super(key: key);

  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // implement the number keys (from 0 to 9) with the NumberButton widget
            // the NumberButton widget is defined in the bottom of this file
            children: [
              NumberButton(
                number: 1,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              NumberButton(
                number: 2,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              NumberButton(
                number: 3,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 4,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              NumberButton(
                number: 5,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              NumberButton(
                number: 6,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 7,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              NumberButton(
                number: 8,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              NumberButton(
                number: 9,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // this button is used to submit the entered value
              SizedBox(
                width: widget.buttonSize,
                height: widget.buttonSize,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: widget.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => widget.onSubmit(),
                  child: Center(
                    child: Text(
                      "C",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Prompt',
                      ),
                    ),
                  ),
                ),
              ),

              NumberButton(
                number: 0,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              // this button is used to delete the last number
              SizedBox(
                width: widget.buttonSize,
                height: widget.buttonSize,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: widget.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Center(
                    child: IconButton(
                      onPressed: () => widget.delete(),
                      icon: Icon(
                        LineAwesomeIcons.arrow_left,
                        color: widget.iconColor,
                      ),
                      iconSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// define NumberButton widget
// its shape is round
class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key key,
    this.number,
    this.size,
    this.color,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          controller.text += number.toString();
        },
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
