
import '../infrastructure/services/firebase_remote_config_service.dart';

class Utils {
  final _remoteConfig = FirebaseRemoteConfigService();


  String? makeImageUrl(String? path) {
    if (path != null && path.isNotEmpty) {
      return FirebaseRemoteConfigService().imagesBaseUrl + path;
    }
    return null;
  }
}