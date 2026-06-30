import 'package:flutter/material.dart';

@immutable
class ZigloomGameTheme extends ThemeExtension<ZigloomGameTheme> {
  const ZigloomGameTheme({
    required this.blueGloss,
    required this.redGloss,
    required this.starGloss,
    required this.tileShadow,
    required this.buttonShadow,
    required this.redButtonShadow,
    required this.textShadow,
  });

  final LinearGradient blueGloss;
  final LinearGradient redGloss;
  final LinearGradient starGloss;
  final List<BoxShadow> tileShadow;
  final List<BoxShadow> buttonShadow;
  final List<BoxShadow> redButtonShadow;
  final List<Shadow> textShadow;

  @override
  ZigloomGameTheme copyWith({
    LinearGradient? blueGloss,
    LinearGradient? redGloss,
    LinearGradient? starGloss,
    List<BoxShadow>? tileShadow,
    List<BoxShadow>? buttonShadow,
    List<BoxShadow>? redButtonShadow,
    List<Shadow>? textShadow,
  }) {
    return ZigloomGameTheme(
      blueGloss: blueGloss ?? this.blueGloss,
      redGloss: redGloss ?? this.redGloss,
      starGloss: starGloss ?? this.starGloss,
      tileShadow: tileShadow ?? this.tileShadow,
      buttonShadow: buttonShadow ?? this.buttonShadow,
      redButtonShadow: redButtonShadow ?? this.redButtonShadow,
      textShadow: textShadow ?? this.textShadow,
    );
  }

  @override
  ZigloomGameTheme lerp(ThemeExtension<ZigloomGameTheme>? other, double t) {
    if (other is! ZigloomGameTheme) {
      return this;
    }

    return ZigloomGameTheme(
      blueGloss: LinearGradient.lerp(blueGloss, other.blueGloss, t)!,
      redGloss: LinearGradient.lerp(redGloss, other.redGloss, t)!,
      starGloss: LinearGradient.lerp(starGloss, other.starGloss, t)!,
      tileShadow: BoxShadow.lerpList(tileShadow, other.tileShadow, t)!,
      buttonShadow: BoxShadow.lerpList(buttonShadow, other.buttonShadow, t)!,
      redButtonShadow: BoxShadow.lerpList(
        redButtonShadow,
        other.redButtonShadow,
        t,
      )!,
      textShadow: Shadow.lerpList(textShadow, other.textShadow, t)!,
    );
  }
}

abstract final class AppTheme {
  static const blueHighlight = Color(0xFF3FD3FF);
  static const blueBase = Color(0xFF178FE6);
  static const blueDeep = Color(0xFF0846A8);
  static const inkBlue = Color(0xFF182C93);
  static const cyanPale = Color(0xFFBFEFFF);
  static const white = Color(0xFFFFFFFF);
  static const starYellow = Color(0xFFFFD629);
  static const starOrange = Color(0xFFF7A812);
  static const actionRed = Color(0xFFF1351E);
  static const actionOrange = Color(0xFFFF7A21);
  static const successGreen = Color(0xFF43C96B);

  static const tileRadius = 14.0;
  static const boardCellRadius = 10.0;
  static const buttonRadius = 16.0;
  static const panelRadius = 12.0;
  static const minTouchTarget = 48.0;

  static const _blueShadow = Color(0xFF063A91);
  static const _redShadow = Color(0xFFB51E15);
  static const _darkSurface = Color(0xFF06255F);
  static const _darkBackground = Color(0xFF031945);

