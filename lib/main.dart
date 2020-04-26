import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:own_dog/views/own_dog.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZoned(
    () {
      runApp(OwnDog());
    },
    onError: Crashlytics.instance.recordError,
  );
}
