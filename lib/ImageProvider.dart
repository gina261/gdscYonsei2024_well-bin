import 'package:flutter/foundation.dart';

class ImageProvider extends ChangeNotifier {
  String? _uploadedImageUrlbeforeEat;

  String? get uploadedImageUrlbeforeEat => _uploadedImageUrlbeforeEat;

  set uploadedImageUrlbeforeEat(String? value) {
    _uploadedImageUrlbeforeEat = value;
    notifyListeners();
  }
}
