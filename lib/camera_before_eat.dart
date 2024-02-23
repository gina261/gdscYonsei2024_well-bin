import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
// import 'home.dart';
// import 'package:path/path.dart';

class GetImageBeforeEat extends StatefulWidget {
  const GetImageBeforeEat({super.key});

  @override
  State<GetImageBeforeEat> createState() => _GetImageBeforeEatState();
}

class _GetImageBeforeEatState extends State<GetImageBeforeEat> {
  // File _image = File('');
  XFile? selectedImage;
  firebase_storage.Reference? storageReference;
  String formattedDate = DateFormat('yyyyMMddHHmmss').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    storageReference = firebase_storage.FirebaseStorage.instance.ref();
  }

  // 이미지 storage에 업로드
  Future<String?> uploadImage(File image) async {
    try {
      DatabaseReference urlReference = FirebaseDatabase.instance.ref();
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference reference =
          storageReference!.child('images/beforeEat/$fileName');
      firebase_storage.UploadTask uploadTask = reference.putFile(image);
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURLbeforeEat = await taskSnapshot.ref.getDownloadURL();

      //url도 realtime에 업로드
      await urlReference
          .child(formattedDate)
          .child('foodURL')
          .set(downloadURLbeforeEat);
      return downloadURLbeforeEat;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var imagePicker = ImagePicker();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (selectedImage != null)
                ClipRRect(
                  child: Image.asset(
                    selectedImage!.path,
                    width: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black),
                      fixedSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      var cameraImage = await imagePicker.pickImage(
                        source: ImageSource.camera,
                      );
                      if (cameraImage != null) {
                        debugPrint('Image Selected');
                        selectedImage = cameraImage;
                        setState(() {});
                      } else {
                        debugPrint('Nothing Selected');
                      }
                    },
                    child: const Text(
                      'Camera',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () async {
                      var galleryImage = await imagePicker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (galleryImage != null) {
                        debugPrint('Image Selected');
                        selectedImage = galleryImage;
                        setState(() {});
                      } else {
                        debugPrint('Nothing Selected');
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black),
                      fixedSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  if (selectedImage != null) {
                    String? downloadURLbeforeEat =
                        await uploadImage(File(selectedImage!.path));
                    if (downloadURLbeforeEat != null) {
                      debugPrint(
                          'Image uploaded. Download URL: $downloadURLbeforeEat');

                      //Navigator.pop(context, downloadURLbeforeEat);
                      Navigator.pop(
                          context, [downloadURLbeforeEat, formattedDate]);
                    }
                  } else {
                    debugPrint('No image selected');
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff49c14e),
                  fixedSize: const Size(320, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Upload',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
