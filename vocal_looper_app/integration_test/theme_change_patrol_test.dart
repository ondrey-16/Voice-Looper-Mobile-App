import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:vocal_looper_app/main.dart' as app;

void main() {
  patrolTest('Changing theme process', ($) async {
    await app.main();
    await $.pumpAndSettle();
    await $(Icons.menu).tap();
    await $(#changeThemeTile).tap();
    await $(#changeThemeTile).tap();
  });
}
