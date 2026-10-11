import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'hms_mail_app.dart';

void main() {
  runApp(ProviderScope(child: const EnoughMailApp(appName: 'HMS Mail')));
}
