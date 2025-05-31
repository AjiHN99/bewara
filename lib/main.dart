import 'package:bewara/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'view/splash_screen.dart'; // Pastikan file ini berada di direktori yang sama atau sesuaikan dengan lokasi file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      title: 'Bewara',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // Bisa disesuaikan
      ),
      home: const SignUpScreen(), // Menampilkan splash screen sebagai halaman awal
    );
  }
}
