import 'package:flutter/material.dart';

class Beranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
      ),
      body: Center(
        child: Text('Selamat Datang di Beranda'),
      ),
    );
  }
}
