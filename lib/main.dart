import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitlife/controller/fitlive_provider.dart';
import 'package:fitlife/view/login_view.dart';

void main(List<String> args) {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FitliveProvider(),
      child: Consumer<FitliveProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(brightness: Brightness.light),
            darkTheme: ThemeData(brightness: Brightness.dark),
            home: const LoginView(),
          );
        }, 
      ), 
    ),
  ); 
}