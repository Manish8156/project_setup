import 'dart:convert';
import 'dart:developer' as dev;

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:project_setup/core/constants/app_enums.dart';
import 'package:project_setup/layers/data/models/auth_models/response_models/login_response_data.dart';

/// for locally cache only hive_helper and injector in singleton defined...
abstract class HiveDataRepository<T> {
  Future<void> openBox({String saltKey = 'XyNopEpigA'});

  Future<void> closeBox();

  Future<void> clearBox();

  Future<void> putData({required String key, required dynamic value});

  T? getData({required String key});

  List<T?>? getListOfData();

  Future<void> deleteData({required String key});
}

class EncryptedHiveDataRepository<T> implements HiveDataRepository<T> {
  final String _boxKey;
  late Box<T> box;
  bool isOpen = false;

  EncryptedHiveDataRepository({required String boxKey}) : _boxKey = boxKey {
    assert(boxKey.trim().isNotEmpty, 'Box key must not be empty');
  }

  @override
  Future<void> openBox({String saltKey = 'XyNopEpigA'}) async {
    if (isOpen) return;

    if (saltKey.trim().isEmpty) {
      box = await Hive.openBox(_boxKey);
    } else {
      /// HiveAesCipher work for both crypt decrypt the data , only we have to generate the functions
      box = await Hive.openBox<T>(
        _boxKey,
        encryptionCipher: HiveAesCipher(
          _generateKey(
            saltKey: saltKey,
            hashAlgorithm: sha256,
          ),
        ),
      );
    }

    isOpen = box.isOpen;
  }

  @override
  Future<void> closeBox() async {
    if (isOpen) {
      await box.close();
    } else {
      throw (Exception('Make sure the box is open for the key: $_boxKey'));
    }
  }

  @override
  Future<void> clearBox() async {
    if (isOpen) {
      await box.clear();
    } else {
      throw (Exception('Make sure the box is open for the key: $_boxKey'));
    }
  }

  @override
  Future<void> deleteData({required String key}) async {
    if (isOpen) {
      await box.delete(key);
    } else {
      throw (Exception('Make sure the box is open for the key: $_boxKey'));
    }
  }

  @override
  T? getData({required String key}) {
    if (isOpen) {
      return box.get(key, defaultValue: _getDefaultValue());
    } else {
      throw (Exception('Make sure the box is open for the key: $_boxKey'));
    }
  }

  @override
  List<T?>? getListOfData() {
    if (isOpen) {
      return box.values.toList();
    } else {
      throw (Exception('Make sure the box is open for the key: $_boxKey'));
    }
  }

  @override
  Future<void> putData({required String key, required value}) async {
    if (isOpen) {
      await box.put(key, value);
    } else {
      throw (Exception('Make sure the box is open for the key: $_boxKey'));
    }
  }

  T? _getDefaultValue() {
    if (T is String) {
      return '' as T;
    } else if (T is int || T is num || T is double) {
      return 0 as T;
    } else if (T is bool) {
      return false as T;
    } else {
      return null;
    }
  }

