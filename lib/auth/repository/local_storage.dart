import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final storage = new FlutterSecureStorage();

  Future<void> deleteStorage(String key) async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(microseconds: 100));
    await storage.delete(key: key);
    return;
  }

  Future<void> writeStorage(String key, String value) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(microseconds: 100));
    await storage.write(key: key, value: value);
    return;
  }

  Future<bool> hasStorage(String key) async {
    /// Has from keystore/keychain
    await Future.delayed(Duration(microseconds: 100));
    String value = await storage.read(key: key);
    if (value == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> readStorage(String key) async {
    /// Has from keystore/keychain
    await Future.delayed(Duration(microseconds: 100));
    return await storage.read(key: key);
  }
}
