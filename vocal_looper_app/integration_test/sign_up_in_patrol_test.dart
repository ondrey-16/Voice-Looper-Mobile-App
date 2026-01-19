import 'dart:math';
import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:vocal_looper_app/main.dart' as app;

void main() {
  patrolTest('Sign up, sign out and sign in process', ($) async {
    await app.main();
    await $.pumpAndSettle();
    await $(Icons.menu).tap();
    await $(#signInTile).tap();
    await $(#createNewAccountButton).tap();

    final letters = 'abcdefghijklmnopqrstuvwxyz';
    final rand = Random();

    final emailPrefix = String.fromCharCodes(
      Iterable.generate(
        6,
        (_) => letters.codeUnitAt(rand.nextInt(letters.length)),
      ),
    );

    final email = '$emailPrefix@gmail.com';

    final nickname = String.fromCharCodes(
      Iterable.generate(
        10,
        (_) => letters.codeUnitAt(rand.nextInt(letters.length)),
      ),
    );

    final password = String.fromCharCodes(
      Iterable.generate(
        10,
        (_) => letters.codeUnitAt(rand.nextInt(letters.length)),
      ),
    );

    await $(#signUpPage).waitUntilVisible();
    await $(#nameField).enterText('Aaa');
    await $(#lastNameField).enterText('Bbb');
    await $(#nicknameField).enterText(nickname);
    await $(#birthdateField).tap();
    await $('OK').waitUntilVisible();
    await $('OK').tap();

    await $(#signUpNextButton).tap();

    await $(#emailField).enterText(email);
    await $(#passwordField).enterText(password);
    await $(#confirmPasswordField).enterText(password);

    await $(#signUpSubmitButton).tap();

    await $(Icons.menu).tap();
    await $(#signOutTile).waitUntilVisible();
    await $(#signOutTile).tap();

    await $(Icons.menu).tap();
    await $(#signInTile).waitUntilVisible();
    await $(#signInTile).tap();

    await $(#signInPage).waitUntilVisible();
    await $(#emailSignInField).enterText(email);
    await $(#passwordSignInField).enterText(password);
    await $(#loginButton).tap();

    await $(Icons.menu).tap();
    await $(#signOutTile).waitUntilVisible();
    await $(#signOutTile).tap();
  });
}
