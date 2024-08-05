import 'package:flutter/material.dart';
import 'dimensions.dart';

class AppTextStyles {
  static TextStyle get bodySmall => TextStyle(
    fontFamily: 'GoogleSans',
    fontSize: Dimensions.fontSize(14), // Use Dimensions for dynamic font size
    fontWeight: FontWeight.normal,
    color: Colors.black,

  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: 'GoogleSans',
    fontSize: Dimensions.fontSize(16), // Use Dimensions for dynamic font size
    fontWeight: FontWeight.normal,
    color: Colors.black,

  );

  static TextStyle get bodyLarge => TextStyle(
    fontFamily: 'GoogleSans',
    fontSize: Dimensions.fontSize(18), // Use Dimensions for dynamic font size
    fontWeight: FontWeight.bold,
    color: Colors.black,

  );
}