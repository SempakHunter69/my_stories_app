// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryYellow = Color(0xffFEFEA4);
const Color primaryYellow2 = Color(0xffF0DC28);
const Color primaryYellowDark = Color(0xffFFDC76);
const Color primaryDark = Color(0xff773838);
const Color textBlack = Color(0xff404040);
const Color textDarkGrey = Color(0xffbfbfbf);
final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(
      fontSize: 30, fontWeight: FontWeight.w600, letterSpacing: -1.5),
  headline2: GoogleFonts.poppins(
      fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -0.5),
  headline3: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.25),
  headline5: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
  headline6: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.15),
  subtitle1: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
