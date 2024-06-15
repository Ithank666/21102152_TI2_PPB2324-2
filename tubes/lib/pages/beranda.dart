import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tubes/pages/transfer.dart'; // Tambahkan import
import 'package:tubes/pages/investment_page.dart'; // Tambahkan import
import 'package:tubes/pages/profile.dart'; // Tambahkan import
import 'package:tubes/pages/qris_page.dart'; // Tambahkan import

class Beranda extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, String?>> _getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
      return {
        'nama': doc['nama'],
        'phone': doc['phone'],
      };
    }
    return {
      'nama': null,
      'phone': null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, String?>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          String? nama = snapshot.data?['nama'] ?? 'Nama tidak tersedia';
          String? phone = snapshot.data?['phone'] ?? 'Nomor telepon tidak tersedia';
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/icon/admin.png'), // Ganti dengan path gambar sampel
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nama,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'No. Telepon : $phone',
                            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.notifications, color: Color(0xFF248EA9)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromARGB(255, 176, 219, 255),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildCard(
                        context: context,
                        title: 'Saldo Tersedia',
                        subtitle: 'Rp 1.000.000',
                        trailingButtonText: 'Riwayat',
                        onPressed: () {},
                        height: 170,
                      ),
                      SizedBox(),
                      GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          _buildGridItemCard(Icons.send, 'Transfer', color: Colors.blue[50], textStyle: TextStyle(color: Colors.blue), onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TransferPage()));
                          }),
                          _buildGridItemCard(Icons.payment, 'Top up & Tagihan', color: Colors.green[50], textStyle: TextStyle(color: Colors.green)),
                          _buildGridItemCard(Icons.account_balance_wallet, 'Top up & E-Wallet', color: Colors.orange[50], textStyle: TextStyle(color: Colors.orange)),
                          _buildGridItemCard(Icons.history, 'Riwayat Transaksi', color: Colors.purple[50], textStyle: TextStyle(color: Colors.purple)),
                          _buildGridItemCard(Icons.trending_up, 'Investasi', color: Colors.red[50], textStyle: TextStyle(color: Colors.red), onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => InvestmentPage()));
                          }),
                          _buildGridItemCard(Icons.group, 'Undang Teman', color: Colors.yellow[50], textStyle: TextStyle(color: Colors.yellow[800])),
                          _buildGridItemCard(Icons.credit_card, 'Virtual Account', color: Colors.teal[50], textStyle: TextStyle(color: Colors.teal)),
                          _buildGridItemCard(Icons.more_horiz, 'Lainnya', color: Colors.pink[50], textStyle: TextStyle(color: Colors.pink)),
                        ],
                      ),
                      SizedBox(height: 40),
                      _buildInvestmentCard(context),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xFF248EA9),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => TransferPage()));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => QrisPage()));
              break;
            case 3:
              Navigator.push(context, MaterialPageRoute(builder: (context) => InvestmentPage()));
              break;
            case 4:
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              break;
            default:
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Transfer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'QRIS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Investasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String trailingButtonText,
    required VoidCallback onPressed,
    double width = double.infinity,
    double height = 150, // Sesuaikan tinggi
  }) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          Card(
            color: Color(0xFF248EA9),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Divider(color: Colors.white54),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pendapatan Bunga',
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Rp 37.000', // Contoh data, bisa diganti sesuai kebutuhan
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Suku Bunga',
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '2,5% p.a.', // Contoh data, bisa diganti sesuai kebutuhan
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 20,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(
                trailingButtonText,
                style: TextStyle(color: Color(0xFF248EA9)), // Ubah warna teks di sini
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Ubah warna button di sini
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1), // Sesuaikan padding
                textStyle: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentCard(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Produk Investasi'),
            trailing: TextButton(
              onPressed: () {},
              child: Text('Explore'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: [
                _buildInvestmentItem('assets/images/reksadana.png', 'Reksa Dana'), // Ganti dengan path gambar Anda
                _buildInvestmentItem('assets/images/sbnretail.png', 'SBN Retail'), // Ganti dengan path gambar Anda
                _buildInvestmentItem('assets/images/obligasifr.png', 'Obligasi FR'), // Ganti dengan path gambar Anda
                _buildInvestmentItem('assets/images/saham.png', 'Saham'), // Ganti dengan path gambar Anda
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItemCard(IconData icon, String label, {Color? color, TextStyle? textStyle, VoidCallback? onTap}) {
    return Card(
      color: color ?? Colors.white, // Warna background card dapat diatur
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 25, color: textStyle?.color ?? Color(0xFF248EA9)),
            SizedBox(height: 5),
            Text(label, textAlign: TextAlign.center, style: textStyle ?? TextStyle(color: Color(0xFF248EA9))),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestmentItem(String imagePath, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 35),
        SizedBox(height: 5),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }
}
