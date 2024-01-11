import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uasmikail/earthquake_list.dart';
import 'package:uasmikail/navbar.dart';
import 'package:uasmikail/daftar.dart'; // Pastikan Anda mengimpor Daftar
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = ''; // Variabel untuk menyimpan pesan error

  bool _isEmailValid(String email) {
    // Regex untuk validasi email
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    return RegExp(emailRegex).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //       'Login Page',
      //       style: GoogleFonts.poppins(),),
      //   backgroundColor: Color.fromRGBO(116, 53, 242, 1), // Ubah warna AppBar
      // ),
      body: SingleChildScrollView( // Gunakan SingleChildScrollView agar konten dapat discroll jika melebihi layar
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              ClipOval(
                child: Container(
                  width: 300, // Lebar gambar
                  height: 300, // Tinggi gambar
                  child: Image.asset(
                    'lib/img/logomik.png',
                    fit: BoxFit.cover, // Ini akan memastikan gambar menyesuaikan ukuran container
                  ),
                ),
              ),
              SizedBox(height: 50,),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(), // Tambahkan border ke TextField
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(), // Tambahkan border ke TextField
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (!_isEmailValid(_emailController.text)) {
                    setState(() {
                      _errorMessage = 'Format email tidak valid';
                    });
                    return;
                  }

                  try {
                    UserCredential userCredential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    // Jika login berhasil, navigasikan ke Navbar(HomePage)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Navbar(userEmail: _emailController.text),
                      ),
                    );

                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      setState(() {
                        _errorMessage = 'Email tidak ditemukan';
                      });
                    } else if (e.code == 'wrong-password') {
                      setState(() {
                        _errorMessage = 'Password salah';
                      });
                    } else {
                      setState(() {
                        _errorMessage = 'Error: ${e.message}';
                      });
                    }
                  }
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(116, 53, 242, 1),  // Ubah warna tombol
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Daftar()),
                  );
                },
                child: Text('Belum mempunyai akun? Daftar!'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
