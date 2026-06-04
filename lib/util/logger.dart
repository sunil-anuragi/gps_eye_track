import 'dart:developer';
import 'package:flutter/foundation.dart';

void logger(dynamic msg) {
  if (kDebugMode) {
    log("$msg");
    print("$msg");
  }
}

void logPrint(dynamic msg) {
  if (kDebugMode) {
    print("$msg");
  }
}
