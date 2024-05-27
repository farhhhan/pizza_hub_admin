import 'dart:typed_data';

import 'package:image_picker_web/image_picker_web.dart';

class ImagePickerServices{
  
  Future<Uint8List?> getimageFromGellary()async{
    final file=await ImagePickerWeb.getImageAsBytes();
    return file;
  }
 
}