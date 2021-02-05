import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

enum PickType {
  Camera,
  Gallery,
}

class BaseServices {
  //* pickimage
  static Future<File> pickImage(PickType type) async {
    var image = await ImagePicker().getImage(
      source:
          (type == PickType.Camera) ? ImageSource.camera : ImageSource.gallery,
    );
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  //* Store Image in Backgroud
  static Future<String> uploadImagetoFirestore(File file) async {
    String fileName = basename(file.path);
    var ref = FirebaseStorage.instance.ref().child(fileName);
    var task = ref.putFile(file);
    // task.snapshotEvents.listen((ts) async {
    //   if (ts.state == TaskState.success) {
    //     url = await ts.ref.getDownloadURL();
    //   }
    //   // return url;
    // });

    var whenComplete = await task.whenComplete(() {});
    String url = await whenComplete.ref.getDownloadURL();
    //masih null boi
    return url;
  }
}
