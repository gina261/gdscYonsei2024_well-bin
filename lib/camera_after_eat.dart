import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class GetImageAfterEat extends StatefulWidget {
  const GetImageAfterEat({super.key});

  @override
  State<GetImageAfterEat> createState() => _GetImageAfterEatState();
}

class _GetImageAfterEatState extends State<GetImageAfterEat> {
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

  // Upload the image to storage
  Future<String?> uploadImage(File image) async {
    try {
      DatabaseReference urlReference = FirebaseDatabase.instance.ref();
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference reference =
          storageReference!.child('images/afterEat/$fileName');
      firebase_storage.UploadTask uploadTask = reference.putFile(image);
      firebase_storage.TaskSnapshot takeSnapshot = await uploadTask;
      String downloadURLafterEat = await takeSnapshot.ref.getDownloadURL();

      await urlReference
          .child('afterEat')
          .child(formattedDate)
          .set(downloadURLafterEat);
      return downloadURLafterEat;
    } catch (e) {
      debugPrint('Error uploading After Eat image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var imagePicker = ImagePicker();

    return Scaffold(
      backgroundColor: const Color(0xff49c14e),
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
                      // side: const BorderSide(color: Colors.black),
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
                        debugPrint('After Eat Image Selected');
                        selectedImage = cameraImage;
                        setState(() {});
                      } else {
                        debugPrint('After Eat Nothing Selected');
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
                        debugPrint('After Eat Image Selected');
                        selectedImage = galleryImage;
                        setState(() {});
                      } else {
                        debugPrint('After Eat Nothing Selected');
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      // side: const BorderSide(color: Colors.black),
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
                    // debugPrint('afterEat img exists');
                    String? downloadURLafterEat =
                        await uploadImage(File(selectedImage!.path));
                    if (downloadURLafterEat != null) {
                      debugPrint(
                          'After Eat Image uploaded. Download URL: $downloadURLafterEat');

                      Navigator.pop(
                          context, [downloadURLafterEat, formattedDate]);
                    }
                  } else {
                    debugPrint('After Eat No image Selected');
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 201, 244, 204),
                  fixedSize: const Size(320, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Upload',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
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
