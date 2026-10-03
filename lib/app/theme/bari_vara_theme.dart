import 'package:flutter/material.dart';

/// Shared visual foundation derived from the Bari Vara UX design system.
abstract final class BariVaraTheme {
  static const Color _green = Color(0xFF008554);
  static const Color _darkGreen = Color(0xFF00633F);
  static const Color _mint = Color(0xFFE6F7EF);

  /// Light theme for the calm, high-contrast financial interface.
  static ThemeData light() {
    final ColorScheme colors = ColorScheme.fromSeed(
      seedColor: _green,
      brightness: Brightness.light,
      primary: _green,
      secondary: const Color(0xFF2F80ED),
      surface: Colors.white,
    );
    return _theme(colors);
  }

  /// Dark theme that preserves Bari Vara's information hierarchy.
  static ThemeData dark() {
    final ColorScheme colors = ColorScheme.fromSeed(
      seedColor: _green,
      brightness: Brightness.dark,
      primary: const Color(0xFF42C78B),
      secondary: const Color(0xFF8AB4F8),
    );
    return _theme(colors);
  }

  static ThemeData _theme(ColorScheme colors) {
    final TextTheme baseTextTheme = colors.brightness == Brightness.light
        ? Typography.material2021().black
        : Typography.material2021().white;
    final TextTheme textTheme = baseTextTheme.apply(
      bodyColor: colors.onSurface,
      displayColor: colors.onSurface,
      fontFamily: 'NotoSansBengali',
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colors,
      scaffoldBackgroundColor: colors.brightness == Brightness.light
          ? const Color(0xFFFAFCFB)
          : colors.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: colors.onSurface,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.outlineVariant),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(44, 48),
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        BariVaraPalette(
          successSurface: _mint,
          success: _darkGreen,
          danger: Color(0xFFD92D20),
        ),
      ],
    );
  }
}

/// Semantic colors for recurring financial states in the visual language.
class BariVaraPalette extends ThemeExtension<BariVaraPalette> {
  /// Creates a semantic Bari Vara color palette.
  const BariVaraPalette({
    required this.successSurface,
    required this.success,
    required this.danger,
  });

  /// Background for success/paid information.
  final Color successSurface;

  /// Foreground for success/paid information.
  final Color success;

  /// Foreground for due/destructive information.
  final Color danger;

  @override
  BariVaraPalette copyWith({
    Color? successSurface,
    Color? success,
    Color? danger,
  }) {
    return BariVaraPalette(
      successSurface: successSurface ?? this.successSurface,
      success: success ?? this.success,
      danger: danger ?? this.danger,
    );
  }

  @override
  BariVaraPalette lerp(ThemeExtension<BariVaraPalette>? other, double t) {
    if (other is! BariVaraPalette) {
      return this;
    }
    return BariVaraPalette(
      successSurface: Color.lerp(successSurface, other.successSurface, t)!,
      success: Color.lerp(success, other.success, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }
}
