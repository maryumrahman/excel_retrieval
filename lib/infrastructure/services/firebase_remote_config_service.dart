import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../presentation/app_constants/constants.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._()
      : _remoteConfig = FirebaseRemoteConfig.instance;

  static FirebaseRemoteConfigService? _instance;

  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._();

  final FirebaseRemoteConfig _remoteConfig;


  String get imagesBaseUrl =>
      _remoteConfig.getString(AppConstants.imagesBaseUrl);

}