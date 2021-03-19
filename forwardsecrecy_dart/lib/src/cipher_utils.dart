import 'dart:convert';

import 'package:cryptography/cryptography.dart';

// String encrypt(String data, String base64SharedSecret, String base64RemoteNonce, String base64LocalNonce) {

// }

Future<String> decrypt(String base64EncryptedData, String base64SharedSecret,
    String base64RemoteNonce, String base64LocalNonce) async {
  const cipher = aesGcm;
  final hkdf = Hkdf(Hmac(sha256));

  //Key Derivation
  final xordNonces =
      _xor(base64Decode(base64RemoteNonce), base64Decode(base64LocalNonce));
  final salt = Nonce(xordNonces.sublist(0, 20));
  final iv = Nonce(xordNonces.sublist(20, 32));
  final sessionKey = await hkdf.deriveKey(
      SecretKey(base64Decode(base64SharedSecret)),
      outputLength: 32,
      nonce: salt);

  final decrypted = await cipher.decrypt(
    base64.decode(base64EncryptedData),
    secretKey: sessionKey,
    nonce: iv,
  );

  return utf8.decode(decrypted);
}

List<int> _xor(List<int> a, List<int> b) {
  var result = <int>[];
  for (var i = 0; i < a.length; i++) {
    result.add(a[i] ^ b[i]);
  }
  return result;
}
