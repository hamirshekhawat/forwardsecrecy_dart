// TODO: Put public facing types in this file.
import 'dart:convert';

import 'package:cryptography/cryptography.dart';

import 'x25519key_utils.dart';


// Future<void> main() async {
//   //await generateKey();
//   final encryptedData = 'h4NpsW4Bg7w/aR7Y0PY9YMXL25cFeC/Mew==';
//   final publickey = PublicKey(pkcs8DecodePublicKey(
//       '-----BEGIN PUBLIC KEY-----MCowBQYDK2VuAyEAfHg/Gju99nDRvD8Th8y07Xx7WnN7/vJsTbQTeBW/Uio=-----END PUBLIC KEY-----'));
//   final privateKey = PrivateKey(pkcs8DecodePrivateKey(
//       '-----BEGIN PRIVATE KEY-----MC4CAQAwBQYDK2VuBCIEIFD/8jJv6JD35i5JMyMYEdGKMPxVmM5i6IYesnWtudxt-----END PRIVATE KEY-----'));

//   var base64nonce1 = 'UT1Bo/ZFmk+H6RCRPjPJVE4M1U7yAoiJg3B4HdUfSJY=';
//   var base64nonce2 = 'v1o06JeRH6RVBz1kVXcGrGL7W/QyVkoAbyCpz2O+KEc=';

//   var nonce1 = base64Decode(base64nonce1);
//   var nonce2 = base64Decode(base64nonce2);

//   const cipher = aesGcm;
//   final hkdf = Hkdf(Hmac(sha256));
//   var sharedSecret = await x25519.sharedSecret(
//     localPrivateKey: privateKey,
//     remotePublicKey: publickey,
//   );

//   //Key Derivation
//   final xordNonces = xor(nonce1, nonce2);
//   final salt = Nonce(xordNonces.sublist(0, 20));
//   final iv = Nonce(xordNonces.sublist(20, 32));
//   final sessionKey =
//       await hkdf.deriveKey(sharedSecret, outputLength: 32, nonce: salt);

//   final decrypted = await cipher.decrypt(
//     base64.decode(encryptedData),
//     secretKey: sessionKey,
//     nonce: iv,
//   );

//   print(utf8.decode(decrypted));
// }

// List<int> xor(List<int> a, List<int> b) {
//   var result = <int>[];
//   for (var i = 0; i < a.length; i++) {
//     result.add(a[i] ^ b[i]);
//   }
//   return result;
// }

// // Future<void> main() async {
// //   print(base64Encode(Nonce.randomBytes(32).bytes));
// //   print(base64Encode(Nonce.randomBytes(32).bytes));

// //   await generateKey();
// //   print('public key' + pkcs8PublicKey);
// //   print('private key' + pkcs8PrivateKey);
// // }
