import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uasmikail/login.dart';
import 'package:google_fonts/google_fonts.dart';

class Daftar extends StatefulWidget {
  const Daftar({Key? key}) : super(key: key);

  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = ''; // Variable to store error messages

  bool _isEmailValid(String email) {
    // Regex for email validation
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    return RegExp(emailRegex).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Daftar Page'),
      //   backgroundColor: Colors.blue, // Change AppBar background color
      // ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Daftar Akun!',
              style: GoogleFonts.poppins(fontSize: 26)
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(), // Add border to TextField
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(), // Add border to TextField
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

                if (_passwordController.text.length < 6) {
                  setState(() {
                    _errorMessage = 'Password harus memiliki setidaknya 6 karakter';
                  });
                  return;
                }

                try {
                  final result =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );

                  // If registration is successful, navigate to LoginPage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'email-already-in-use') {
                    setState(() {
                      _errorMessage = 'Email sudah digunakan';
                    });
                  } else {
                    setState(() {
                      _errorMessage = 'Error: ${e.message}';
                    });
                  }
                }
              },
              child: Text('Daftar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(116, 53, 242, 1), // Change button color
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text('Sudah punya akun? Login!'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}