import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mashgh/locator.dart';

class StorageOperator {
  late FlutterSecureStorage flutterSecureStorage;
  StorageOperator() {
    flutterSecureStorage = locator<FlutterSecureStorage>();
  }

  push(String key, dynamic value) async {
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

  Future<dynamic> pull(String key) async {
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
}
