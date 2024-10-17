import 'dart:convert';

import '../utils/app_common_imports.dart';

extension StringUtil on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool isMinLength(int length) => (this?.length ?? 0) <= length;

  bool isEqualLength(int length) => (this?.length ?? 0) == length;

  bool get isValidEmail => RegExps.email.hasMatch(this ?? '');

  bool get isValidName => RegExps.name.hasMatch(this ?? '');

  bool get isValidPhoneNumber => RegExps.phoneNumber.hasMatch(this ?? '');

  bool get isValidPassword => RegExps.password.hasMatch(this ?? '');

  bool get isValidUrl => RegExps.url.hasMatch(this ?? '');

  String get toTitleCase => this == null ? '' : '${this![0].toUpperCase()}${this!.substring(1)}';

  String get toBase64 => base64.encode(utf8.encode(this ?? ''));
}
