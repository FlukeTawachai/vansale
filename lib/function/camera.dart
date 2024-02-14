import 'package:flutter/cupertino.dart';

actionsheet(BuildContext context) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              // _openCamera();
              Navigator.of(context).pop();
            },
            child: Text('Take Photo'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              //_openGallary();
              Navigator.of(context).pop();
            },
            child: Text('Choose Photo'),
          ),
        ],
      );
    },
  );
}
