//

import 'package:flutter/material.dart';

class Pallet {
  Pallet._();
  static MaterialColor get primarySwatch => accentColor.toMaterialColor();
  static const accentColor = Color(0xFFB894B9);
  static const darkBK = Color(0xFF666666);
  static const lightBk = Color(0xFFCABFCA);
}

extension _Material on Color {
  Map<int, Color> _toSwatch() => {
        50: withOpacity(0.1),
        100: withOpacity(0.2),
        200: withOpacity(0.3),
        300: withOpacity(0.4),
        400: withOpacity(0.5),
        500: withOpacity(0.6),
        600: withOpacity(0.7),
        700: withOpacity(0.8),
        800: withOpacity(0.9),
        900: this,
      };

  MaterialColor toMaterialColor() => MaterialColor(
        value,
        _toSwatch(),
      );

  MaterialAccentColor toMaterialAccentColor() => MaterialAccentColor(
        value,
        _toSwatch(),
      );
}
