import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat_app/constants/constants.dart';
import 'package:scholar_chat_app/screens/chat_screen.dart';
import 'package:scholar_chat_app/widgets/custom_button.dart';
import 'package:scholar_chat_app/widgets/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat_app/helper/show_snack_bar.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String id = "SignUpScreen";


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? password;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 100),
                Image.asset('assets/images/scholar.png', height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Row(
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: "Email",
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: "Password",
                  onChanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: "Sign Up",
                  onTap: () async {
                    if(_formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        Navigator.pushNamed(context, ChatScreen.id,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                              context, "The password provided is too weak.");
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                            "The account already exists for that email.",);
                        }
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }
                      isLoading = false;
                      setState(() {});
                    }
                    else {
                      showSnackBar(context, "Please enter all the fields");
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        " Sign In",
                        style: TextStyle(
                          color: Color(0xFFC7EDE6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
