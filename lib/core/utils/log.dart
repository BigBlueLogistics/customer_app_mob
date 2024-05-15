import 'package:flutter/foundation.dart';

/// Print [message] in the console if debug mode.
void log(Object message) {
  if (kDebugMode) {
    print(message);
  }
}
