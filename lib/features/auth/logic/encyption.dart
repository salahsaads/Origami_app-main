import 'package:encrypt/encrypt.dart' as encrypt;

class Encryption {
  // Generate a random key
  final key = encrypt.Key.fromSecureRandom(32);

// Generate a random IV (Initialization Vector)
  final iv = encrypt.IV.fromSecureRandom(16);
  String encryptPassword(String password) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }

  String decryptPassword(String encryptedPassword) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(encryptedPassword, iv: iv);
    return decrypted;
  }
}
