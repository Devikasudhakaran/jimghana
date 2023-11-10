

import 'package:flutter/foundation.dart';

printInDebug(dynamic printInput) {
  if (kDebugMode) {
    print('$printInput');
  }
}