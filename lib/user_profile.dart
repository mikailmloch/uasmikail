import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uasmikail/login.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final auth = FirebaseAuth.instance;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile',
        style: GoogleFonts.poppins(),),
        backgroundColor: Color.fromRGBO(116, 53, 242, 1),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('Email'),
            subtitle: Text(auth.currentUser!.email!),
          ),
          ElevatedButton(
            onPressed: () async {
              await auth.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
