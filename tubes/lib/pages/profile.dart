import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, String?>> _getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
      return {
        'nama': doc['nama'],
        'tanggal_lahir': doc['tanggal_lahir'],
        'email': doc['email'],
        'alamat': doc['alamat'],
        'phone': doc['phone'],
      };
    }
    return {
      'nama': null,
      'tanggal_lahir': null,
      'email': null,
      'alamat': null,
      'phone': null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: FutureBuilder<Map<String, String?>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama: ${snapshot.data?['nama'] ?? 'Tidak tersedia'}'),
                SizedBox(height: 10),
                Text('Tanggal Lahir: ${snapshot.data?['tanggal_lahir'] ?? 'Tidak tersedia'}'),
                SizedBox(height: 10),
                Text('Email: ${snapshot.data?['email'] ?? 'Tidak tersedia'}'),
                SizedBox(height: 10),
                Text('Alamat: ${snapshot.data?['alamat'] ?? 'Tidak tersedia'}'),
                SizedBox(height: 10),
                Text('Nomor Telepon: ${snapshot.data?['phone'] ?? 'Tidak tersedia'}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
