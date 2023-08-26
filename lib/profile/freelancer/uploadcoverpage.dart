import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadcoverpage(File imageFile) async {
  final Reference storageRef = FirebaseStorage.instance.ref().child('cover_image/${imageFile.path.split('/').last}');
  final TaskSnapshot uploadTask = await storageRef.putFile(imageFile);
  final String downloadUrl = await uploadTask.ref.getDownloadURL();
  return downloadUrl;
}