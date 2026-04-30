import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitlife/controller/fitlive_provider.dart';
import 'package:fitlife/view/atividade_view.dart';

void main(List<String>args) {
  runApp(ChangeNotifierProvider(
    create:(context)=> FitliveProvider(),
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AtividadeView(),
    ),
  ));
}