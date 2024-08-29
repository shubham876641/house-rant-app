// ignore_for_file: non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:house/constant/app_colors.dart';
import 'package:house/screens/forgot_password/forgot_passwrd.dart';
import 'package:house/screens/house_rent_home/house_rent_home.dart';
import 'package:house/screens/sign_up/sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool _isPasswordHidden = true;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "711692081196-2l79kb7ugt5813nafjgqos4ftnklvqht.apps.googleusercontent.com",
  );
  User? user;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {}
    setState(() {});
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      getUserData();
    } catch (e) {
      print('Error signing in with Google: $e');
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
                _bootomWidget(context),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _headerWidget(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Login",
            style: TextStyle(
                color: kBlueTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                height: 5),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter an email";
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return "Please enter a valid email";
              }
              return null;
            },
            controller: _emailController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                hintText: 'Enter Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a password";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
            obscureText: _isPasswordHidden,
            controller: _PasswordController,
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
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Enter Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ));
                  },
                  child: const Text("Forgot Password?"))),
        ],
      ),
    );
  }

  Widget _buttonWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          try {
            final UserCredential userCredential =
                await _auth.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _PasswordController.text);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green, content: Text("Success")));
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HouseRentHomeScreen(),
                ));
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
              "Login",
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

  Widget _bootomWidget(BuildContext context) {
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
            const Text("Don't have account? "),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ));
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ],
    );
  }
}
