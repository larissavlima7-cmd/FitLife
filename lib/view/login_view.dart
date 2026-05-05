import 'package:fitlife/view/dashboard_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 230, 201),
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 40),
            const SizedBox(width: 10),
            const Text("FitLife", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          const Icon(Icons.wb_sunny_outlined, color: Colors.black),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 120),
            const SizedBox(height: 30),
            TextField(decoration: InputDecoration(labelText: "Login", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 15),
            TextField(obscureText: true, decoration: InputDecoration(labelText: "Senha", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardView())),
              style: ElevatedButton.styleFrom(backgroundColor:Colors.green[200], minimumSize: Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text("Começar"),
            ),
          ],
        ),
      ),
    );
  }
}