  /// this for secure the password or other credentials with Cryptographic.
  Uint8List _generateKey({String? saltKey, Hash? hashAlgorithm}) {
    if ((saltKey ?? '').trim().isEmpty) {
      throw (Exception());
    }

    int iterations = 1000;
    int keyLength = 32;

    if (hashAlgorithm == null) {
      throw ArgumentError('A hash algorithm must be provided.');
    }

    // Convert the password and salt to bytes
    final saltBytes = utf8.encode(saltKey!);

    // Calculate the length of each hash output in bytes
    final hashLength = hashAlgorithm.convert([0]).bytes.length;

    // Calculate the number of blocks to compute
    final blocks = (keyLength + hashLength - 1) ~/ hashLength;

    // Initialize the derived key
    var derivedKey = Uint8List(blocks * hashLength);

    // Perform the key derivation
    for (var block = 1; block <= blocks; block++) {
      var blockStart = (block - 1) * hashLength;
      var blockBytes = Uint8List(hashLength + saltBytes.length);

      // Append the salt to the block bytes
      blockBytes.setRange(0, saltBytes.length, saltBytes);

      // Append the block number in big-endian encoding
      blockBytes[blockBytes.length - 4] = (block >> 24) & 0xff;
      blockBytes[blockBytes.length - 3] = (block >> 16) & 0xff;
      blockBytes[blockBytes.length - 2] = (block >> 8) & 0xff;
      blockBytes[blockBytes.length - 1] = block & 0xff;

      // Calculate the initial hash value
      var u = hashAlgorithm.convert(blockBytes);

      // Perform the iterations
      for (var iter = 1; iter < iterations; iter++) {
        // Calculate u1, u2, ..., u(iterations)
        var ui = hashAlgorithm.convert(u.bytes);

        // XOR the intermediate hash values
        for (var j = 0; j < hashLength; j++) {
          derivedKey[blockStart + j] ^= ui.bytes[j];
        }

        u = ui;
      }
    }

    // Return the derived key of the specified length
    return derivedKey.sublist(0, keyLength);
  }
}

class HiveAppRepository {
  /// lets take example of login response adapter data to store in locally
  /// for adaptor its non primitive data type , which is supported by the hive to store the data, for adaptor we have to generate with hiveGenerator.
  final EncryptedHiveDataRepository<String> _loggedInUserToken;
  final EncryptedHiveDataRepository<LoginResponseData> _loginResponseDataHiveRepo;
  final EncryptedHiveDataRepository<String> _fcmTokenValue;

  HiveAppRepository({
    required EncryptedHiveDataRepository<String> loggedInUserToken,
    required EncryptedHiveDataRepository<LoginResponseData> loginResponseDataHiveRepo,
    required EncryptedHiveDataRepository<String> fcmTokenValue,
  })  : _loginResponseDataHiveRepo = loginResponseDataHiveRepo,
        _fcmTokenValue = fcmTokenValue,
        _loggedInUserToken = loggedInUserToken;

  Future<void> registerAdapters() async {
    Hive.registerAdapter(LoginResponseDataAdapter());
  }

  Future<void> openBox() async {
    await _loginResponseDataHiveRepo.openBox();
    await _fcmTokenValue.openBox();
    await _loggedInUserToken.openBox();
  }

  Future<void> closeBox() async {
    await _loginResponseDataHiveRepo.closeBox();
    await _fcmTokenValue.closeBox();
    await _loggedInUserToken.closeBox();
  }

  Future<void> clearBox() async {
    await _loginResponseDataHiveRepo.clearBox();
    await _fcmTokenValue.clearBox();
    await _loggedInUserToken.clearBox();
  }

  Future<void> putLoggedInUserToken({required String key, required String value}) async {
    return await _loggedInUserToken.putData(key: key, value: value);
  }

  Future<String?> getLoggedInUserToken() async {
    return _loggedInUserToken.getData(key: HiveEntityKeys.loggedInUserToken.value);
  }

  Future<void> putFcmToken({
    required String key,
    required String value,
  }) async {
    dev.log('HiveAppRepository putStringData :: $key : $value');
    return await _fcmTokenValue.putData(key: key, value: value);
  }

  String? getFcmToken({
    required String key,
  }) {
    dev.log('HiveAppRepository getStringData :: $key');
    return _fcmTokenValue.getData(key: key);
  }

  Future<void> deleteGetFcmToken({
    required String key,
  }) async {
    dev.log('HiveAppRepository deleteStringData :: $key');
    return await _fcmTokenValue.deleteData(key: key);
  }

  Future<void> putLoginResponseData({
    required LoginResponseData loginResponseData,
  }) async {
    dev.log('HiveRepository putLoginResponseData :: $loginResponseData');
    await _loginResponseDataHiveRepo.putData(
      key: HiveEntityKeys.loggedInUser.value,
      value: loginResponseData,
    );
  }

  LoginResponseData? getLoginResponseData() {
    return _loginResponseDataHiveRepo.getData(key: HiveEntityKeys.loggedInUser.value);
  }
}
