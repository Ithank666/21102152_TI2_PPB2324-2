import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF248EA9),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(100)),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Image.asset('assets/images/logoSIU.png', height: 75), // Ganti dengan path logo Anda
                Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Mulai Langkahmu Bareng SIU!',
                        style: TextStyle(
                          color: Color(0xFF248EA9),
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Untuk hidup lebih mudah dan terkoneksi\napa pun tujuanmu',
                        style: TextStyle(
                          color: Color(0xFF248EA9),
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 140.0), backgroundColor: Color(0xFF248EA9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 150.0), backgroundColor: Color(0xFF248EA9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
