import 'package:flutter/material.dart';

const kBorderRadius = Radius.circular(32.0);

final ThemeData kTheme = ThemeData(
  accentColor: kShrineBrown900,
  primaryColor: kShrinePink100,
  scaffoldBackgroundColor: kShrineBackgroundWhite,
  cardColor: kShrineBackgroundWhite,
  errorColor: kShrineErrorRed,
);

final ThemeData kDarkTheme = ThemeData(
  accentColor: Colors.black54,
  primaryColor: Colors.black87,
  scaffoldBackgroundColor: kShrineBackgroundWhite,
  cardColor: kShrineBackgroundWhite,
  errorColor: kShrineErrorRed,
  primaryTextTheme: ThemeData.dark().textTheme.copyWith(
        bodyText1: kWhiteTextStyle,
      ),
  accentTextTheme: ThemeData.dark().textTheme.copyWith(
        bodyText1: kWhiteTextStyle,
      ),
  textTheme: ThemeData.dark().textTheme.copyWith(
    bodyText1: kWhiteTextStyle,
  ),
);

final TextStyle kWhiteTextStyle = TextStyle(
  color: Colors.white,
);

final TextStyle kRedTextStyle = TextStyle(
  color: Colors.red,
);

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kShrineBrown900,
    primaryColor: kShrinePink100,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kShrinePink100,
      colorScheme: base.colorScheme.copyWith(
        secondary: kShrineBrown900,
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    cardColor: kShrineBackgroundWhite,
    errorColor: kShrineErrorRed,
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(color: kShrineBrown900),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}

const kShrinePink50 = Color(0xFFF4F4EF);
const kShrinePink100 = Color(0xFFDBDBD7);
const kShrinePink300 = Color(0xFFB5B5B1);
const kShrinePink400 = Color(0xFF757573);

const kShrineBrown900 = Color(0xFF363634);

const kShrineErrorRed = Color(0xFFC5032B);

const kShrineSurfaceWhite = Color(0xFFFFFBFA);
const kShrineBackgroundWhite = Colors.white;
