import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kHijau = Color(0xFFC6ECCF);
const kHitam = Color(0xFF111111);
const kPutih = Color(0xFFFFFFFF);
const kAbu   = Color(0xFF666666);

class AppTheme {
  AppTheme._();

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kPutih,
        appBarTheme: const AppBarTheme(
          backgroundColor: kPutih,
          foregroundColor: kHitam,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          titleTextStyle: TextStyle(
            color: kHitam,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kPutih,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kHitam, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFCCCCCC), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kHitam, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintStyle: const TextStyle(color: kAbu),
        ),
      );
}
