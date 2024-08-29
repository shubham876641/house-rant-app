// ignore_for_file: avoid_print, use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:house/constant/app_colors.dart';
import 'package:house/screens/house_rent_home/house_rent_home.dart';
import 'package:house/screens/login/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isPasswordHidden = true;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "711692081196-2l79kb7ugt5813nafjgqos4ftnklvqht.apps.googleusercontent.com",
  );
  User? user;
  @override
  void initState() {
    super.initState();
    getUserData();
    print(" $getUserData");
  }

  void getUserData() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(
          'User Info: ${user!.displayName}, ${user!.email}, ${user!.photoURL}');
    }
    setState(() {});
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      getUserData();

      await _auth.signInWithCredential(credential);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HouseRentHomeScreen()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Signed in with Google"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error signing in with Google"),
        ),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: kBackgroudColor,
      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headerWidget(context),
                  SizedBox(
                    height: size.height / 5.10,
                  ),
                  _buttonWidget(context),
                  _dividerWidget(context),
                  _bottomWidget(context),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _headerWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sign Up",
          style: TextStyle(
              color: kBlueTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              height: 5),
        ),
        TextFormField(
          controller: _userNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a username";
            }
            return null;
          },
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              hintText: 'Enter Username',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        const SizedBox(
          height: 25,
        ),
        TextFormField(
          controller: _emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter an email";
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return "Please enter a valid email";
            }
            return null;
          },
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              hintText: 'Enter Email',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        const SizedBox(
          height: 25,
        ),
        TextFormField(
          controller: _passwordController,
          obscureText: _isPasswordHidden,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a password";
            }
            if (value.length < 6) {
              return "Password must be at least 6 characters";
            }
            return null;
          },
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                  icon: Icon(_isPasswordHidden
                      ? Icons.visibility
                      : Icons.visibility_off)),
              prefixIcon: const Icon(Icons.password),
              hintText: 'Enter Password',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ],
    );
  }

  Widget _buttonWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          try {
            final UserCredential userCredential =
                await _auth.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HouseRentHomeScreen(),
                ));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green, content: Text("Success")));
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red, content: Text("Error")));
            print(e);
          }
        }
      },
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
            color: const Color(0xff002140),
            borderRadius: BorderRadius.circular(20)),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dividerWidget(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              thickness: 1,
              color: Colors.grey,
              endIndent: 10,
            ),
          ),
          Text(
            'or with',
            style: TextStyle(color: Colors.grey),
          ),
          Expanded(
            child: Divider(
              thickness: 1,
              color: Colors.grey,
              indent: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: _signInWithGoogle,
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/google.png'),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/fb.png'),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account? "),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              },
              child: const Text("Sign In"),
            ),
          ],
        ),
      ],
    );
  }
}
