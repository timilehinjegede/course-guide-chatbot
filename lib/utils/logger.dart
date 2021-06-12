import 'dart:developer';

class Logger {
  Logger._();

  static void info(String info) {
    log('This is at this point $info');
  }

  static void value(String hint, String value) {
    log('This is at $hint with value => $value');
  }

  static void error(String hint, String message) {
    log('This is at $hint with error message => $message');
  }
}
