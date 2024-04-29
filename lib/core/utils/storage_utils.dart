import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class Storage {
  static final _box = GetStorage('OOMPH');

  Storage._();

  static void set(String key, dynamic value) => _box.write(key, value);

  static dynamic get<T>(String key) => _box.read<T>(key);

  /// Auth token prefrences
  static void setAuthToken(dynamic value) => _box.write(StorageKeys.authToken, value);

  static dynamic getAuthToken() => _box.read(StorageKeys.authToken);

  static dynamic clearAuthToken<T>() => _box.remove(StorageKeys.authToken);

  static String fetchAuthToken() => _box.read(StorageKeys.authToken);

  static void clear() {
    _box.erase();
  }
}

class StorageKeys {
  static const containerKey = "AppName";
  static const authToken = "authToken";
}

String getPrettyJSONString(jsonObject) {
  var encoder = const JsonEncoder.withIndent("     ");
  return encoder.convert(jsonObject);
}
