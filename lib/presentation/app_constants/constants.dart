import 'package:flutter/cupertino.dart';

import '../../infrastructure/services/firebase_remote_config_service.dart';

class AppConstants {
  final RoundedRectangleBorder roundedRectangleBorder4 =
  RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));

  static String imagesBaseUrl = 'ImagesBaseUrl';
  static const String currentUser = 'currentUser';


  static String? makeImageUrl(String? path) {
    if (path != null && path.isNotEmpty) {
      return FirebaseRemoteConfigService().imagesBaseUrl + path;
    }
    return null;
  }



}