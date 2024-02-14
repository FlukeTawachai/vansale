import 'dart:io';

import 'package:image_picker/image_picker.dart';

class GetImage {
  List<File> _imageFileList = [];
  File? _imageFile;

  // Future pickImage(ImageSource source) async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: source,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     print("********** add image **********");
  //     _imageFile = File(pickedFile.path);
  //     _imageFileList.add(File(pickedFile.path));
  //     // print(
  //     //     "++++++++++++++++++++++++++++++Image list: ${_imageFileList.length}++++++++++++++++++++++++++++++");
  //   }
  // }

  //   Future pickInserImage(ImageSource source,int index) async {
      
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: source,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if ((pickedFile != null)&&(_imageFileList.length > index)) {
  //     print("********** insert image **********");
  //     _imageFile = File(pickedFile.path);
  //     _imageFileList.removeAt(index);
  //     _imageFileList.insert(index, File(pickedFile.path));
      
  //   }
  // }

  bool imageFileIsNull() {
    if (_imageFile == null) {
      return true;
    } else {
      return false;
    }
  }

  bool imageFileListIsEntity() {
    if (_imageFileList.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  File getimageFile() {
    return _imageFile!;
  }

  List<File> getImageFileList() {
    return _imageFileList;
  }

  clearImageFileList() {
    _imageFileList.clear();
  }

  removeImageFileList(int index) {
    _imageFileList.remove(index);
  }

  inserImageFileList(int index,File image) {
    _imageFileList.insert(index, image);
  }
}
