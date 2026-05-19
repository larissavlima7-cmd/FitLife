import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitlife/controller/fitlive_provider.dart';
import 'package:fitlife/view/login_view.dart';

void main(List<String> args) {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FitliveProvider(),
      // O Consumer puxa as mudanças no FitliveProvider
      child: Consumer<FitliveProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,// Remove a faixa vermelhina de debug no canto da tela
            //configurações para cores dos temas claro e escuro
            themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(brightness: Brightness.light),
            darkTheme: ThemeData(brightness: Brightness.dark),
            //faz com que comece pela página de login
            home: const LoginView(),
          );
        }, 
      ), 
    ),
  ); 
}