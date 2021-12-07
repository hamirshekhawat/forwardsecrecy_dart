import 'package:forwardsecrecy_dart/forwardsecrecy_dart.dart';

main() async {
  final localNonce = "z8Ceew+f/jks6vEmc4yZwDPjSVrmNn1A9dtRcR9baBk=";
  final remoteNonce = "iLA8GoqznxB+LEq6rz6YlepJo4g92TUnmqHOXUaU0dE=";

  // Encryption of string "nice!" using https://hub.docker.com/r/gsasikumar/forwardsecrecy/tags
  var ciphertext = 'r5uXttRsjFLoysYlOMY9hX23rUGB7ZiE';

  // Shared key created using https://hub.docker.com/r/gsasikumar/forwardsecrecy/tags.
  // Public and private keys were also created using https://hub.docker.com/r/gsasikumar/forwardsecrecy/tags.
  var sharedKey = 'R/UWnxiNzlD+w/yzRGO7Yc0D5x5phtng0mo1bzNW2Ac=';

  var decryptedText = await decrypt(
    base64EncryptedData: ciphertext,
    base64SharedSecret: sharedKey,
    base64RemoteNonce: remoteNonce,
    base64LocalNonce: localNonce,
  );

  print(decodedString(decryptedText));
}
