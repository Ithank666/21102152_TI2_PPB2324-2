import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String phoneNumber = '';

  String initialCountry = 'ID';
  PhoneNumber number = PhoneNumber(isoCode: 'ID');

  Future<void> _login() async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('phone', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nomor telepon tidak terdaftar.')),
        );
        return;
      }

      final userDoc = documents.first;
      final storedPassword = userDoc['password'];

      if (_passwordController.text == storedPassword) {
        Navigator.pushNamed(context, '/beranda');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password salah.')),
        );
      }
    } catch (e) {
      print('Error saat login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan saat login.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF248EA9), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Selamat datang di SIU',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Transfer uang ke banyak bank tanpa biaya admin. Isi ulang ke e-wallet gratis? Kami menangkapmu!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    setState(() {
                      phoneNumber = number.phoneNumber!;
                    });
                  },
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.DROPDOWN,
                  ),
                  initialValue: number,
                  textFieldController: _phoneController,
                  inputDecoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: '8123 4567 890',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text(
                         'Login',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF248EA9),
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 100.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 150),
                Image.asset(
                  'assets/images/amico.png',
                  width: 250,
                  height: 250,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
