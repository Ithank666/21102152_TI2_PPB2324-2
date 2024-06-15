import 'package:flutter/material.dart';

class InvestmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Investasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Reksa Dana'),
                subtitle: Text('Investasi reksa dana dengan potensi pertumbuhan tinggi.'),
                onTap: () {
                  // Implementasi logika investasi reksa dana
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('SBN Retail'),
                subtitle: Text('Surat Berharga Negara dengan bunga tetap.'),
                onTap: () {
                  // Implementasi logika investasi SBN Retail
                },
              ),
            ),
            // Tambahkan kartu investasi lainnya sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
