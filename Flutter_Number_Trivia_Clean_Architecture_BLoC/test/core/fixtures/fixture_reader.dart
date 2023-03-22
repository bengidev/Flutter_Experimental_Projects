import 'dart:io';

class FixtureReader {
  static String createFile({required String fileName}) {
    String result = "";

    try {
      result = File('test/core/fixtures/$fileName').readAsStringSync();
    } on FileSystemException catch (e) {
      result = e.message;
    }

    return result;
  }
}
