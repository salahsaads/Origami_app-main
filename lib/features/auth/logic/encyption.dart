import 'package:encrypt/encrypt.dart';

class Encryption {
//   // Generate a random key
//   final key = encrypt.Key.fromSecureRandom(32);

// // Generate a random IV (Initialization Vector)
//   final iv = encrypt.IV.fromSecureRandom(16);
//   String encryptPassword(String password) {
//     final encrypter = encrypt.Encrypter(encrypt.AES(key));
//     final encrypted = encrypter.encrypt(password, iv: iv);
//     return encrypted.base64;
//   }

//   String decryptPassword(String encryptedPassword) {
//     final encrypter = encrypt.Encrypter(encrypt.AES(key));
//     final decrypted = encrypter.decrypt64(encryptedPassword, iv: iv);
//     return decrypted;
//   }
  final key = Key.fromUtf8('my32lengthsupersecretnooneknows1');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

  String encrypt(String text) {
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  String decrypt(String encrypted) {
    final decrypted = encrypter.decrypt64(encrypted, iv: iv);
    return decrypted;
  }
}
