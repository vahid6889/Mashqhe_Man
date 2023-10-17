import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mashgh/locator.dart';

class StorageOperator {
  late FlutterSecureStorage flutterSecureStorage;
  StorageOperator() {
    flutterSecureStorage = locator<FlutterSecureStorage>();
  }

  push(String key, String value) async {
    await flutterSecureStorage.write(
      key: key,
      value: value,
      aOptions: const AndroidOptions(
        encryptedSharedPreferences: true,
        keyCipherAlgorithm:
            KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
        storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
      ),
    );
  }

  Future<String> pull(String key) async {
    final status = await flutterSecureStorage.read(
      key: key,
      aOptions: const AndroidOptions(
        encryptedSharedPreferences: true,
        keyCipherAlgorithm:
            KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
        storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
      ),
    );
    if (status == null) {
      return '';
    }
    return status;
  }

  destroyKey(String key) async {
    await flutterSecureStorage.delete(
      key: key,
    );
  }

  destroyAll(String key) async {
    await flutterSecureStorage.deleteAll(
      aOptions: const AndroidOptions(
        encryptedSharedPreferences: true,
        keyCipherAlgorithm:
            KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
        storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
      ),
    );
  }

  // saveSelectedLanguage(String langaugeKey, String langaugeCode) async {
  //   sharedPreferences.setString(langaugeKey, langaugeCode);
  // }

  // Future<String> getSelectedLanguage(String langaugeKey) async {
  //   final status = sharedPreferences.getString(langaugeKey);
  //   if (status == null) {
  //     return '';
  //   }
  //   return status;
  // }

  // saveSelectedTheme(String themeKey, bool themeStatus) async {
  //   sharedPreferences.setBool(themeKey, themeStatus);
  // }

  // Future<bool> getSelectedTheme(String themeKey) async {
  //   final status = sharedPreferences.getBool(themeKey);
  //   if (status == null) {
  //     return true;
  //   }
  //   return status;
  // }

  // saveUserToken(String tokenKey, String tokenValue) async {
  //   sharedPreferences.setString(tokenKey, tokenValue);
  // }

  // setLoggedIn(String loggedKey, bool loggedStatus) async {
  //   sharedPreferences.setBool(loggedKey, loggedStatus);
  // }

  // Future<bool> getLoggedIn(String loggedKey) async {
  //   final status = sharedPreferences.getBool(loggedKey);
  //   if (status == null) {
  //     return false;
  //   }
  //   return status;
  // }

  // saveUserProfile(List<String> userProfile) async {
  //   sharedPreferences.setStringList('user_profile', userProfile);
  // }

  // Future<List<String>> getUserProfile() async {
  //   final status = sharedPreferences.getStringList('user_profile');
  //   if (status == null) {
  //     return [];
  //   }
  //   return status;
  // }

  // Future<void> logout() async {
  //   sharedPreferences.remove("LoggedIn");
  //   sharedPreferences.remove("user_token");
  // }

  // Future<void> destroy() async {
  //   sharedPreferences.clear();
  // }
}
