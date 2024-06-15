import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataDiri extends StatefulWidget {
  @override
  _DataDiriState createState() => _DataDiriState();
}

class _DataDiriState extends State<DataDiri> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tglLahirController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none, children: [
                Container(
                  color: Color(0xFF248EA9),
                  height: 200,
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.1, right: 180, ),
                      child: Text(
                        'Registrasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 160,
                  left: MediaQuery.of(context).size.width / 2 - 40,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.camera_alt, size: 40, color: Colors.grey[800]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 60),
                  TextField(
                    controller: _namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      hintText: 'Nama kamu, cth: Asep Imortal',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _tglLahirController,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Lahir',
                      hintText: 'cth: 12 Desember 2012',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Email kamu, cth: asepcoklat@gmail.com',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _alamatController,
                    decoration: InputDecoration(
                      labelText: 'Alamat',
                      hintText: 'Alamat kamu, cth: Jakarta Timur, BKT',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Nomor Telepon',
                      hintText: 'cth. 08123456789',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Min. 8 karakter',
                      border: UnderlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Simpan data ke Firestore
                        try {
                          User? user = _auth.currentUser;
                          await _firestore.collection('users').doc(user!.uid).set({
                            'nama': _namaController.text,
                            'tanggal_lahir': _tglLahirController.text,
                            'email': _emailController.text,
                            'alamat': _alamatController.text,
                            'phone': _phoneController.text,
                            'password': _passwordController.text,
                          });
                          Navigator.pushNamed(context, '/beranda');
                        } catch (e) {
                          print('Gagal menyimpan data: $e');
                        }
                      },
                      
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white
                        ),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF248EA9),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