  static ThemeData get lightTheme => _buildTheme(Brightness.light);
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: blueBase,
      brightness: brightness,
      primary: blueBase,
      secondary: starYellow,
      tertiary: actionRed,
      error: actionRed,
      surface: isDark ? _darkSurface : white,
      onPrimary: white,
      onSecondary: inkBlue,
      onTertiary: white,
      onSurface: isDark ? white : inkBlue,
    );

    final textTheme = _textTheme(isDark);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isDark ? _darkBackground : cyanPale,
      fontFamily: 'Nunito',
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? white : inkBlue,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(color: isDark ? white : inkBlue),
      ),
      iconTheme: IconThemeData(color: isDark ? white : inkBlue, size: 28),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(120, 52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          backgroundColor: blueBase,
          foregroundColor: white,
          disabledBackgroundColor: Color.alphaBlend(
            white.withValues(alpha: 0.42),
            blueBase,
          ),
          disabledForegroundColor: white.withValues(alpha: 0.72),
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(120, 52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          foregroundColor: isDark ? white : inkBlue,
          side: const BorderSide(color: blueBase, width: 2),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark ? starYellow : inkBlue,
          textStyle: textTheme.labelLarge,
          minimumSize: const Size(minTouchTarget, minTouchTarget),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: isDark ? white : inkBlue,
          minimumSize: const Size.square(minTouchTarget),
          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),
      cardTheme: CardThemeData(
        color: isDark ? _darkSurface : white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(panelRadius),
          side: BorderSide(
            color: isDark
                ? blueHighlight.withValues(alpha: 0.24)
                : blueBase.withValues(alpha: 0.22),
            width: 1.5,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark
            ? blueHighlight.withValues(alpha: 0.18)
            : blueDeep.withValues(alpha: 0.18),
        thickness: 1,
      ),
      extensions: <ThemeExtension<dynamic>>[_gameTheme(isDark)],
    );
  }

  static TextTheme _textTheme(bool isDark) {
    final baseColor = isDark ? white : inkBlue;

    return TextTheme(
      displayLarge: TextStyle(
        color: white,
        fontSize: 52,
        fontWeight: FontWeight.w900,
        height: 0.95,
        shadows: _titleShadow,
      ),
      displayMedium: TextStyle(
        color: white,
        fontSize: 40,
        fontWeight: FontWeight.w900,
        height: 1,
        shadows: _titleShadow,
      ),
      headlineLarge: TextStyle(
        color: baseColor,
        fontSize: 32,
        fontWeight: FontWeight.w900,
        height: 1.05,
      ),
      headlineMedium: TextStyle(
        color: baseColor,
        fontSize: 26,
        fontWeight: FontWeight.w800,
        height: 1.1,
      ),
      titleLarge: TextStyle(
        color: baseColor,
        fontSize: 22,
        fontWeight: FontWeight.w900,
        height: 1.1,
      ),
      titleMedium: TextStyle(
        color: baseColor,
        fontSize: 18,
        fontWeight: FontWeight.w800,
        height: 1.2,
      ),
      bodyLarge: TextStyle(
        color: baseColor,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.35,
      ),
      bodyMedium: TextStyle(
        color: baseColor,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.35,
      ),
      labelLarge: const TextStyle(
        color: white,
        fontSize: 16,
        fontWeight: FontWeight.w900,
        height: 1,
      ),
      labelMedium: TextStyle(
        color: baseColor,
        fontSize: 13,
        fontWeight: FontWeight.w800,
        height: 1.1,
      ),
    );
  }

  static ZigloomGameTheme _gameTheme(bool isDark) {
    final softShadowOpacity = isDark ? 0.42 : 0.28;

    return ZigloomGameTheme(
      blueGloss: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [blueHighlight, blueBase, blueDeep],
        stops: [0, 0.56, 1],
      ),
      redGloss: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [actionOrange, actionRed, _redShadow],
        stops: [0, 0.58, 1],
      ),
      starGloss: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFF06A), starYellow, starOrange],
        stops: [0, 0.58, 1],
      ),
      tileShadow: [
        const BoxShadow(color: _blueShadow, offset: Offset(0, 5)),
        BoxShadow(
          color: inkBlue.withValues(alpha: softShadowOpacity),
          blurRadius: 10,
          offset: const Offset(0, 7),
        ),
      ],
      buttonShadow: [
        const BoxShadow(color: _blueShadow, offset: Offset(0, 4)),
        BoxShadow(
          color: inkBlue.withValues(alpha: softShadowOpacity),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
      redButtonShadow: [
        const BoxShadow(color: _redShadow, offset: Offset(0, 4)),
        BoxShadow(
          color: actionRed.withValues(alpha: softShadowOpacity),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
      textShadow: _titleShadow,
    );
  }

  static const _titleShadow = [
    Shadow(color: inkBlue, blurRadius: 0, offset: Offset(3, 3)),
    Shadow(color: blueDeep, blurRadius: 8, offset: Offset(0, 3)),
  ];
}
