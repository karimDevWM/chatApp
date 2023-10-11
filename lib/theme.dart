import 'package:chat2/colors.dart';
import 'package:flutter/material.dart';

final myTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: kBlue),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: kBlue,
    iconTheme: IconThemeData(color: Colors.white),
  )
);