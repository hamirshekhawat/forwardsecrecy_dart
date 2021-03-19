import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

KeyPair localKeyPair;
String pkcs8PublicKey;
String pkcs8PrivateKey;

Future<String> generateKey() async {
  localKeyPair = await x25519.newKeyPair();
  await pkcs8EncodePrivateKey(localKeyPair.privateKey);
  pkcs8EncodePublicKey(localKeyPair.publicKey);
}

Future<String> pkcs8EncodePrivateKey(PrivateKey key) async {
  var keyBytes = await key.extract();
  var info = [48, 46, 2, 1, 0, 48, 5, 6, 3, 43, 101, 110, 4, 34, 4, 32];

  print(info + keyBytes);
  var dataBase64 = base64.encode(info + keyBytes);

  print('-----BEGIN PRIVATE KEY-----$dataBase64-----END PRIVATE KEY-----');
  return '-----BEGIN PRIVATE KEY-----$dataBase64-----END PRIVATE KEY-----';
}

String pkcs8EncodePublicKey(PublicKey key) {
  var keyBytes = key.bytes;
  var info = [48, 42, 48, 5, 6, 3, 43, 101, 110, 3, 33, 0];
  var a = Uint8List.fromList(keyBytes);
  print(info + a);
  var dataBase64 = base64.encode(info + a);

  print('-----BEGIN PUBLIC KEY-----$dataBase64-----END PUBLIC KEY-----');
  return '-----BEGIN PUBLIC KEY-----$dataBase64-----END PUBLIC KEY-----';
}

List<int> pkcs8DecodePrivateKey(String key) {
  var bytes = base64Decode(key
      .replaceAll('-----BEGIN PRIVATE KEY-----', '')
      .replaceAll('-----END PRIVATE KEY-----', ''));
  bytes = bytes.sublist(bytes.length - 32);
  print(bytes.length);
  //print(bytes);
  return bytes;
}

List<int> pkcs8DecodePublicKey(String key) {
  var bytes = base64Decode(key
      .replaceAll('-----BEGIN PUBLIC KEY-----', '')
      .replaceAll('-----END PUBLIC KEY-----', ''));
  bytes = bytes.sublist(bytes.length - 32);
  print(bytes.length);
  //print(bytes);
  return bytes;
}
