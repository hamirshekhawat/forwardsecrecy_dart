import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

/// Returns base64 encoded string of the data. Please note that for decoding this string, utility method [decodedString] can be used
Future<String> decrypt({
  required String base64EncryptedData,
  required String base64SharedSecret,
  required String base64RemoteNonce,
  required String base64LocalNonce,
}) async {
  // 256 Bit AES GCM used as shared key length is 32 bytes
  final cipher = AesGcm.with256bits();
  final hkdf = Hkdf(
    hmac: Hmac.sha256(),
    outputLength: 32,
  );

  // Key Derivation
  final xordNonces = _xor(base64Decode(base64RemoteNonce), base64Decode(base64LocalNonce));
  final salt = xordNonces.sublist(0, 20);
  final iv = xordNonces.sublist(20, 32);
  final sessionKey = await hkdf.deriveKey(secretKey: SecretKey(base64Decode(base64SharedSecret)), nonce: salt);

  // Decryption
  final base64DecodedCipher = base64Decode(base64EncryptedData);
  final secretBox = _secretBoxFromDataWithMacConcatenation(base64DecodedCipher, nonce: Uint8List.fromList(iv));
  var decrypted = await cipher.decrypt(secretBox, secretKey: sessionKey);

  // Base64Encoded string is returned
  return utf8.decode(decrypted);
}

/// [encodedString] is base64Encoded.
String decodedString(String encodedString) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  return stringToBase64.decode(encodedString);
}

// This is required as BouncyCastle concats the MAC at the end of the encrypted data
SecretBox _secretBoxFromDataWithMacConcatenation(
  Uint8List cipherText, {
  int macByteLength = 16,
  required Uint8List nonce, // 12 Bytes IV
}) {
  return SecretBox(
    Uint8List.sublistView(cipherText, 0, cipherText.lengthInBytes - macByteLength),
    mac: Mac(Uint8List.sublistView(cipherText, cipherText.lengthInBytes - macByteLength)),
    nonce: nonce,
  );
}

/// Utility method to create concatenated nonce
List<int> _xor(List<int> a, List<int> b) {
  var result = <int>[];
  for (var i = 0; i < a.length; i++) {
    result.add(a[i] ^ b[i]);
  }
  return result;
}
