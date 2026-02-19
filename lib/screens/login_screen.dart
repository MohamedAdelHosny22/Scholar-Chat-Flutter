import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat_app/constants/constants.dart';
import 'package:scholar_chat_app/screens/chat_screen.dart';
import 'package:scholar_chat_app/screens/register_screen.dart';
import 'package:scholar_chat_app/widgets/custom_button.dart';
import 'package:scholar_chat_app/widgets/custom_text_field.dart';
import 'package:scholar_chat_app/helper/show_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: Colors.blue,
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
                      'Sign In',
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
                  text: "Sign In",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatScreen.id,
                            arguments: email
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                            context,
                            "No user found for that email.",
                          );
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(
                            context,
                            "Wrong password provided for that user.",
                          );
                        }
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }
                      isLoading = false;
                      setState(() {});
                    } else {

                      showSnackBar(context, "Please enter all the fields");
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: Text(
                        " Sign Up",
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

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
